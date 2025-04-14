// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {DeployScript} from "script/DeployScript.s.sol";
import {MoodToken} from "src/MoodToken.sol";

contract DeployMoodNftInteractionTest is Test {
    DeployScript deployScript;
    MoodToken moodToken;

    address public USER = makeAddr("USER");

    function setUp() public {
        deployScript = new DeployScript();
        moodToken = deployScript.run();
    }

    function testfliptoken() public {
        vm.prank(USER);
        moodToken.mintNft();

        vm.prank(USER);
        moodToken.flipMood(0);

        vm.prank(USER);
        moodToken.flipMood(0);
        string memory actualHash = string(abi.encode(moodToken.tokenURI(0)));
        console.log(actualHash);
    }
}