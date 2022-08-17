const ERC20 = artifacts.require("ERC20");
const addDecimals = 1000000000000000000;
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
    it("Should be 18 decimals ", async () => {
        let decimals = await ERC20Token.decimalslength();
        let decimalLength = BigInt(decimals);
        assert(decimalLength.toString() == addDecimals)
    })
})

const INR = artifacts.require("inrToken");

contract("INR Token", async (account) => {

    let INRtoken = null;
    before(async () => {
        INRtoken = await INR.deployed();
    })

    it("Currency and token should be Indian rupee and INR", async () => {
        let nameOfThetoken = await INRtoken.coinName();
        let symbolOfTheToken = await INRtoken.symbolOfToken();
        assert((nameOfThetoken.toString() == "Indian Rupee") && (symbolOfTheToken.toString() == "INR"))
    })

    it("Coin should add and it will mint a INRtoken", async () => {
        await INRtoken.addNewCoin(123);
        let afterMint = await INRtoken.totalINRtoken();
        assert(BigInt(afterMint).toString() == 123 * addDecimals)
    })

    it("Coin and token value should be equal always ", async () => {
        await INRtoken.addNewCoin(123);
        // await INRtoken.mintNewINRToken(123);
        let totalINRtoken = await INRtoken.totalINRtoken();
        let coin = await INRtoken.Coin();
        assert(coin * addDecimals == totalINRtoken)
    })

    it("Coin can remove and it will burn a INRtoken ", async () => {
        await INRtoken.removeINR(12);
        let totalINRtoken = await INRtoken.totalINRtoken();
        let coin = await INRtoken.Coin();
        assert(coin * addDecimals == totalINRtoken)
    })

    it("Token should be transfer ", async () => {
        let transaction = await INRtoken.transferToken(account[4], 13);
        assert(transaction.receipt.status == true);
    })

    it("Checing TransferFrom function as well ", async () => {
        let transaction = await INRtoken.transferTokenFrom(account[4], account[3], 5);
        assert(transaction.receipt.status == true);
    })
})