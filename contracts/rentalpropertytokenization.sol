// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title PropertyTokenization
 * @dev An ERC20 token contract to represent fractional ownership of a real estate property.
 */
contract PropertyTokenization is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 10000 * (10 ** 18); // Example: 10,000 tokens

    // Struct to hold property details
    struct PropertyDetails { 
        string name;
        string location;
        uint256 totalValue; // in a stablecoin or fiat reference
        bool isTokenized;
    }

    PropertyDetails public property;

    /**
     * @dev Initializes the contract and mints all tokens to the deployer.
     * @param initialOwner The address that will own the contract and receive all initial tokens.
     * @param name_ Name of the property.
     * @param location_ Location of the property.
     * @param totalValue_ Total value of the property (e.g., in USD cents).
     */
    constructor(address initialOwner, string memory name_, string memory location_, uint256 totalValue_)
        ERC20("PropertyShareToken", "PST")
        Ownable(initialOwner)
    {
        property.name = name_;
        property.location = location_;
        property.totalValue = totalValue_;
        property.isTokenized = true;

        _mint(initialOwner, TOTAL_SUPPLY);
    }

    /**
     * @dev Core Function 1: Distributes rental income to token holders.
     * Only the owner can call this function.
     * The owner should send the rental funds to this contract before calling this.
     * @param amount The total rental income amount to distribute.
     */
    function distributeRentalIncome(uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Contract balance insufficient for distribution");

        // Simple pro-rata distribution logic: Iterate through all token holders
        // For production, a more efficient pull-based mechanism should be used.
        // This is a placeholder for core function logic.
        // Example logic: Send an amount proportional to balance
        // Note: Actual implementation for iterating over all holders is complex in Solidity
        // A common pattern is to use a push/pull mechanism with a snapshot of balances.

        // Placeholder for actual distribution logic:
        emit RentalIncomeDistributed(amount);
    }

    event RentalIncomeDistributed(uint256 amount);

    /**
     * @dev Core Function 2: Allows a token holder to redeem their tokens for the underlying asset (hypothetical).
     * This function would typically be part of a separate, more complex exit strategy contract.
     * This serves as a conceptual core function.
     * @param amount The number of tokens to redeem.
     */
    function redeemTokens(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient tokens");

        // Placeholder for redemption logic:
        // In a real scenario, this involves selling the property and distributing proceeds.
        // Requires complex off-chain interaction and smart contract logic.

        _burn(msg.sender, amount);
        // Logic to send corresponding value (e.g., stablecoins) to msg.sender would go here
        emit TokensRedeemed(msg.sender, amount);
    }

    event TokensRedeemed(address indexed user, uint256 amount);
}


