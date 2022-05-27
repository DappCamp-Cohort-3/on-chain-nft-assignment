// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Uncomment while developing code for testing.
// import "hardhat/console.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}

    string[] private backgroundColors = ["st0", "st2"];

    string[] private logoColors = ["st0", "st1"];

    string[] private names = [
        "Web3 Data Economy Index",
        "D4 DATA Index",
        "D4 DATA Token",
        "Web3 Data Index"
    ];

    string[] private projects = [
        "Filecoin",
        "Chainlink",
        "The Graph",
        "Basic Attention Token",
        "Livepeer",
        "Ethereum Name Service",
        "Ocean Protocol",
        "Numeraire",
        "Arweave",
        "Helium",
        "Handshake"
    ];

    function getProject(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "PROJECT", projects);
    }

    function getName(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "NAME", names);
    }

    function getLogoColor(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "LOGO", logoColors);
    }

    function getBackgroundColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        return pluck(tokenId, "COLOR", backgroundColors);
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint(keccak256(abi.encode(input)));
    }

    function pluck(
        uint256 tokenId,
        string memory keyPrefix,
        string[] memory sourceArray
    ) internal pure returns (string memory) {
        uint randomNumber = random(
            string(abi.encodePacked(keyPrefix, Strings.toString(tokenId)))
        );
        string memory output = sourceArray[randomNumber % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[36] memory parts;

        // Build the NFT image
        parts[
            0
        ] = '<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"';
        parts[
            1
        ] = '     viewBox="0 0 1280 720" style="enable-background:new 0 0 1280 720;" xml:space="preserve">';
        parts[2] = '<style type="text/css">';
        parts[3] = "    .st0{fill:#FFFFFF;}";
        parts[4] = "    .st1{fill:#000000;}";
        parts[
            5
        ] = "    .st2{fill:#FF0029;} .base { fill: black; font-family: arial; font-size: 36px; }";
        parts[6] = "</style>";
        parts[7] = '<rect x="-10" y="-10" class="';
        parts[8] = getBackgroundColor(tokenId);
        parts[9] = '" width="1300" height="740"/>';
        parts[10] = '<g class="';
        parts[11] = getLogoColor(tokenId);
        parts[12] = '">';
        parts[13] = '<rect x="727.5" y="298.2" width="25" height="25"/>';
        parts[14] = '<rect x="627.5" y="298.2" width="75" height="25"/>';
        parts[15] = '<rect x="552.5" y="223.2" width="75" height="25"/>';
        parts[16] = '<rect x="627.5" y="398.2" width="125" height="25"/>';
        parts[17] = '<rect x="577.5" y="423.2" width="25" height="25"/>';
        parts[18] = '<rect x="502.5" y="223.2" width="25" height="25"/>';
        parts[19] = '<rect x="577.5" y="373.2" width="50" height="25"/>';
        parts[20] = '<rect x="527.5" y="373.2" width="25" height="25"/>';
        parts[21] = '<rect x="602.5" y="448.2" width="100" height="25"/>';
        parts[22] = '<rect x="502.5" y="473.2" width="100" height="25"/>';
        parts[23] = '<rect x="502.5" y="323.2" width="125" height="25"/>';
        parts[24] = '<rect x="527.5" y="273.2" width="75" height="25"/>';
        parts[25] = '<rect x="652.5" y="348.2" width="125" height="25"/>';
        parts[26] = '<rect x="627.5" y="248.2" width="75" height="25"/>';
        parts[27] = '<rect x="502.5" y="423.2" width="50" height="25"/>';
        parts[28] = "</g>";
        parts[29] = '<text x="350" y="600" class="base">';
        parts[30] = getProject(tokenId);
        parts[31] = " Maxi Investing in the DATA Index";
        parts[32] = '</text><text x="490" y="100" class="base">';
        parts[33] = getName(tokenId);
        parts[34] = "</text>";
        parts[35] = "</svg>";

        // Convert the parts array to an SVG output
        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6],
                parts[7],
                parts[8]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[9],
                parts[10],
                parts[11],
                parts[12],
                parts[13],
                parts[14],
                parts[15],
                parts[16]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[17],
                parts[18],
                parts[19],
                parts[20],
                parts[21],
                parts[22],
                parts[23],
                parts[24]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[25],
                parts[26],
                parts[27],
                parts[28],
                parts[29],
                parts[30],
                parts[31],
                parts[32]
            )
        );
        output = string(
            abi.encodePacked(output, parts[33], parts[34], parts[35])
        );
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "DATA #',
                        Strings.toString(tokenId),
                        '", "description": "Web3 enables a new data economy. The Web3 data economy is an ecosystem of data-centric protocols and applications disrupting the data monopolies built in Big Tech. DATA provides exposure to the growth of the Web3 data economy in a single token.", "image": "data:image/svg+xml;base64,',
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
