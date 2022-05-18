// SPDX-License-Identifier: MIT
pragma solidity ^0.6.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("Shreya's DappCamp NFT", "DCAMP") Ownable() {}

    string[] private collection = [
        "mediumpurple",
        "orchid",
        "indigo",
        "lavender",
        "thistle"
    ];

    function random(string memory input) internal pure returns (uint256) {
       return keccak256(abi.encodePacked(input));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[3] memory parts;
        // keccak256
        parts[0] = '<svg width="150" height="150">';
        parts[1] = '<circle cx="75" cy="75" r="50" fill="lavender" />';
        parts[2] = '</svg>';

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Color:', toString(tokenId), '", "description": "Purple polka dots are on chain NFTs I made for Dapp Camp.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;

    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}