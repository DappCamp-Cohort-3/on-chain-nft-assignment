const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DappCampNFT", function () {

  let dappCampNFT;

  function isJsonString(str) {
    try {
      JSON.parse(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  beforeEach(async () => {
    const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
    dappCampNFT = await DappCampNFTFactory.deploy();
    await dappCampNFT.deployed();
  });


  it("should be claimable with correct tokenId", async function () {
    await dappCampNFT.claim(1);

    const metadata = String(await dappCampNFT.tokenURI(1));
    const base64encodedJson = metadata.replace("data:application/json;base64,", "");
    
    let buff = new Buffer.from(base64encodedJson, 'base64');
    let decodedString = buff.toString('ascii');

    expect(isJsonString(decodedString)).to.be.true;
  });
});
