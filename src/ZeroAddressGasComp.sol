// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ZeroAddressGasComp {

    error ZeroAddress();

    function SolidityIsNotZeroAddress(address toCheck) public pure returns(bool success) {
        if(toCheck == address(0)) revert ZeroAddress();

        return true;
    }

    function AssemblyIsNotZeroAddress(address toCheck) public pure returns(bool success) {
        assembly {
            if iszero(toCheck) {
                let ptr := mload(0x40)
                mstore(ptr, 0xd92e233d00000000000000000000000000000000000000000000000000000000) // selector for `ZeroAddress()`
                revert(ptr, 0x4)
            }
        }

        return true;
    }
}
