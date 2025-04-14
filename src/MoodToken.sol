// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodToken is ERC721 {
    //error
    error MoodToken__CantFlipMoodIfNotOwner();

    uint256 public s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        Happy,
        Sad
    }

    mapping(uint256 => Mood) public s_idToMood;

    constructor(string memory happy, string memory sad) ERC721("Happy%Sad", "H&S") {
        s_happySvgImageUri = happy;
        s_sadSvgImageUri = sad;
        s_tokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_idToMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        // ✅ Fix: Allow both owner and approved address to flip mood
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodToken__CantFlipMoodIfNotOwner();
        }

        if (s_idToMood[tokenId] == Mood.Happy) {
            s_idToMood[tokenId] = Mood.Sad;
        } else {
            s_idToMood[tokenId] = Mood.Happy;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_idToMood[tokenId] == Mood.Happy) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }
//0x3d8b27F37f875b82863633c59C6d446440F342c0
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "Mood", "value": "',
                            s_idToMood[tokenId] == Mood.Happy ? "Happy" : "Sad",
                            '"}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
