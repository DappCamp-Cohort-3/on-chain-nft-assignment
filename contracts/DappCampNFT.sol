// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {

    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}
    string[] private firstHalf = [
        unicode"ಹೇಳುವುದಕ್ಕೂ ಕೇಳುವುದಕ್ಕೂ", 
        unicode"ಈ ಪ್ರೀತಿ ಪ್ರೇಮ",
        unicode"ಕುತ್ತೆ ಕನ್ವರ್ ನಹಿ",
        unicode"ಏನ್ ಬುಲ್ಬುಲ್",
        unicode"I am God,",
        unicode"ಈ ಮುಂಗಾರು ಮಳೆಯಲ್ಲಿ ಇಷ್ಟೊಂದು ಬೆಂಕಿ ಇದೆ ಅಂತ ಗೊತಿರ್ಲಿಲ್ಲ ದೇವದಾಸ"
        unicode"ಈ ಕೈ",
        unicode"ತಾಕತ್ ಅವಶ್ಯಕತೆ ಬಂದಾಗ,",
        unicode"ಇನ್ವಿಟೇಷನ್ ಇಲ್ದೆ",
        unicode"ಎಂತಾ,?",
        unicode"ಆದ್ರೆ, ನಿಮ್ಮ ಅಪ್ಪ ನಾನೇ",
        unicode"ನಾವು",
        unicode"ಯಾರು ತಿಳಿಯರು",
        unicode"ಅಂತಕನಿಗೆ ಅಂತಕನು",
        unicode"ಈ ಕೈ"        
    ];
    string[] private secondHalf = [
        unicode"ಸಮಯವಲ್ಲ", 
        unicode"ಎಲ್ಲ ಪುಸ್ತಕದ್ದ ಬದ್ನೇಕಾಯಿ",
        unicode"ಕನ್ವರ್ ಲಾಲ್ ಬೋಲೋ",
        unicode"ಮಾತಾಡಕಿಲ್ವ",
        unicode"God is great",
        unicode"ಈ ಮುಂಗಾರು ಮಳೆಯಲ್ಲಿ ಇಷ್ಟೊಂದು ಬೆಂಕಿ ಇದೆ ಅಂತ ಗೊತಿರ್ಲಿಲ್ಲ ದೇವದಾಸ"
        unicode"ಕರ್ನಾಟಕದ ಆಸ್ತಿ",
        unicode"ತಾನಾಗೆ ಹೋರಗೆ ಬರೋದು",
        unicode"ತಿಥಿ ಊಟಕ್ಕೆ ಹೋಗಲ್ಲ ನಾವು",
        unicode"shoot ಮಾಡ್ಬೇಕಾ?",
        unicode"ಆದ್ರೆ, ನಿಮ್ಮ ಅಪ್ಪ ನಾನೇ",
        unicode"ಬೆಂಕಿ ಇದ್ದಂಗೆ",
        unicode"ನಿನ್ನ ಭುಜಬಲದ ಪರಾಕ್ರಮ",
        unicode"ಈ ಬಭ್ರುವಾಹನ",
        unicode"ಕರ್ನಾಟಕದ ಆಸ್ತಿ"
    ];
    function random(string memory input) internal pure returns (uint256) {
        uint256 result = uint256(keccak256(abi.encodePacked(input)));
        return result;
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 index = random(string(abi.encodePacked(tokenId, keyPrefix))) % sourceArray.length;
        string memory text =  sourceArray[index]; //string
        return text;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory prefix = "data:application/json;base64,";        

        string memory firstH = pluck(tokenId, "DIALOGUES", firstHalf);        
        string memory secondH = pluck(tokenId, "DIALOGUES", secondHalf);        

        string memory header = '<svg xmlns="http://www.w3.org/2000/svg"  preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="white" />';
        string memory textFormat = string(abi.encodePacked('<text x= "10" y = "10" class = "base" font-size="8px">', firstH,
                                        '<tspan class="base" x="10" y="1cm" font-size="8px">',secondH,
                                        '</tspan></text></svg>'));                        

        /*
        {"name": "Color #1", "description": "Bring colors to life.", "image": "data:image/svg+xml;base64,<svg>"}*/

        string memory base64data = Base64.encode(abi.encodePacked('{"name": "Kannada Dialogue #', Strings.toString(tokenId), 
                                             '", "description": "Famous Kannada Cinema Dialogues",',
                                             '"image": "data:image/svg+xml;base64,',
                                             Base64.encode(abi.encodePacked(header, textFormat)),
                                             '"}'));
        string memory uri = string(abi.encodePacked(prefix, base64data));                                             
        return uri;        
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}
