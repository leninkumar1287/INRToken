pragma solidity^0.8.15;

import "./ERC20.sol";

/// @title INRToken
/// @author Larry A. Gardner
/// @notice You can use this contract for mint a new ERC20 based INRtoken
/// @dev All function calls are currently implemented without side effects

contract InrToken is ERC20 {

/// @notice take a address of contract deployer
/// @dev adminOfTheContract is taking the address of the contract deployer

    address adminOftheContract = msg.sender;
    uint public increaseCoin;

/// @dev It helps to validate the spender as a onwer
/// @param owner The address of msg.sender

    modifier onlyAdmin(address owner){
        require(adminOftheContract == owner, "Only admin can do this operation");
        _;
    }

/// @notice Get the currency name in bankAccount
/// @dev It will return the string with storage location in memory
/// @return tokenName()its return the String

    function coinName() view public returns(string memory){
        return tokenName();
    }

/// @notice Get the tokenSymbol against to the currency Name in bankAccount
/// @dev It will return the string with storage location in memory
/// @return tokenSymbol()its return the String

    function symbolOfToken() view public returns(string memory){
        return tokenSymbol();
    }

/// @notice This will add the coin in bankAccount and generate the token
/// @dev this will add the coin to Bankaccount and mint a token against to the bank balance, it will only executed by admin
/// @param newCoin a parameter just take the amount from client

    function addNewCoin(uint newCoin) public onlyAdmin(msg.sender){
        increaseCoin += newCoin;
        mintNewINRToken(newCoin);
    }

/// @notice This is token minter this can only called by admin By addNewCoin() and its
/// @dev it will mint the token against to the bank balance
/// @param amount a parameter that contains volume of the total INR in the bank Account

    function mintNewINRToken(uint amount) internal {
        uint oldCoin = getCoin();
        oldCoin += amount;
        require(increaseCoin >= oldCoin," there is no new coin added ");
        require(increaseCoin >= oldCoin || increaseCoin == oldCoin , " you were trying to mint extra token");
        mint(amount);
    }

/// @notice get bank balance
/// @dev it will return the total balance in the bank account
/// @return getCoin() the return function of a ERC20 contract’s function, value of state variable named coin

    function Coin() view external returns(uint){
        return getCoin();
    }

/// @notice to get the INRtoken
/// @dev it will return the total tokens against to the bank balance, it will always equal to return Coin()
/// @return viewTotalSUpply() the return function of a ERC20 contract’s function, value of state variable named totalSupply

    function totalINRtoken() view external returns(uint){
        return viewTotalSUpply();
    }

/// @notice Remove the coin from bank account and burn the INRtoken against to the removed coin
/// @dev it will burn the INR stabled coin and the same time it will burn the INRtoken against to the removed volume and this operation can only do by admin
/// @param amount a parameter that contains volume of the total INR going to remove from the bank Account

    function removeINR(uint amount) public onlyAdmin(msg.sender){
        burn(amount);
        removeCoin(amount);
    }

/// @notice Transfer the token to another account without sender address
/// @dev Transfer the amount of INRToken to another ETH address, in this function sender is default by msg.sender
/// @param recipient ETH address of the receiver
/// @param amount total Number of token going to send

    function transferToken(address recipient, uint amount) public onlyAdmin(msg.sender) {
        transfer(recipient, amount);
    }

/// @notice Transfer the token to another account with sender address
/// @dev Transfer the amount of INRToken to another ETH address, in this function you must give the sender address as well
/// @param from ETH address of sender
/// @param recipient ETH address of the receiver
/// @param amount total Number of token going to send

    function transferTokenFrom(address from,address recipient, uint amount) public onlyAdmin(msg.sender) {
        transferFrom(from,recipient, amount);
    }
}