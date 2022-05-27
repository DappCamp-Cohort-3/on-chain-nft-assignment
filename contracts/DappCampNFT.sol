// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}

    string[] private pokemon = [
        "Mimikyu",
        "Charizard",
        "Gengar",
        "Umbreon",
        "Squirtle",
        "Mudkip",
        "Metagross",
        "Greninja",
        "Celebi"
    ];

    string[] private colors = [
        "f6bd60",
        "f7ede2",
        "f5cac3",
        "84a59d",
        "84a59d",
        "f28482",
        "2ec4b6",
        "669bbc",
        "f1c0e8",
        "355070,",
        "6d597a",
        "e56b6f"
    ];

    function getGreyColor(uint _tokenId) private pure returns (string memory) {
        uint256 rand = random(
            string(abi.encodePacked("FONT COLOR", Strings.toString(_tokenId)))
        );
        return Strings.toString(rand % 256);
    }

    function random(string memory _input) internal pure returns (uint256) {
        return uint(keccak256(abi.encodePacked(_input)));
    }

    function pluck(
        uint256 _tokenId,
        string memory _keyPrefix,
        string[] memory _sourceArray
    ) internal pure returns (string memory) {
        uint256 rand = random(
            string(abi.encodePacked(_keyPrefix, Strings.toString(_tokenId)))
        );
        string memory output = _sourceArray[rand % _sourceArray.length];
        return output;
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[7] memory parts;
        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><style>.base { fill: rgb(';

        parts[1] = getGreyColor(_tokenId);

        parts[
            2
        ] = '); font-family: serif; font-size: 14px; }</style><rect width="100" height="100" fill="#';

        parts[3] = pluck(_tokenId, "COLOR", colors);
        parts[4] = '" /><text x="10" y="20" class="base">';
        parts[5] = pluck(_tokenId, "POKEMON", pokemon);
        parts[6] = "</text></svg>";

        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                ",",
                parts[1],
                ",",
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
                        '{"name": "Pokemon #',
                        Strings.toString(_tokenId),
                        '", "description": "Pokemon around the world are tired of working for the top 1%. Time for the Pokemon revolution!", "image": "data:image/svg+xml;base64,',
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

    function claim(uint256 _tokenId) public {
        require(
            _tokenId > 0 && _tokenId < MAX_MINTABLE_TOKENS,
            "Token ID invalid"
        );
        _safeMint(_msgSender(), _tokenId);
    }
}
