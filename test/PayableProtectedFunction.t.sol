// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PayableProtectedFunction.sol";

contract PayableProtectedFunctionTest is Test {
    PayableProtectedFunction public payableProtectedFunction;
    function setUp() public {
        payableProtectedFunction = new PayableProtectedFunction();
    }

    // test:
    // calling payable as authorized user and non-authorized user
    // calling non-payable as authorized user and non-authorized user
    function testNonAuthorizedUser() public {
        address unauthorized = address(1);
        vm.startPrank(unauthorized);
        vm.expectRevert();

        payableProtectedFunction.nonPayableFunc();

        vm.expectRevert();
        payableProtectedFunction.payableFunc();

        vm.stopPrank();
    }

    function testAuthorizedUser() public {
        assertTrue(payableProtectedFunction.nonPayableFunc());

        assertTrue(payableProtectedFunction.payableFunc());
    }

}