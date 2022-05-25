// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 20;

    constructor() ERC721("Bell NFT", "BELL") Ownable() {}

    string[] private bellHangerColour = [
        "red",
        "yellow",
        "green",
        "blue",
        "orange",
        "purple"
    ];
    string[] private bellTongueColour = [
        "red",
        "yellow",
        "green",
        "blue",
        "orange",
        "purple"
    ];
    string[] private bellColour = [
        "red",
        "yellow",
        "green",
        "blue",
        "orange",
        "purple"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        string memory input = string(abi.encodePacked(tokenId, keyPrefix));
        uint256 randomValue = random(input);
        return sourceArray[randomValue % sourceArray.length];
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory p1 = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" width="200" height="200" viewBox="-100 -100 200 200"><g stroke="#001514" stroke-width="2">';
        string memory p2 = '<circle cx="0" cy="-45" r="7" style="fill:';
        string memory bellHangerRandomColour = pluck(tokenId, "bellHangerColour", bellHangerColour);
        string memory p3 = '" />';
        string memory p4 = '<circle cx="0" cy="50" r="10" style="fill:';
        string memory bellRandomColour = pluck(tokenId, "bellColour", bellColour);
        string memory p5 = '" />';
        string memory p6 = '<path d="M -50 40 L -50 50 L 50 50 L 50 40 Q 40 40 40 10 C 40 -60 -40 -60 -40 10 Q -40 40 -50 40" style="fill:';
        string memory bellTongueRandomColour = pluck(tokenId, "bellTongueColour", bellTongueColour);
        string memory p7 = '"/></g></svg>';

        string memory bell = Base64.encode(abi.encodePacked(p1, p2, bellHangerRandomColour, p3, p4, bellRandomColour, p5, p6, bellTongueRandomColour, p7));
        string memory metadata = Base64.encode(abi.encodePacked('{"name": "Bell #', Strings.toString(tokenId), '", "description": "This is a bell", "image": "data:image/svg+xml;base64,', bell, '"}'));
        return string(abi.encodePacked('data:application/json;base64,', metadata));
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}