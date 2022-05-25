// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 7;

    constructor() ERC721("Shreya's DappCamp NFT", "DCAMP") Ownable() {}

    string[] private collection = [
        "mediumpurple",
        "orchid",
        "indigo",
        "lavender",
        "thistle",
        "lightpurple",
        "purple"
    ];

    function random(string memory input) internal pure returns (uint256) {
       return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[5] memory parts;
        // keccak256
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg"  preserveAspectRatio="xMinYMin meet" viewBox="0 0 800 800"><rect width="90" height="90" fill="white" />';
        parts[1] = '<circle cx="75" cy="75" r="50" fill="';
        parts[2] = pluck(tokenId, "temp", collection);
        parts[3] = '" />';
        parts[4] = '</svg>';

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Color:', Strings.toString(tokenId), '", "description": "Purple polka dots are on chain NFTs I made for Dapp Camp.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;

    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}