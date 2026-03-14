// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vault {

    mapping(address => uint256) public balances;

    event Deposit(address user, uint amount);
    event Withdraw(address user, uint amount);

    function deposit() public payable {
        require(msg.value > 0, "Send ETH");

        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        balances[msg.sender] -= amount;

        payable(msg.sender).transfer(amount);

        emit Withdraw(msg.sender, amount);
    }

    function getBalance() public view returns(uint) {
        return balances[msg.sender];
    }
}
