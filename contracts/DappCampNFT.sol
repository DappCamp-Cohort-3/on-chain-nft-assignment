// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("Crypto Wedding", "CWED") Ownable() {}

    string[] private partner1 = [
        "John",
        "Adam",
        "Peter",
        "Sam",
        "Jack"
    ];

    string[] private partner2 = [
        "Jill",
        "Mary",
        "Cristina",
        "Laura",
        "Cathy"
    ];



    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }


    function getPartner1(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "partner1", partner1);
    }
    
    function getPartner2(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "partner2", partner2);
    }


    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, Strings.toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[5] memory parts;
        parts[0] = '<svg width="694" height="646" viewBox="0 0 694 646" fill="none" xmlns="http://www.w3.org/2000/svg"> <style> * { margin: 0; padding: 0; box-sizing: border-box; } #heart{ animation: heart 0.75s infinite alternate; /* transform-origin: bottom; */ transform-box:fill-box; } @keyframes heart{ from{ transform: scale3d(0,0,0); fill: pink; } to{ transform: scale3d(1.05,1.05,1.05); fill: red; } } </style> <g id="Group 1"> <rect id="outerRect" x="1" y="1" width="692" height="644" fill="#FAB80F" stroke="black"/> <rect id="innerRect" x="33" y="27" width="634" height="583" fill="#F8E7E7" stroke="black"/> <g id="headText" filter="url(#filter0_d_7_10)"> <text fill="black" xml:space="preserve" style="white-space: pre" font-family="Almarai" font-size="36" font-weight="800" letter-spacing="0em"><tspan x="112.549" y="85.492">Crypto Wedding Certificate</tspan></text> <text stroke="black" xml:space="preserve" style="white-space: pre" font-family="Almarai" font-size="36" font-weight="800" letter-spacing="0em"><tspan x="112.549" y="85.492">Crypto Wedding Certificate</tspan></text> </g> <g id="bodyText"> <text fill="black" xml:space="preserve" style="white-space: pre" font-family="Almarai" font-size="20" font-weight="300" letter-spacing="0em"><tspan x="351.242" y="188.94">I,&#10;</tspan><tspan x="355.5" y="210.94">&#10;</tspan><tspan x="355.5" y="276.94">&#10;</tspan><tspan x="336.34" y="298.94">take&#10;</tspan><tspan x="355.5" y="320.94">&#10;</tspan><tspan x="339.445" y="342.94">you&#10;</tspan><tspan x="355.5" y="408.94">&#10;</tspan><tspan x="268.381" y="430.94">to be my life partner.&#10;</tspan></text> <text fill="#FD0202" xml:space="preserve" style="white-space: pre" font-family="Almarai" font-size="20" font-weight="800" letter-spacing="0em"><tspan x="307.414" y="232.94">';

        parts[1] = getPartner1(tokenId);

        parts[2] = '&#10;</tspan></text> <text fill="#F40404" xml:space="preserve" style="white-space: pre" font-family="Almarai" font-size="20" font-weight="800" letter-spacing="0em"><tspan x="300.803" y="364.94">';

        parts[3] = getPartner2(tokenId);

        parts[4] = '&#10;</tspan></text> </g> <path id="heart" fill-rule="evenodd" clip-rule="evenodd" d="M556.038 518.638C562.093 512.496 566.346 507.184 575.716 506.132C593.252 504.19 609.35 521.64 600.495 538.817C597.974 543.709 592.843 549.528 587.167 555.236C580.938 561.504 574.043 567.646 569.215 572.303L556.046 585L545.162 574.819C532.069 562.563 510.757 547.137 510 528.025C509.523 514.636 520.391 506.059 532.894 506.213C544.065 506.36 548.788 511.76 556.038 518.638Z" fill="#ED1B24"/> </g> <defs> <filter id="filter0_d_7_10" x="109.809" y="58.54" width="486.622" height="41.084" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"> <feFlood flood-opacity="0" result="BackgroundImageFix"/> <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/> <feOffset dy="4"/> <feGaussianBlur stdDeviation="2"/> <feComposite in2="hardAlpha" operator="out"/> <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/> <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_7_10"/> <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_7_10" result="shape"/> </filter> </defs> </svg>';

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Dev #', Strings.toString(tokenId), '", "description": "Crypto Wedding", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }

    function claim(uint256 tokenId) public {
        require(tokenId > 0 && tokenId < MAX_MINTABLE_TOKENS, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
}