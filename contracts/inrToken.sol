pragma solidity^0.8.15;

import "./ERC20.sol";

contract inrToken is ERC20 {
    address addressOfAnotherContract;
    address adminOftheContract = msg.sender;
    uint public increaseCoin;

    modifier onlyAdmin(address own){
        require(adminOftheContract == own, "Only admin can do this operation");
        _;
    }
    function coinName() view public returns(string memory){
        return tokenName();
    }
    function symbolOfToken() view public returns(string memory){
        return tokenSymbol();
    }
    function addNewCoin(uint newCoin) public onlyAdmin(msg.sender){
        increaseCoin += newCoin;
        mintNewINRToken(newCoin);
    }

    function mintNewINRToken(uint amount) internal {
        uint oldCoin = getCoin();
        oldCoin += amount;
        require(increaseCoin >= oldCoin," there is no new coin added ");
        require(increaseCoin >= oldCoin || increaseCoin == oldCoin , " you were trying to mint extra token");
        mint(amount);
    }

    function Coin() view external returns(uint){
        return getCoin();
    }

    function totalINRtoken() view external returns(uint){
        return viewTotalSUpply();
    }

    function removeINR(uint amount) public onlyAdmin(msg.sender){
        burn(amount);
        removeCoin(amount);
    }

    function transferToken(address recipient, uint amount) public onlyAdmin(msg.sender) {
        transfer(recipient, amount);
    }

    function transferTokenFrom(address from,address recipient, uint amount) public onlyAdmin(msg.sender) {
        transferFrom(from,recipient, amount);
    }
}