// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

 // this is an interface for interacting with an ERC-721 NFT contract
interface IERC721 {
    function ownerOf(uint256 tokenId) external view returns (address);
}

contract NFTEventManagement {
    // variable holding the address of the ERC-721 contract
    IERC721 public nftContract;

    //specifying the ID of the NFT required to register for the event
    uint256 public nftId;

    //address of the event organizer
    address public eventOrganizer;

    mapping(address => bool) public isRegistered;

    event Registered(address user);

    constructor(address _nftContract, uint256 _nftId) {
        nftContract = IERC721(_nftContract);
        nftId = _nftId;
        eventOrganizer = msg.sender;
    }

    modifier onlyOrganizer() {
        require(msg.sender == eventOrganizer, "Not the event organizer");
        _;
    }

    function registerForEvent() external {
        require(nftContract.ownerOf(nftId) == msg.sender, "You don't own the required NFT");
        require(!isRegistered[msg.sender], "Already registered");

        isRegistered[msg.sender] = true;

        emit Registered(msg.sender);
    }

//Allows the only the event organizer to update the required NFT-ID
    function updateRequiredNft(uint256 _newNftId) external onlyOrganizer {
        nftId = _newNftId;
    }
}
