// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CacheArrayLength {
    function memory_noCache(uint[] memory val) public pure returns(uint end) {
        for(uint i = 0; i < val.length; ++i) {
            end = val[i];
        }
    }

    function memory_cachedOutsideLoop(uint[] memory val) public pure returns(uint end) {
        uint len = val.length;
        for(uint i = 0; i < len; ++i) {
            end = val[i];
        }
    }

    uint[] vals;

    function populateVals(uint idx) public {
        for(uint i = 0; i < idx; ++i) {
            vals.push(i);
        }
    }

    function storage_noCache() public view returns(uint end) {
        for(uint i = 0; i < vals.length; ++i) {
            end = vals[i];
        }
    }

    function storage_cachedOutsideLoop() public view returns(uint end) {
        uint len = vals.length;
        for(uint i = 0; i < len; ++i) {
            end = vals[i];
        }
    }
}