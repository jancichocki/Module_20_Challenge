pragma solidity ^0.5.5;

// Define a new contract named `JointSavings`
contract JointSavings {
    // Declare state variables
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Function to withdraw funds from the joint savings account
    function withdraw(uint amount, address payable recipient) public {
        // Ensure the recipient is either accountOne or accountTwo
        require(
            recipient == accountOne || recipient == accountTwo,
            "You don't own this account!"
        );

        // Ensure there are enough funds in the contract to perform the withdrawal
        require(
            address(this).balance >= amount,
            "Insufficient funds!"
        );

        // Update lastToWithdraw if the current recipient is not the last one to withdraw
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the amount to the recipient
        recipient.transfer(amount);

        // Update lastWithdrawAmount and contractBalance to the new balance of the contract
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    // Function to deposit funds into the contract
    function deposit() public payable {
        // Update contractBalance to reflect the new balance of the contract
        contractBalance = address(this).balance;
    }

    // Function to set the accounts that can withdraw from this contract
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function to accept incoming Ether deposits
    function() external payable {
        // Automatically called when the contract receives Ether without data
    }
}