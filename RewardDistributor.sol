
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RewardDistributor {
    mapping(address => uint256) public rewards;

    function addReward(address user, uint256 amount) public {
        require(amount > 0, "Reward must be greater than 0");
        rewards[user] += amount;
    }

    function claimReward() public {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No reward to claim");
        
        rewards[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: reward}("");
        require(success, "ETH transfer failed");
    }

    function getReward(address user) public view returns (uint256) {
        return rewards[user];
    }
}

