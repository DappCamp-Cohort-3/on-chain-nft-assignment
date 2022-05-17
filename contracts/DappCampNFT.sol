// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("Eriks NFT Project", "ENFTCAMP") Ownable() {}

    string[] private collection = [
        "Royal",
        "Autumn",
        "Cecilia",
        "Perry",
        "Joy",
        "Rhett",
        "Billy",
        "Luke",
        "Wayne",
        "Amy"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pluck(
        uint256 tokenId,
        string memory keyPrefix,
        string[] memory sourceArray
    ) internal pure returns (string memory) {
        uint256 rand = random(
            string(abi.encodePacked(keyPrefix, Strings.toString(tokenId)))
        );
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function getFirst(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "FIRST", collection);
    }

    function getSecond(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "SECOND", collection);
    }

    function getThird(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "THIRD", collection);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[7] memory parts;

        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';
        parts[1] = getFirst(tokenId);
        parts[2] = '</text></svg><text x="10 y="40" class="base">';
        parts[3] = getSecond(tokenId);
        parts[4] = '</text></svg><text x="10 y="60" class="base">';
        parts[5] = getThird(tokenId);
        parts[6] = "</text></svg>";
        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6]
            )
        );
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "ErikNFTProj',
                        Strings.toString(tokenId),
                        '", "description": "Erik NFT Project", "image": "data:image/svg+xml;base64,',
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
