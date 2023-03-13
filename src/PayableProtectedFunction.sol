// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import 'openzeppelin-contracts/contracts/access/Ownable.sol';

contract PayableProtectedFunction is Ownable {
    function nonPayableFunc() public onlyOwner returns(bool allowed) {
        allowed = true;
    }

    function payableFunc() public payable onlyOwner returns(bool allowed) {
        allowed = true;
    }
}