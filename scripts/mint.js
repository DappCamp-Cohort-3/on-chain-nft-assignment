async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach("CONTRACT_ADDR");

  await dappCampNFT.claim(1);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
