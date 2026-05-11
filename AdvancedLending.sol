
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AdvancedLending {
    mapping(address => uint256) public collateral;
    mapping(address => uint256) public borrowed;

    uint256 public constant LTV = 75; // 75% Loan to Value

    function deposit() public payable {
        require(msg.value > 0, "Cannot deposit 0 ETH");
        collateral[msg.sender] += msg.value;
    }

    function borrow(uint256 amount) public {
        require(collateral[msg.sender] > 0, "No collateral deposited");
        uint256 maxBorrow = (collateral[msg.sender] * LTV) / 100;
        require(amount <= maxBorrow - borrowed[msg.sender], "Exceeds max borrow limit");

        borrowed[msg.sender] += amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    function getHealthFactor(address user) public view returns (uint256) {
        if (borrowed[user] == 0) return 1000;
        return (collateral[user] * 100) / borrowed[user];
    }
}

