// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}

    string[] private words = [
        "amazing",
        "fun",
        "awesome",
        "great",
        "unstoppable"
    ];
    string[] private colors = ["pink", "yellow", "purple", "orange", "blue"];

    function getColor(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "COLOR", colors);
    }

    function getWord(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "WORD", words);
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(
        uint256 tokenId,
        string memory keyPrefix,
        string[] memory sourceArray
    ) internal pure returns (string memory) {
        // TODO: why toString from DAO project?
        uint256 rand = random(string(abi.encodePacked(keyPrefix, tokenId)));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[6] memory parts;
        parts[
            0
        ] = '<svg viewBox="0 0 240 40" xmlns="http://www.w3.org/2000/svg">';
        parts[
            1
        ] = "<style> text  { font: italic 12px serif; } tspan { font: bold 10px sans-serif;fill: ";
        parts[2] = getColor(tokenId);
        parts[3] = ';}</style>;<text x="10" y="30" class="small">I am <tspan>';
        parts[4] = getWord(tokenId);
        parts[5] = "!</tspan></text></svg>";

        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5]
            )
        );
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "NFT affirmations #',
                        Strings.toString(tokenId),
                        '", "description": "NFT affirmations!", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(output)),
                        '"}'
                    )
                )
            )
        );
        output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        return output;
    }

    function claim(uint256 tokenId) public {
        require(
            tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS,
            "Token ID invalid"
        );
        _safeMint(_msgSender(), tokenId);
    }
}
