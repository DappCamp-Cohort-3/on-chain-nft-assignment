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
        "Chocolate",
        "Roseberry",
        "Strawberry",
        "Hazelnut",
        "Banana",
        "Pistachio"
    ];
    string[] private colors = [
        "#9E4B0E",
        "#FF7C99",
        "#FF4D57",
        "#FACDA4",
        "#FEFFC5"
    ];

    function random(string memory input) internal pure returns (uint256) {
        uint256 randomNbr = uint256(keccak256(abi.encodePacked(input)));
        return randomNbr;
    }

    function pluck(
        uint256 tokenId,
        string memory keyPrefix,
        string[] memory sourceArray
    ) internal pure returns (string memory) {
        uint256 randomNbr = random(
            string(abi.encodePacked(keyPrefix, Strings.toString(tokenId)))
        );

        return sourceArray[randomNbr % sourceArray.length];
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[9] memory parts;
        string memory color = pluck(
            tokenId,
            "data:application/json;base64,",
            colors
        );
        parts[
            0
        ] = '<svg width="200" height="75" viewBox="0 0 50 100" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M23.3754 0.12649C22.5913 0.229174 22.5933 0.276546 23.4142 1.07238C26.2359 3.80788 25.5128 6.15386 21.7486 6.47597C15.0951 7.04522 11.5851 12.5121 15.6027 16.0485C17.9073 18.077 24.7772 18.8673 29.2732 17.621C41.597 14.2048 36.2808 -1.56486 23.3754 0.12649ZM25.4058 10.7258C27.0098 11.2619 27.4312 13.2088 26.1725 14.2681C24.9495 15.2971 23.2238 14.7578 22.7974 13.2134C22.3883 11.7316 23.9522 10.24 25.4058 10.7258ZM7.9951 17.2182C-2.71225 27.8287 21.5768 36.31 39.8402 28.3377C45.1695 26.0114 45.9606 21.4289 41.745 17.305C40.2124 15.8059 40.2474 15.8211 39.6289 16.3867C37.3646 18.4574 34.7345 19.8487 30.9238 20.9915C24.3079 22.9755 15.1594 21.0628 10.3985 16.7004C9.33285 15.7239 9.55033 15.677 7.9951 17.2182ZM38.2484 22.8886C38.4192 23.0005 38.6476 23.3043 38.756 23.5638C39.3683 25.0293 37.52 26.2453 36.3931 25.1183C35.1114 23.8367 36.7289 21.893 38.2484 22.8886ZM15.0137 23.8467C15.526 24.4201 15.5169 25.2477 14.9918 25.8353C14.1159 26.8156 12.5084 26.1739 12.5084 24.8443C12.5084 23.4649 14.1045 22.8292 15.0137 23.8467ZM26.3362 25.929C26.8486 26.5024 26.8395 27.33 26.3143 27.9176C25.4385 28.8979 23.8309 28.2563 23.8309 26.9266C23.8309 25.5472 25.427 24.9115 26.3362 25.929ZM2.92872 29.7494C-4.32045 38.536 2.05636 44.6782 20.1869 46.373C25.3217 46.853 35.1889 46.105 38.8626 44.9574C39.0773 44.8902 39.6337 44.7303 40.0989 44.6017C48.844 42.1859 52.3512 36.5839 48.3634 31.4014C46.7535 29.3092 46.0001 28.9979 44.3731 29.7527C43.7045 30.0629 42.601 30.5359 41.921 30.8038C41.241 31.0717 40.5382 31.3504 40.3592 31.4233C29.9539 35.6591 17.0392 34.9871 5.25648 29.5965C3.49537 28.7909 3.73249 28.7753 2.92872 29.7494ZM6.22007 35.4237C7.31198 36.2199 6.69405 38.0384 5.33144 38.0384C4.67708 38.0384 4.26374 37.7986 3.98315 37.2561C3.27855 35.8935 4.96717 34.5102 6.22007 35.4237ZM45.5477 35.6547C45.9469 36.0745 45.9799 36.1693 45.9185 36.715C45.7393 38.3043 43.5888 38.5667 43.0915 37.0599C42.573 35.4888 44.3977 34.445 45.5477 35.6547ZM15.8563 38.2369C16.943 39.3236 15.8522 41.1221 14.3975 40.642C12.7411 40.0953 13.1414 37.8016 14.8965 37.7833C15.3001 37.7792 15.4869 37.8674 15.8563 38.2369ZM36.3794 37.9754C37.3995 38.7473 37.2979 40.0788 36.1803 40.5826C34.6382 41.2781 33.4065 39.3141 34.6541 38.1488C35.1052 37.7274 35.9406 37.6434 36.3794 37.9754ZM25.7789 39.5775C26.5051 40.1195 26.444 41.3831 25.6662 41.9058C24.2462 42.8603 22.6004 41.0727 23.6932 39.763C24.1896 39.1681 25.1199 39.0853 25.7789 39.5775ZM3.82242 44.3829C3.88124 44.7161 4.30057 46.2152 4.75959 47.7342C4.86774 48.0921 5.07623 48.8241 5.22277 49.361C5.49516 50.3584 5.52158 50.4511 5.98242 52.0289C6.64434 54.2956 8.76009 61.3212 8.92186 61.7897C9.02077 62.0761 9.23134 62.7495 9.38986 63.2864C10.0161 65.4075 11.624 70.1371 11.8223 70.4411C12.9133 72.115 14.2496 72.8325 17.9744 73.7448C21.8834 74.7021 26.9064 74.7015 31.1841 73.7431C32.9427 73.349 34.9705 72.6622 35.5936 72.2496C37.0951 71.2549 37.3651 70.628 40.0414 61.9199C40.3054 61.0609 40.7519 59.6847 41.0338 58.8615C41.3155 58.0383 41.8046 56.6035 42.1206 55.673C42.6675 54.0623 43.6214 51.2978 45.062 47.1485C46.2149 43.8278 46.2272 43.9611 44.8296 44.6164C38.8199 47.4343 27.037 48.9452 18.8204 47.9515C15.208 47.5146 13.3365 47.2111 10.6864 46.6326C9.86892 46.4542 7.43978 45.6696 6.82745 45.3861C6.60191 45.2817 6.38236 45.1963 6.33954 45.1963C6.29672 45.1963 5.72812 44.9328 5.0761 44.6107C3.67666 43.9194 3.74264 43.9313 3.82242 44.3829ZM18.0465 56.1835C18.4082 59.558 18.6971 68.2241 18.4243 67.5161C18.071 66.5993 17.5649 60.3151 17.5125 56.1935C17.4589 51.9786 17.5954 51.9759 18.0465 56.1835ZM11.2797 55.0873C11.5949 56.8092 11.8337 58.614 12.253 62.4405C12.5017 64.7103 12.5474 67.9636 12.3171 66.9955C12.0953 66.0638 11.636 63.3797 11.5264 62.3754C11.4835 61.9817 11.3966 61.3668 11.3332 61.0089C11.2012 60.2635 10.863 56.1028 10.7617 53.9811L10.6935 52.5495L10.8853 53.2653C10.9909 53.659 11.1684 54.4789 11.2797 55.0873ZM24.6812 55.5753C24.8565 60.1808 24.5277 68.3481 24.2025 67.4688C23.8951 66.638 23.9756 55.4241 24.3028 53.493C24.4751 52.476 24.5865 53.0888 24.6812 55.5753ZM38.6685 55.7214C38.5164 56.6252 38.2722 57.9505 38.1258 58.6663C37.9795 59.3821 37.8066 60.2313 37.7415 60.5534C37.2804 62.8348 35.824 67.9493 35.8143 67.3209C35.8035 66.6177 36.3607 63.3249 37.0255 60.1629C37.2579 59.0572 38.025 56.0338 38.3462 54.9572C38.4637 54.5635 38.6279 53.9778 38.7112 53.6557L38.8626 53.0701L38.904 53.574C38.9266 53.8512 38.8208 54.8175 38.6685 55.7214ZM30.8473 55.9332C30.8612 57.7014 30.5235 63.7612 30.3323 65.1735C30.2547 65.7461 30.1468 66.566 30.0926 66.9955L29.9938 67.7764L29.8872 66.7352C29.7724 65.6142 29.8933 59.9313 30.0777 57.7734C30.5116 52.7006 30.8159 51.9727 30.8473 55.9332Z" fill="#3F1806"/><path d="M23.4142 1.07238C22.5933 0.276546 22.5913 0.229174 23.3754 0.12649C36.2808 -1.56486 41.597 14.2048 29.2732 17.621C24.7772 18.8673 17.9073 18.077 15.6027 16.0485C11.5851 12.5121 15.0951 7.04522 21.7486 6.47597C25.5128 6.15386 26.2359 3.80788 23.4142 1.07238Z" fill="';
        parts[1] = color;
        parts[
            2
        ] = '"/><path d="M39.8402 28.3377C21.5768 36.31 -2.71225 27.8287 7.9951 17.2182C9.55033 15.677 9.33285 15.7239 10.3985 16.7004C15.1594 21.0628 24.3079 22.9755 30.9238 20.9915C34.7345 19.8487 37.3646 18.4574 39.6289 16.3867C40.2474 15.8211 40.2124 15.8059 41.745 17.305C45.9606 21.4289 45.1695 26.0114 39.8402 28.3377Z" fill="';
        parts[3] = color;
        parts[
            4
        ] = '"/><path d="M20.1869 46.373C2.05636 44.6782 -4.32045 38.536 2.92872 29.7494C3.73249 28.7753 3.49537 28.7909 5.25648 29.5965C17.0392 34.9871 29.9539 35.6591 40.3592 31.4233C40.5382 31.3504 41.241 31.0717 41.921 30.8038C42.601 30.5359 43.7045 30.0629 44.3731 29.7527C46.0001 28.9979 46.7535 29.3092 48.3634 31.4014C52.3512 36.5839 48.844 42.1859 40.0989 44.6017C39.6337 44.7303 39.0773 44.8902 38.8626 44.9574C35.1889 46.105 25.3217 46.853 20.1869 46.373Z" fill="';
        parts[5] = color;
        parts[6] = '"/><text x="-10" y="90" fill="black">';
        parts[7] = pluck(tokenId, "data:application/json;base64,", collection);
        parts[8] = "</text></svg>";

        string memory image = (
            Base64.encode(
                bytes(
                    string(
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
                    )
                )
            )
        );
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Cupcake #',
                        Strings.toString(tokenId),
                        '", "description": "Developers around the world are tired of w", "image": "data:image/svg+xml;base64,',
                        image,
                        '"}'
                    )
                )
            )
        );
        string memory output = string(
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
