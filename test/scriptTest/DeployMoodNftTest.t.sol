// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {DeployScript} from "script/DeployScript.s.sol";
import {MoodToken} from "src/MoodToken.sol";

contract DeployMoodNftTest is Test {
    DeployScript deployScript;
    MoodToken moodToken;

    function setUp() public {
        deployScript = new DeployScript();
        moodToken = deployScript.run();
    }

    function testsvgToImgURI() public view returns (string memory) {
        string memory happySvg =
            '<svg viewBox="0 0 200 200" width="400"  height="400" xmlns="http://www.w3.org/2000/svg"> <circle cx="100" cy="100" fill="yellow" r="78" stroke="black" stroke-width="3"/> <g class="eyes"> <circle cx="70" cy="82" r="12"/> <circle cx="127" cy="82" r="12"/> </g> <path d="m136.81 116.53c.69 26.17-64.11 42-81.52-.73" style="fill:none; stroke: black; stroke-width: 3;"/> </svg>';

        string memory result = deployScript.svgToImgURI(happySvg);
        return result;
    }
    
}
