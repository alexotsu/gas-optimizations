// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NoDefaultValue.sol";

contract NoDefaultValueTest is Test {
    NoDefaultValue public noDefaultValue;

    function setUp() public {
        noDefaultValue = new NoDefaultValue();
    }

    function testReturnVals() public {
        uint loops = 10;
        uint withoutDefault = noDefaultValue.withoutDefault(loops);
        uint withDefault = noDefaultValue.withDefault(loops);
        assertEq(withoutDefault, withDefault);
    }
}
