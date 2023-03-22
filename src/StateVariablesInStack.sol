// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract StateVariables {
    uint public stateVar;

    constructor(uint _v) {
        stateVar = _v;
    }

    function noCache_stateVar(uint loops) public view returns(uint mutatedVal) {
        for(uint i = 0; i < loops; ++i) {
            mutatedVal += stateVar;
        }
    }

    function cache_stateVar(uint loops) public view returns(uint mutatedVal) {
        uint cachedVar = stateVar;
        for(uint i = 0; i < loops; ++i) {
            mutatedVal += cachedVar;
        }
    }
}