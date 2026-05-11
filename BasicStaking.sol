
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BasicStaking {
    mapping(address => uint256) public stakes;
    uint256 public totalStaked;

    function stake() public payable {
        require(msg.value > 0, "Cannot stake 0 ETH");
        stakes[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    function unstake(uint256 amount) public {
        require(stakes[msg.sender] >= amount, "Insufficient staked amount");
        stakes[msg.sender] -= amount;
        totalStaked -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    function getStake() public view returns (uint256) {
        return stakes[msg.sender];
    }
}

