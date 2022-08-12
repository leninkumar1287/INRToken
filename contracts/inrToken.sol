pragma solidity^0.8.15;

import "./ERC20.sol";

contract inrToken {
    address addressOfAnotherContract;
    address public admin = msg.sender;
    uint public increaseCoin;

    modifier restriction(address own){
        if(true){
            require(msg.sender == own);
        }
        else {
            revert();
            }
        _;
    }

    function setAddress(address _address) external {
        addressOfAnotherContract = _address;
    }

    function pointer() view internal returns(ERC20 Pointer){
        Pointer = ERC20(addressOfAnotherContract);
        return Pointer;
    }

    function addNewCoin(uint newCoin) public restriction(msg.sender){
        increaseCoin += newCoin;
    }

    function mintNewINRToken(uint amount) public restriction(msg.sender) {
        uint oldCoin = pointer().getCoin();
        uint newlyAddedCoin = oldCoin += amount;
        require(increaseCoin >= oldCoin," there is no new coin added ");
        require(increaseCoin >= newlyAddedCoin || increaseCoin == newlyAddedCoin , " you were trying to mint extra token");
        pointer().addCoin(amount);
        pointer().mint(amount);
    }

    function Coin() view external returns(uint){
        return pointer().getCoin();
    }

    function totalINRtoken() view external returns(uint){
        return pointer().viewTotalSUpply();
    }

    function removeINR(uint amount) external restriction(msg.sender){
        pointer().burn(amount);
        pointer().removeCoin(amount);
    }

    function balanceOfAccount(address addressOfAccount) view external returns(uint){
        return pointer().balanceOf(addressOfAccount);
    }

    function transfer(address recipient, uint amount) public restriction(msg.sender) {
        pointer().transfer(recipient, amount);
    }

    function transferFrom(address from,address recipient, uint amount) public restriction(msg.sender) {
        pointer().transferFrom(from,recipient, amount);
    }
}