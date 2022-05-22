async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach("0x1A083bf370B16C05D46EfB5d6778AD3bBD197DcB");

  await dappCampNFT.claim(1);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
