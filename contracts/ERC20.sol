pragma solidity^0.8.15;

contract ERC20  {
	uint public totalSupply;
	uint public coin;
    address public admin = msg.sender;

	mapping (address => uint) public balanceOf;

	mapping (address => mapping (address => uint)) public allowance;

	string public name = "Indian Rupee";

	string public symbol = "INR";

	uint public decimals = 1 * 10 ** 18;

        function tokenName() view public returns(string memory){
            return name;
        }

        function tokenSymbol() view public returns(string memory){
            return symbol;
        }

        function viewOwner() view public returns(address administrator){
            return admin;
        }
/*
	it will return the value of 10 to the power of 18 (10^18) decimals;
*/

		function decimalslength() view public returns(uint){
			return decimals;
        }
		function addCoin(uint amount) public returns(uint){
			return coin += amount;
		}

		function removeCoin(uint amount) public returns(uint){
			return coin -= amount;
		}

		function getCoin() public view returns(uint){
			return coin;
		}
/*
	to mint a new tokens
*/
		function mint (uint amount) public {
			balanceOf[msg.sender] += amount*decimals;
			totalSupply += amount*decimals;
		}
/*
event for transction , if any transaction happens this Transfer event  will emit the from, to , amount
*/
		event Transfer(address indexed from, address indexed to, uint256 value);

/*  this transfer function helps to transfer the token using the params of recipient and amount 
	transfer and transferFrom both functions are doing same work
	we can spend token from other accounts of the contract using the transferFrom
	we can directly user transfer function, but it will take the msg.sender as a from address
*/
		function transferFrom(address from, address recipient, uint amount) public returns (bool) {
			assert(balanceOf[from] >= amount * decimals);
			balanceOf[from] -= amount*decimals;
			balanceOf [recipient] += amount*decimals;

/* this is the event function this will emit whenever this function called*/
			emit Transfer(msg.sender, recipient, amount);
			return true;
		}
/*  this transfer function helps to transfer the token using the params of sender, recipient and amount */

		function transfer(address recipient, uint amount) external {
			transferFrom(msg.sender, recipient, amount);
		}
/*
 Burn the tokens
*/
		function burn (uint amount) external {
			if(amount* decimals <=balanceOf[msg.sender]){
				balanceOf[msg.sender] -= amount * decimals;
				totalSupply -= amount*decimals;
			}
		}
/*
	to view the total supply
*/
        function viewTotalSUpply() view external returns(uint){
            return totalSupply;
        }
}