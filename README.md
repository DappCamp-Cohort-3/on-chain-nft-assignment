# On-Chain NFT Assignment

The goal of this exercise is to develop an on-chain NFT collection and host it on opensea.

A base contract is given here - `contracts/DappCampNFT.sol`. Use this contract to create your own NFT collection. Complete the following functions:

- The collection array can contain the different texts or attributes you want to randomize for SVG image. You can choose different texts or attributes for this collection based on your creativity.

- `random(string memory input)`: Given an input string(`input`), it should return a random number. This random number should be deterministic with the input value. Given same input it should return same random number each time

- `pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray)`: It should generate a random number using both `keyPrefix` and `tokenId` and then pick and return an element from the given `sourceArray` containing multiple elements. Here `keyPrefix` can be any string representing what type of collection you are picking from and `sourceArray` is the array of that collection items (called `collection` in our contract).
    
    For example, in `DeveloperDAO` [contract](https://github.com/Developer-DAO/developer-dao-nft-contract/blob/master/hh/contracts/Dev.sol) refer to `getOS` function, here `keyPrefix` is "OS" since it is representing the type of collection they are picking from and `sourceArray` is "osses" which is an array containing os names

- `tokenURI(uint256 tokenId)`: This function should use the pluck and random functions defined above to generate a unique NFT metadata for each tokenId. It should return a string containing base64 json data which further contains base64 encoded svg image. An example data has been broken down for you below

    - Returned value from tokenURI function -

        ```data:application/json;base64,eyJuYW1lIjogIkNvbG9yICMxIiwgImRlc2NyaXB0aW9uIjogIkJyaW5nIGNvbG9ycyB0byBsaWZlLiIsICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBeE1EQWdNVEF3SWo0OGNtVmpkQ0IzYVdSMGFEMGlNVEF3SWlCb1pXbG5hSFE5SWpFd01DSWdabWxzYkQwaVlteDFaU0lnTHo0OEwzTjJaejQ9In0=```

    - Here the prefix `data:application/json;base64,` is followed by base64 json data which decodes into following - 

        ```{"name": "Color #1", "description": "Bring colors to life.", "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAxMDAgMTAwIj48cmVjdCB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgZmlsbD0iYmx1ZSIgLz48L3N2Zz4="}```

    - The `image` field of the json above is a base64 encoded SVG prefixed with `data:image/svg+xml;base64,`. On decoding the base64 SVG you get 
    
        ```<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 100 100"><rect width="100" height="100" fill="blue" /></svg>```

    - You can use [base64decode.com](https://www.base64decode.org/) to decode base64 strings and use [svgviewer.dev](https://www.svgviewer.dev/) to view the svg image

## Setup

- Use the following command to install dependencies

    ```
    npm install
    ```

## Deployment

- Rename `.env.example` to `.env`. Replace `<<Your ALCHEMY_API_KEY>>` with your alchemy API key and `<<Your WALLET_PRIVATE_KEY>>` with your wallet's private key

- The deploy script is already provided for you. Run the following command to deploy to test network

    ```
    npx hardhat run scripts/deploy.js --network rinkeby
    ```

- Once deployed to rinkeby, you can view your NFT collection on opensea by substituting your `CONTRACT_ADDRESS` and `TOKEN_ID` in the below URL

    ```
    https://testnets.opensea.io/assets/CONTRACT_ADDR/TOKEN_ID
    ```

- Once deployed you can mint your tokens by substituting the deployed contract address in `scripts/mint.js` and running the following command

    ```
    npx hardhat run scripts/mint.js --network rinkeby
    ```

## Evaluation

-   Create a fork of this repo

-   Install all dependencies
    ```
    npm install
    ```

-   Make changes to the `contract/DappCampNFT.sol` file. The basic sanity tests in `test/DappCampNFT.spec.js` should run successfully.

-   Run Tests
    ```
    npm test
    ```

-   Create a pull request from your forked repo to main branch of original repo to run the github workflow. The name of the pull request should be in the format `YOUR_NAME - On-Chain NFT Assignment`

## Note

- To understand this concept of on-chain NFTs better take a look `DeveloperDAO` contract [here](https://github.com/Developer-DAO/developer-dao-nft-contract/blob/master/hh/contracts/Dev.sol)