# Introduction
Upon reading a report on known [gas optimizations for an audit](https://gist.github.com/Picodes/b3c3bc8df01afc2b649534da8007af88), I realized there were no demonstrations of the optimizations themselves. This document is proof-of-concept code implementing the recommendations and showing the gas comparisons.

# Reproducing
Clone this repo and run `forge test --gas-report`

## [GAS-1] Use assembly to check for `address(0)`
| src/ZeroAddressGasComp.sol:ZeroAddressGasComp contract |                 |     |        |     |         |
|--------------------------------------------------------|-----------------|-----|--------|-----|---------|
| Function Name                                          | min             | avg | median | max | # calls |
| AssemblyIsNotZeroAddress                               | 310             | 310 | 310    | 310 | 1       |
| SolidityIsNotZeroAddress                               | 324             | 324 | 324    | 324 | 1       |

## [GAS-2] Using bools for storage incurs overhead
### Tests:
#### Storing a Boolean
1. Flipping a `mapping(address => bool)` slot from `false` to `true`
2. Reading that mapping slot
3. Flipping it back to `false`
4. Flipping it back to `true`

#### Storing a Uint
1. Flipping a `mapping(address => uint)` slot from `0` to `2`
2. Reading that mapping slot
3. Flipping it from `2` to `1` (where DApps reading it would have to know that both `0` and `1` was false, and `2` is true)
4. Flipping it back to `2`

| src/BoolsInStorageComp.sol:BoolsInStorageComp contract |                 |       |        |       |         |
|--------------------------------------------------------|-----------------|-------|--------|-------|---------|
| Function Name                                          | min             | avg   | median | max   | # calls |
| readBool                                               | 561             | 561   | 561    | 561   | 3       |
| readUint                                               | 491             | 491   | 491    | 491   | 3       |
| resetBool                                              | 519             | 519   | 519    | 519   | 1       |
| resetUint                                              | 429             | 429   | 429    | 429   | 1       |
| storeBool                                              | 20488           | 21488 | 21488  | 22488 | 2       |
| storeUint                                              | 514             | 11514 | 11514  | 22514 | 2       |

Couple of interesting takeaways from this one:
1. Across the board, it is cheaper to read a uint value than a bool.
2. Using a non-zero value for both false (i.e. `1`) **and** true (`2`) saves gas on all subsequent flip-flops from false to true. It is more expensive initially to change the default `0` value to a non-zero (see the _max_ column for `storeUint`), but ~20x cheaper to change a non-zero value to another non-zero after setting it initially (see _min_ column for `storeUint`).


## [GAS-3] Cache array length outside of loop
| src/CacheArrayLength.sol:CacheArrayLength contract |                 |         |         |          |         |
|----------------------------------------------------|-----------------|---------|---------|----------|---------|
| Function Name                                      | min             | avg     | median  | max      | # calls |
| memory_cachedOutsideLoop                           | 1888            | 62033   | 62033   | 122178   | 2       |
| memory_noCache                                     | 1873            | 62760   | 62760   | 123648   | 2       |
| populateVals                                       | 114458          | 5669595 | 5669595 | 11224733 | 2       |
| storage_cachedOutsideLoop                          | 2317            | 100574  | 100574  | 198832   | 2       |
| storage_noCache                                    | 2878            | 125885  | 125885  | 248893   | 2       |

Caching the array length requires creating a new variable in memory, which costs gas. So for small arrays in memory, it appears to be more gas-efficient to just make repeated calls to the `length` property of the array (see the _min_ column of `memory_noCache` vs the _min_ column of `memory_cachedOutsideLoop`). For larger arrays (see _max_ column of both `memory_noCache` and `memory_cachedOutsideLoop`) and for arrays of basically all sizes in storage (see both function names that start with `storage`), it is better practice to cache the array length outside the loop.

Note that the effect is the opposite when the array is stored in `calldata` - re-reading the array's length is slightly cheaper because you do not need to expand memory to make a variable that caches the length.