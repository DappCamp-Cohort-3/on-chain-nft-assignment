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
        "Lagos", "London", "UAE", "Punta Cana", "Georgia"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 randomNumber = random(string(abi.encodePacked(keyPrefix, tokenId)));
        string memory output = sourceArray[randomNumber % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory svgFirstPart ='<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="blue" /><text x="10" y="120" class="base">';
        string memory svgSecondPart ='</text></svg>';
        string memory keyPrefix = "Locations";
        string memory svgContent = pluck(tokenId, keyPrefix, collection);
        string memory svgString = string(abi.encodePacked(svgFirstPart, svgContent, svgSecondPart));

        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Places and locations", "description": "This is about different locations", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(svgString)), '"}'))));
        string memory jsonWithPrefix = string(abi.encodePacked('data:application/json;base64,', json));

        return jsonWithPrefix;
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}