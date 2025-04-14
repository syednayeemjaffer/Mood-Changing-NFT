// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script, console} from "lib/forge-std/src/Script.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";
import {MoodToken} from "src/MoodToken.sol";

contract DeployScript is Script {
    MoodToken moodToken;

    function run() external returns (MoodToken) {
        string memory sadSvg = vm.readFile("./img/Sad.svg");
        string memory happySvg = vm.readFile("./img/Happy.svg"); // Fixed typo

        vm.startBroadcast();

        moodToken = new MoodToken(svgToImgURI(happySvg), svgToImgURI(sadSvg));

        vm.stopBroadcast();
        return moodToken;
    }

    function svgToImgURI(string memory svg) public pure returns (string memory) {
        string memory baseURl = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));

        return string(abi.encodePacked(baseURl, svgBase64Encoded));
    }
}
