const ERC20 = artifacts.require("ERC20");
const decima = 1000000000000000000;
var address = null;

contract("ERC20", async (account) => {

    let ERC20Token = null;
    before(async () => {
        ERC20Token = await ERC20.deployed();
    })
    console.log(account);
    const [owner, ...otherAccounts] = account;
    it("Contract should be deployed", async () => {
        const ERC20Token = await ERC20.deployed();
        console.log(" ERC20Token.address : ", ERC20Token.address);
        address = ERC20Token.address;
        assert(ERC20Token.address)
    })
    it("Currency and token should be Indian rupee and INR", async () => {
        let nameOfThetoken = await ERC20Token.tokenName();
        let symbolOfTheToken = await ERC20Token.tokenSymbol();
        assert((nameOfThetoken.toString() == "Indian Rupee") && (symbolOfTheToken.toString() == "INR"))
    })
    it("Checking admin as a owner ", async () => {
        let admin = await ERC20Token.viewOwner();
        assert(admin.toString() == owner);
    })
    it("Should be 18 decimals ", async () => {
        let decimals = await ERC20Token.decimalslength();
        let decimalLength = BigInt(decimals);
        assert(decimalLength.toString() == decima)
    })
    it("Token should be mint ", async () => {
        await ERC20Token.mint(123);
        let TotalValue = await ERC20Token.viewTotalSUpply();
        assert(TotalValue == 123 * decima)
    })

    it("Token should be burn ", async () => {
        try {
            await ERC20Token.burn(12);
            let afterBurn = await ERC20Token.viewTotalSUpply();
            assert((BigInt(afterBurn).toString()) == 111 * decima);
        }
        catch (error) {
            console.log(" error : message  : ", error.message)
        }
    })
})

const INR = artifacts.require("inrToken");

contract("INR Token", async (account) => {

    let INRtoken = null;
    before(async () => {
        INRtoken = await INR.deployed();
    })

    it("Set the address of the ERC20 contract address ", async () => {
        let Address = await INRtoken.setAddress(address);
        assert(Address)
    })

    it("Coin should add", async () => {
        let addCoin = await INRtoken.addNewCoin(123);
    })

    it("Coin and token value should be equal always ", async () => {
        await INRtoken.addNewCoin(123);
        await INRtoken.mintNewINRToken(123);
        let totalINRtoken = await INRtoken.totalINRtoken();
        let coin = await INRtoken.Coin();
        assert(coin * decima == totalINRtoken)
    })

    it("Token should be transfer ", async () => {
        let transaction = await INRtoken.transfer(account[4],13);
        assert(transaction.receipt.status == true);
    })

    it("Checing TransferFrom function as well ", async () => {
        let transaction = await INRtoken.transferFrom(account[4],account[3],5);
        assert(transaction.receipt.status == true);
    })
})