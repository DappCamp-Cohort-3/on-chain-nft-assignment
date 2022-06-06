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
        ""
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint rand = uint(keccak256(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory svgView = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><rect width="100%" height="100%" fill="white" /><text x="10" y="20" class="base">';
        string memory content = "</text></svg>";
        string memory keyPrefix = "Tokens";
        string memory output = pluck(tokenId, keyPrefix, collection);

        string memory svgString = string(
            abi.encodePacked(svgView, output, content)
        );
        string memory base64String = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Tokens", "description": "stablecoins and altcoin", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(svgString)),
                        '"}'
                    )
                )
            )
        );

        string memory jsonWithPrefix = string(
            abi.encodePacked("data:application/json;base64,", base64String)
        );

        return jsonWithPrefix;
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}