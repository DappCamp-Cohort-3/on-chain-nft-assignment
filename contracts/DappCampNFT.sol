// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;


    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}

    string[] private collection = [
        "Mentor",
        "Camper",
        "Student",
        "Coach"
    ];



    function toString(uint256 value) internal pure returns (string memory) {

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, tokenId)));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory svgFirstPart ='<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="blue" /><text x="10" y="120" class="base">';
        string memory svgContent = pluck (tokenId, "DappCamp Roles", collection);
        string memory svgLastPart = '</text></svg>';
        string memory svg = string(abi.encodePacked(svgFirstPart, svgContent, svgLastPart));

        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "DappCamp Roles", "description": "Defines your role in Dappcamp", "image": "data:image/svg+xml;base64, ',Base64.encode(bytes(svg)), '"}'))));

        string memory output = string(abi.encodePacked("data:application/json;base64,", json));
        return output;
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}
