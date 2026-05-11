
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleLending {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        require(msg.value > 0, "Cannot deposit 0 ETH");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}

