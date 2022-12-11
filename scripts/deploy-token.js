const { network } = require("hardhat")
const {
    developmentChains,
    INITIAL_SUPPLY,
} = require("../helper-hardhat-config")
const { verify } = require("../helper-functions")

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const ngaen = await deploy("Ngaen", {
        from: deployer,
        args: [INITIAL_SUPPLY],
        log: true,
        // on live network
        waitConfirmations: network.config.blockConfirmations || 1,
    })
    log(`ourToken deployed at $${ngaen.address}`)
    
    if (
        !developmentChains.includes(network.name) &&
        process.env.ETHERSCAN_API_KEY
    ) {
        await verify(ngaen.address, [INITIAL_SUPPLY])
    }
}

module.exports.tags = ["all", "token"]