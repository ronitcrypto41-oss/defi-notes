// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SimpleBank
 * @notice A basic smart contract for depositing and withdrawing ETH
 * @dev This is a learning project. I am still improving my understanding of Solidity.
 */

contract SimpleBank {
    
    // State Variable: Stores each user's ETH balance
    mapping(address => uint256) public balances;

    /**
     * @notice Deposit ETH into the contract
     * @dev Uses payable to receive ETH. Minimum deposit is > 0
     */
    function deposit() public payable {
        require(msg.value > 0, "Cannot deposit 0 ETH");
        balances[msg.sender] += msg.value;
    }

    /**
     * @notice Withdraw ETH from the contract
     * @param amount The amount of ETH to withdraw
     * @dev Checks balance before sending ETH (Checks-Effects-Interactions pattern)
     */
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;           // Update balance first
        payable(msg.sender).transfer(amount);     // Send ETH to user
    }

    /**
     * @notice Get the caller's current balance
     * @return The balance of msg.sender
     */
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
