import { ethers } from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // The constructor arguments
    const nftAddress = "0x47DcEEc5e6C026aDce15fbd575F2AD720C32Bf09"; 
    const requiredNftId = 1; 

    // Get the contract factory
    const NFTEventManagement = await ethers.getContractFactory("NFTEventManagement");

    // Deploy the contract
    const eventManagement = await NFTEventManagement.deploy(nftAddress, requiredNftId);

    // Wait for the contract to be deployed
    await eventManagement.deploymentTransaction();

    const contractAddress = await eventManagement.getAddress();

    console.log('✅ Contract deployed to:', contractAddress);
}

main().catch((error) => {
    console.error("Error during deployment:", error);
    process.exitCode = 1;
});
