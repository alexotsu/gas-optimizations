// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BoolsInStorageComp.sol";

contract BoolsInStorageCompTest is Test {
    BoolsInStorageComp public boolsInStorageComp;
    address public bob;
    function setUp() public {
        boolsInStorageComp = new BoolsInStorageComp();
        bob = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    }

    function testBools() public {
        boolsInStorageComp.storeBool(bob);
        bool v = boolsInStorageComp.readBool(bob);
        assertTrue(v);

        boolsInStorageComp.resetBool(bob);
        v = boolsInStorageComp.readBool(bob);
        assertTrue(!v);

        boolsInStorageComp.storeBool(bob);
        v = boolsInStorageComp.readBool(bob);
        assertTrue(v);
    }

    function testUints() public {
        boolsInStorageComp.storeUint(bob);
        uint v = boolsInStorageComp.readUint(bob);
        assertEq(v, 2);

        boolsInStorageComp.resetUint(bob);
        v = boolsInStorageComp.readUint(bob);
        assertEq(v, 1);
        
        boolsInStorageComp.storeUint(bob);
        v = boolsInStorageComp.readUint(bob);
        assertEq(v, 2);
    }

}