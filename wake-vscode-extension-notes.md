# Cross-Contract Reentrancy

Suggested by @WakeFrameworkwork — thank you for the great recommendation!

## What is Cross-Contract Reentrancy?
Standard reentrancy happens in one contract: attacker calls back into the same contract before state updates (e.g., withdraw → deposit again before balance = 0).

**Cross-contract reentrancy** is more advanced:
- Attacker exploits reentrancy **across multiple contracts**.
- Usually involves proxies, delegatecalls, or external calls to malicious contracts that call back into the victim system.
- Common in DeFi with upgradeable proxies (UUPS/Transparent) or flash loans + malicious callbacks.

Example scenario:
1. Victim contract A calls external contract B.
2. B is malicious → calls back into A (or related contract C) before A updates state.
3. A re-enters vulnerable logic → attacker drains funds.

## Why It's Dangerous in DeFi
- Harder to detect than single-contract reentrancy.
- Often bypasses basic ReentrancyGuard (because guard is per-contract, not cross-contract).
- Seen in real exploits with proxy patterns or complex lending/AMM interactions.

## How to Prevent / Mitigate
- Use **Checks-Effects-Interactions** pattern strictly.
- Prefer **pull over push** payments (user claims funds instead of auto-send).
- Use **ReentrancyGuard** + additional checks on external calls.
- Audit proxies carefully (delegatecall risks).
- Tools like Wake help catch these live.

## Wake VS Code Extension (Solidity (Wake))
@WakeFrameworkwork recommended this extension — I installed it today.

- Publisher: Ackee Blockchain
- Free in VS Code marketplace
- Live analysis: warns about reentrancy, overflows, unused variables, etc. as you type.
- Very beginner-friendly — no extra setup needed.
- My first impression: Clean UI, fast, catches issues I would miss manually.

Plan: Test Wake on a sample vulnerable contract (cross-contract example) and add results here later.

## Resources to Start
- Damn Vulnerable DeFi (cross-contract challenges): https://damnvulnerabledefi.xyz/
- OpenZeppelin forum threads on proxy reentrancy
- Wake docs: https://ackeeblockchain.com/wake (check for extension guide)

Feedback welcome — especially if anyone has used Wake for cross-contract detection!

X: @Web3Ronit
