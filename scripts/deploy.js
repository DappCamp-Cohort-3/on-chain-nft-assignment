async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  dappCampNFT = await DappCampNFTFactory.deploy();
  await dappCampNFT.deployed();

  console.log("DappCamp NFT deployed to:", dappCampNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
