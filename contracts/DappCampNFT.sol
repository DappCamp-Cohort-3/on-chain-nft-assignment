// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DappCampNFT is ERC721Enumerable, Ownable {
    uint256 public MAX_MINTABLE_TOKENS = 5;

    constructor() ERC721("DappCamp NFT", "DCAMP") Ownable() {}

    string[] private soups = [
        "Chicken Noodle",
        "Italian Wedding",
        "Lentil",
        "Tomato",
        "Clam Chowder",
        "French Onion",
        "Chicken Tortilla",
        "Butternut Squash",
        "Beef and Barley",
        "Corn Chowder",
        "Chicken and Rice",
        "Split Pea",
        "Bouillabaisse",
        "Cream of Mushroom",
        "Miso",
        "Ramen",
        "Minestrone",
        "Cream of Mushroom"
    ];

    string[] private pizzaToppings = [
        "Pepperoni",
        "Sausage",
        "Mushrooms",
        "Bacon",
        "Onions",
        "Extra Cheese",
        "Peppers",
        "Chicken",
        "Olives",
        "Spinach",
        "Tomato and Basil",
        "Beef",
        "Ham",
        "Pesto",
        "Pulled Pork",
        "Ham And Pineapple"
    ];

    string[] private iceCream = [
        "Vanilla",
        "Chocolate",
        "Chocolate Chip",
        "Butter Pecan",
        "Chocolate Chip Cookie Dough",
        "Eggnog",
        "Eskimo",
        "Strawberry",
        "Horchata",
        "Lemon Custard",
        "Cookies N Cream",
        "Mint Chocolate Chip",
        "Moose Tracks",
        "Neapolitan",
        "Cotton Candy"
    ];

    string[] private thanksgiving = [
        "Roast Turkey",
        "Mashed Potatoes",
        "Green Bean Casserole",
        "Gravy",
        "Cranberry Sauce",
        "Stuffing",
        "Sweet Potato Casserole",
        "Pumpkin Pie",
        "Yams",
        "Cornbread",
        "Potato Rolls",
        "Apple Pie",
        "Baked Sweet Potato",
        "Pecan Pie"
    ];

    string[] private drinks = [
        "Water",
        "Milk",
        "Tea",
        "Coffee",
        "Sparkling drinks",
        "Juices",
        "Energy drink",
        "Mocktails",
        "Milkshakes",
        "Smoothies",
        "Cocoa",
        "Tonic Water",
        "Beer",
        "Wine",
        "Cider",
        "Cocktails",
        "Hard Alcohol"
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

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[10] memory parts;

        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: black; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="white" /><text x="10" y="20" class="base">';

        parts[1] = pluck(tokenId, "SOUP", soups);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = pluck(tokenId, "PIZZA", pizzaToppings);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = pluck(tokenId, "ICECREAM", iceCream);

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = pluck(tokenId, "THANKSGIVING", thanksgiving);

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[7] = pluck(tokenId, "DRINKS", drinks);

        parts[8] = "</text></svg>";

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

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Random Meal #',
                        Strings.toString(tokenId),
                        '", "description": "Enjoy your random meal", "image": "data:image/svg+xml;base64,',
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
