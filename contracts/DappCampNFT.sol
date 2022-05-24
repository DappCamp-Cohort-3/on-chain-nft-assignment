// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("DappCamp NFT", "BANDCAMP") Ownable() {

    }

    string[] private bands = ["The Beatles",
    "The Beach Boys",
    "Bob Dylan",
    "Marvin Gaye",
    "The Rolling Stones"
    ];

    string[] private albums = ["Sgt. Peppers Lonely Hearts Club Band",
    "Pet Sounds",
    "Highway 61 Revisited",
    "Whats Going On",
    "Exile on Main St."
    ];


    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }


    function getAlbum(uint256 tokenId) public view returns (string memory){
        return pluck(tokenId, "albums", albums);
    }

    function getBand(uint256 tokenId) public view returns (string memory){
        return pluck(tokenId, "bands", bands);
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }


    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[5] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';
        parts[1] = getAlbum(tokenId);
        parts[2] = '</text><text x="10" y="40" class="base">';
        parts[3] = getBand(tokenId);
        parts[4] = '</text></svg>';
        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4]));
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Album-Song :', Strings.toString(tokenId), '", "description": "Classic Rock Top 5","image":"data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"} '))));
        output = string(abi.encodePacked('data:application/json;base64,', json));
        return output;


    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}