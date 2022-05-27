const fs = require("fs").promises;

async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  dappCampNFT = await DappCampNFTFactory.deploy();
  await dappCampNFT.deployed();

  console.log("DappCamp NFT deployed to:", dappCampNFT.address);

  await writeToFile(dappCampNFT.address);
}

async function writeToFile(dappCampNFT) {
  const dappCampNFTInfo = {
    dappCampNFT
  };

  const data = JSON.stringify(dappCampNFTInfo);

  // write JSON string to a file
  await fs.writeFile("src/addresses.json", data);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
