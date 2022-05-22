async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach("0x11Ba10c66fc6BE806C6606a78Ac7FF940211a2F8");

  await dappCampNFT.claim(2);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
