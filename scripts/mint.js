async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach(
    "0x2b9dD01e5eeD1bCcC2fa5148580Cf313569B7644"
  );

  await dappCampNFT.claim(2);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
