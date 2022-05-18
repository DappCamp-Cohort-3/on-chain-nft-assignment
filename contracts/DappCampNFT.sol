// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;
    string svgPartOne ='<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="blue" /><text x="10" y="120" class="base">';
    string svgPartTwo ='</text></svg>';

    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}

    string[] private collection = [
        "hat", "wand","cloak","cat","broom","owl"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
        
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint randLength = random(string(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory output = sourceArray[randLength % sourceArray.length];
        return output;
        

    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory pluckOutput = pluck(tokenId,"WIZARD",collection);
        uint randomNumber = random(pluckOutput);
        string memory finalSvg=string(abi.encodePacked(svgPartOne,randomNumber,svgPartTwo));
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Wizard World', Strings.toString(tokenId), '", "description": "it is consist of all the instruments required to attain Wizarding school of Hogwarts", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(finalSvg)), '"}'))));
        string memory finalOutput = string(abi.encodePacked('data:application/json;base64,', json));


        return finalOutput;
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}