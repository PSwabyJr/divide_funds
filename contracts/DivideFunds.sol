// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


contract DivideFund{

    address public owner;
    address private secondAddress;
    uint256 private reservedWei = 2*10**12; // minimum balance (Wei) a contract will have

    constructor() public {
        owner = msg.sender;
    }

    function setSecondAdress(address _secondAddress) public {
        secondAddress = _secondAddress;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    modifier secondAddressExists{
        require(secondAddress != 0);
        _;
    }

    // funds are insufficient when the balance amount is less than 2*reservedWei 
    modifier sufficientFundsAvailable{
        require(address(this).balance >= 2*reservedWei);
        _;
    }

    // splits the funds 50/50 between the Owner's primary wallet address and secondary wallet address
    function dividefunds() payable onlyOwner, secondAddressExists, sufficientFundsAvaiable public {
        fundsToDivide = address(this).balance - reservedWei;
        fundsForOwner = fundsToDivide/2;
        fundsForSecondaryAccount = fundsToDivide - fundsForOwner;
        msg.sender.transfer(fundsForOwner);
        secondAddress.transfer(fundsForSecondaryAccount);

    }

}