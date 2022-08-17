pragma solidity^0.8.15;

contract ERC20  {
	uint totalSupply;
	uint coin;
    address admin = msg.sender;
	mapping (address => uint) balanceOf;
	mapping (address => mapping (address => uint)) allowance;
	string name = "Indian Rupee";
	string symbol = "INR";
	uint decimals = 1 * 10 ** 18;

	    function tokenName() view internal returns(string memory){
	        return name;
	    }
	    function tokenSymbol() view internal returns(string memory){
	        return symbol;
	    }
	    function viewOwner() view public returns(address administrator){
	        return admin;
	    }
		function decimalslength() view public returns(uint){
			return decimals;
	    }
		function removeCoin(uint amount) internal returns(uint){
			return coin -= amount;
		}
		function getCoin() internal view returns(uint){
			return coin;
		}
		function mint (uint amount) internal {
			balanceOf[msg.sender] += amount*decimals;
			coin += amount;
			totalSupply += amount*decimals;
		}
		event Transfer(address indexed from, address indexed to, uint256 value);
		function transferFrom(address from, address recipient, uint amount) internal returns (bool) {
			assert(balanceOf[from] >= amount * decimals);
			balanceOf[from] -= amount*decimals;
			balanceOf [recipient] += amount*decimals;
			emit Transfer(msg.sender, recipient, amount);
			return true;
		}
		function transfer(address recipient, uint amount) internal {
			transferFrom(msg.sender, recipient, amount);
		}
		function burn (uint amount) internal {
			if(amount* decimals <=balanceOf[msg.sender]){
				balanceOf[msg.sender] -= amount * decimals;
				totalSupply -= amount*decimals;
			}
		}
	    function viewTotalSUpply() view internal returns(uint){
	        return totalSupply;
		}
}