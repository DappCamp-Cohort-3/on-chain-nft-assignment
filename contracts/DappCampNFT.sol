// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("Rap Rotation NFT", "RapNFT") Ownable() {}

    string[] private eminem = [
        "Rap God",
        "Till I Collapse",
        "The Real Slim Shady",
        "Lose Yourself",
        "No Love",
        "Space Bound",
        "Fight Music"
    ];

    string [] private ye = [
        "On Sight",
        "Black Skinhead",
        "All Day",
        "Off The Grid",
        "Two Words",
        "Jesus Walks",
        "Father Stretch My Hands Pt. 1"
    ];

    string[] private doom = [
        "Great Day",
        "All Caps",
        "Doomsday",
        "?",
        "Anti-Matter",
        "Red and Gold",
        "Go with the Flow"
    ];

    string[] private jayz = [
        "Jigga What/Faint (ft. Linkin Park)",
        "Dirt Off Your Shoulders",
        "Crown",
        "Otis",
        "F.U.T.W.",
        "Dead Presidents",
        "Ignorant Shit"
    ];

    string [] private drake = [
        "6 God",
        "Underground Kings",
        "0 to 100",
        "God's Plan",
        "Successful",
        "Worst Behavior",
        "Tuscan Leather"
    ];


    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint rando = random(string(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory selected = sourceArray[rando % sourceArray.length];
        return selected;
    }

    function getDrake(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "Drake", drake);
    }

    function getEminem(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "Eminem", eminem);
    }

    function getYe(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "Ye", ye);
    }

    function getDoom(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "MF DOOM", doom);
    }

    function getJayz(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "Jay Z", jayz);
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[11] memory parts;

        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = getYe(tokenId);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = getEminem(tokenId);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = getDoom(tokenId);

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = getJayz(tokenId);

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = getDrake(tokenId);

        parts[10] = '</text></svg>';

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4]));

        output = string(abi.encodePacked(output, parts[5], parts[6], parts[7], parts[8], parts[9], parts[10]));



        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Playlist #', Strings.toString(tokenId), '", "description": "Songs to help you win at life", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }



    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}