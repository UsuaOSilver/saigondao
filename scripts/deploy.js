// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const {
    developmentChains,
    INITIAL_SUPPLY,
} = require("../helper-hardhat-config")
const { verify } = require("../helper-functions")

const tokenName = "Ngaen"
const tokenSymbol = "SGN"

async function main() {

  const Ngaen = await hre.ethers.getContractFactory("Ngaen");
  const ngaen = await Ngaen.deploy(INITIAL_SUPPLY, tokenName, tokenSymbol);

  await ngaen.deployed();

  console.log(`Ngaen deployed at ${ngaen.address}`)
    
    if (
        !developmentChains.includes(network.name) &&
        process.env.ETHERSCAN_API_KEY
    ) {
        await verify(ngaen.address, [INITIAL_SUPPLY, tokenName, tokenSymbol])
    }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
