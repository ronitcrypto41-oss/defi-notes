
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVesting {
    mapping(address => uint256) public vestedAmount;
    mapping(address => uint256) public released;

    uint256 public startTime;
    uint256 public duration;

    constructor(uint256 _duration) {
        startTime = block.timestamp;
        duration = _duration;
    }

    function vest(uint256 amount) public {
        vestedAmount[msg.sender] += amount;
    }

    function release() public {
        uint256 vested = _vestedAmount(msg.sender);
        uint256 toRelease = vested - released[msg.sender];

        require(toRelease > 0, "No tokens to release");
        
        released[msg.sender] += toRelease;
        
        (bool success, ) = payable(msg.sender).call{value: toRelease}("");
        require(success, "ETH transfer failed");
    }

    function _vestedAmount(address beneficiary) private view returns (uint256) {
        if (block.timestamp < startTime) return 0;
        if (block.timestamp >= startTime + duration) {
            return vestedAmount[beneficiary];
        }
        return (vestedAmount[beneficiary] * (block.timestamp - startTime)) / duration;
    }
}
