async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach("0x93c281fE37AFda1B6EB278C8c1Fc77Fa80FEB50F");

  await dappCampNFT.claim(1);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
