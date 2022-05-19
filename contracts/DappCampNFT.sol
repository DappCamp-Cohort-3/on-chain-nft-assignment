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
        "Lisboa", 
        "Porto",
        "Aveiro",
        "Faro",
        "Coimbra",
        "Beja"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint random_number = random(string(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory result = sourceArray[random_number % sourceArray.length];
        return result;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory var_pluck = pluck(tokenId, "Lisboa", collection);
       // uint var_random = random(var_pluck);

        string memory output = string(abi.encode('<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="blue" />', var_pluck ,'</svg>'));

        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Lisbon', Strings.toString(tokenId), '", "description": "Capital of Portugal", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:image/svg+xml;base64,', json));

        return output;
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }

}