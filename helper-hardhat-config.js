const networkConfig = {
    31337: {
        name: "localhost",
    },
    5: {
        name: "goerli",
        ethUsdPriceFeed: "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e",
    },
}
const INITIAL_SUPPLY = "19000000000000000000000000"

const developmentChains = ["hardhat", "localhost"]

export default {
    networkConfig,
    developmentChains,
    INITIAL_SUPPLY,
}