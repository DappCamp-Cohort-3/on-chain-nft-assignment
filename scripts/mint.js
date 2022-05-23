async function main() {
  const DappCampNFTFactory = await ethers.getContractFactory("DappCampNFT");
  const dappCampNFT = DappCampNFTFactory.attach("0x5A6B68e981CA92F7dfE9d57bA3E361A72b47f8B4");

  for (let i = 1; i < 20; i++)
    await dappCampNFT.claim(i);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
