## Solidity Patterns I See in DeFi

### 1. require()
Used to stop bad actions.
Example:
- stake > 0
- health factor > 1

### 2. mapping(address => struct)
Used to store user data.
Example:
- deposits
- borrowed amount
- rewards

### 3. block.timestamp
Used for:
- lock periods
- reward calculation
- withdrawal checks

### 4. transfer / call
Used to send ETH or tokens.
ETH goes:
- from user → contract (deposit)
- from contract → user (withdraw)
