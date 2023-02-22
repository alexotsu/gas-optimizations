// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract StateVariables {
    uint public v;

    constructor(uint _v) {
        v = _v;
    }

    function noCache_stateVar(uint loops) public view returns(uint mutatedVal) {
        for(uint i = 0; i < loops; ++i) {
            mutatedVal += v;
        }
    }

    function cache_stateVar(uint loops) public view returns(uint mutatedVal) {
        uint cachedVar = v;
        for(uint i = 0; i < loops; ++i) {
            mutatedVal += cachedVar;
        }
    }
}