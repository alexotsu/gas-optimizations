// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StateVariablesInStack.sol";

contract StateVariablesTest is Test {
    StateVariables public stateVariables;
    uint public loops;

    function setUp() public {
        stateVariables = new StateVariables(10);
        loops = 10;
    }


    function testBaseCase() public {
        uint baseCase = stateVariables.stateVar();
    }

    function testCache() public {
        uint cache = stateVariables.cache_stateVar(loops);
    }
    function testNoCache() public {
        uint noCache = stateVariables.noCache_stateVar(loops);
    }
}
