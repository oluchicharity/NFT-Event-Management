// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721 {
    function ownerOf(uint256 tokenId) external view returns (address);
}

contract NFTEventManagement {
    IERC721 public nftContract;
    uint256 public requiredNftId;
    address public eventOrganizer;

    mapping(address => bool) public isRegistered;

    event Registered(address user);

    constructor(address _nftContract, uint256 _requiredNftId) {
        nftContract = IERC721(_nftContract);
        requiredNftId = _requiredNftId;
        eventOrganizer = msg.sender;
    }

    modifier onlyOrganizer() {
        require(msg.sender == eventOrganizer, "Not the event organizer");
        _;
    }

    function registerForEvent() external {
        require(nftContract.ownerOf(requiredNftId) == msg.sender, "You don't own the required NFT");
        require(!isRegistered[msg.sender], "Already registered");

        isRegistered[msg.sender] = true;

        emit Registered(msg.sender);
    }

    function updateRequiredNft(uint256 _newNftId) external onlyOrganizer {
        requiredNftId = _newNftId;
    }
}
