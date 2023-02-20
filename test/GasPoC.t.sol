// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ZeroAddressGasComp.sol";

contract GasPoCTest is Test {
    ZeroAddressGasComp public zeroAddressGasComp;

    function setUp() public {
        zeroAddressGasComp = new ZeroAddressGasComp();
    }

    function testCheckZero() public {
        vm.expectRevert(bytes4(0xd92e233d));
        zeroAddressGasComp.solidity_notZero(address(0));

        vm.expectRevert();
        zeroAddressGasComp.errorString_notZero(address(0));

        vm.expectRevert(bytes4(0xd92e233d));
        zeroAddressGasComp.assembly_notZero(address(0));
    }
}
