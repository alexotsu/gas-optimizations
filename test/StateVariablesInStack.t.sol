// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StateVariablesInStack.sol";

contract StateVariablesTest is Test {
    StateVariables public stateVariables;

    function setUp() public {
        stateVariables = new StateVariables(10);
    }

    function testReturnVals() public {
        uint loops = 2;
        uint noCache = stateVariables.noCache_stateVar(loops);
        uint cache = stateVariables.cache_stateVar(loops);
        assertEq(noCache, cache);
    }
}
