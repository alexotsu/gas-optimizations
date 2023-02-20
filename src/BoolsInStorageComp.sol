// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BoolsInStorageComp {
    mapping(address => bool) private mappedToBool;
    mapping(address => uint) private mappedToUint;

    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.
    function storeBool(address addr) public {
        mappedToBool[addr] = true;
    }

    function storeUint(address addr) public {
        mappedToUint[addr] = 2;
    }

    function resetBool(address addr) public {
        mappedToBool[addr] = false;
    }

    function resetUint(address addr) public {
        mappedToUint[addr] = 1;
    }

    function readBool(address addr) public view returns(bool mappedVal) {
        mappedVal = mappedToBool[addr];
    }

    function readUint(address addr) public view returns(uint mappedVal) {
        mappedVal = mappedToUint[addr];
    }
}