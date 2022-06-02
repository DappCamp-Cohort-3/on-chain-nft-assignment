// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("A Melon NFT", "AMELON") Ownable() {}

    string[] private collection = [
        ""
    ];

    string[] private bodyColour = [
        "red",
        "yellow",
        "green",
        "blue",
        "orange",
        "purple"
    ];
    string[] private firstBaseLayerColour = [
        "red",
        "yellow",
        "green",
        "blue",
        "orange",
        "purple"
    ];
    string[] private secondBaseLayerColour = [
        "red",
        "yellow",
        "green",
        "blue",
        "orange",
        "purple"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        string memory input = string(abi.encodePacked(tokenId, keyPrefix));
        uint256 randomValue = random(input);
        return sourceArray[randomValue % sourceArray.length];
    }

    function tokenURI(uint256 tokenId) public override view returns (string memory) {
        //string memory p1 = '<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 511.998 511.998" style="enable-background:new 0 0 511.998 511.998;" xml:space="preserve"> <path style="fill:';
        string memory p1 = '<svg xmlns="http://www.w3.org/2000/svg"  preserveAspectRatio="xMinYMin meet" viewBox="0 0 511.998 511.998">';
        string memory bodyRandomColour = pluck(tokenId, "bodyColour", bodyColour);
        string memory p2 = '" d="M471.734,441.241L276.208,14.207c-8.696-18.999-35.71-18.926-44.31,0.116L39.104,441.241H471.734z"/>';
        // First base layer
        string memory p3 = '<polygon style="fill:';
        string memory firstBaseLayerRandomColour = pluck(tokenId, "firstBaseLayerColour", firstBaseLayerColour);
        string memory p4 = '" points="39.104,441.241 471.734,441.241 480.36,460.947 30.534,460.947 "/>';

        // Second base layer
        string memory p5 = '<path style="fill:';
        string memory secondBaseLayerRandomColour = pluck(tokenId, "secondBaseLayerColour", secondBaseLayerColour);
        string memory p6 = '"d="M30.534,460.947l-12.165,24.575c-6.034,12.188,2.835,26.477,16.436,26.477H477.19c13.891,0,22.739-14.843,16.134-27.057l-12.968-23.994H30.534z"/>';

        // Seeds
        string memory seeds = '<g> <ellipse style="fill:#563824;" cx="262.51" cy="114.534" rx="12.307" ry="21.949"/> <ellipse style="fill:#563824;" cx="301.377" cy="202.667" rx="12.307" ry="21.949"/> <ellipse style="fill:#563824;" cx="261.547" cy="245.782" rx="12.307" ry="21.949"/> <ellipse style="fill:#563824;" cx="227.261" cy="268.591" rx="12.307" ry="21.949"/> <ellipse style="fill:#563824;" cx="343.032" cy="290.523" rx="12.307" ry="21.946"/> <ellipse style="fill:#563824;" cx="214.947" cy="180.727" rx="12.307" ry="21.949"/> <ellipse style="fill:#563824;" cx="173.624" cy="290.523" rx="12.307" ry="21.946"/> <ellipse style="fill:#563824;" cx="273.861" cy="334.435" rx="12.307" ry="21.949"/></g></svg>';

        string memory watermelon = Base64.encode(abi.encodePacked(p1, bodyRandomColour, p2, p3, firstBaseLayerRandomColour, p4, p5, secondBaseLayerRandomColour, p6, seeds));
        string memory metadata = Base64.encode(abi.encodePacked('{"name": "Watermelon #', Strings.toString(tokenId), '", "description": "This is a watermelon", "image": "data:image/svg+xml;base64,', watermelon, '"}'));
        return string(abi.encodePacked('data:application/json;base64,', metadata));
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}