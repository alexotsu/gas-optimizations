// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CacheArrayLength.sol";

contract CacheArrayLengthTest is Test {
    CacheArrayLength public cacheArrayLength;
    // uint counter = 10;
    uint[] vals;

    function setUp() public {
        cacheArrayLength = new CacheArrayLength();
    }

    function testCachePerformanceLowReps() public {
        uint counter = 5;
        for(uint i = 0; i < counter; ++i) {
            vals.push(i);
        }
        uint vNoCache = cacheArrayLength.memory_noCache(vals);
        assertEq(vNoCache, counter - 1);

        uint vCache = cacheArrayLength.memory_cachedOutsideLoop(vals);
        assertEq(vCache, counter - 1);

        cacheArrayLength.populateVals(counter);
        
        uint vStorageNoCache = cacheArrayLength.storage_noCache();
        assertEq(vStorageNoCache, counter - 1);

        uint vStorageCache = cacheArrayLength.storage_cachedOutsideLoop();
        assertEq(vStorageCache, counter - 1);
    }

    function testCachePerformanceHighReps() public {
        uint counter = 500;
        for(uint i = 0; i < counter; ++i) {
            vals.push(i);
        }
        uint vNoCache = cacheArrayLength.memory_noCache(vals);
        assertEq(vNoCache, counter - 1);

        uint vCache = cacheArrayLength.memory_cachedOutsideLoop(vals);
        assertEq(vCache, counter - 1);

        cacheArrayLength.populateVals(counter);

        uint vStorageNoCache = cacheArrayLength.storage_noCache();
        assertEq(vStorageNoCache, counter - 1);

        uint vStorageCache = cacheArrayLength.storage_cachedOutsideLoop();
        assertEq(vStorageCache, counter - 1);
    }
}
