// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract NoDefaultValue {
    function withoutDefault(uint loops) public pure returns(uint v) {
        for(uint i; i < loops; ++i) {
            v = i;
        }
    }

    function withDefault(uint loops) public pure returns(uint v) {
        for(uint i = 0; i < loops; ++i) {
            v = i;
        }
    }
}