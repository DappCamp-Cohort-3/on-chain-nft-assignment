async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach("0x9d3863A2c976E0E88714E3CA67b5153E19f2cf81");


    await dappCampNFT.claim(2);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
