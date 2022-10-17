const { expect } = require("chai");

describe("Token factory", function () {
    it("Should be 0 so far", async function (){
        const [owner] = await ethers.getSigners();
        const Factory = await ethers.getContractFactory("TokenGen");
        const Token = await Factory.deploy();
        const total = await Token.numminted();
        expect(total).to.equal(0);
    });

    it("balance should be 1 after minting", async function (){
        const [owner, addr1, addr2] = await ethers.getSigners();
        const Factory = await ethers.getContractFactory("TokenGen");
        const Token = await Factory.deploy();
        await Token.safeMint(addr1.address);
        expect(await Token.balanceOf(addr1.address)).to.equal(1);
    });

});

describe("Set up Minter with NFT Contract", async function(){
    it("2 addresses should match deployment", async function (){
        const [owner, addr1, addr2] = await ethers.getSigners();
        const Factory = await ethers.getContractFactory("Minter");
        const Minter = await Factory.deploy(addr1.address, addr2.address, 0, 0);
        expect(await Minter.wallet1()).to.equal(addr1.address);
        expect(await Minter.wallet2()).to.equal(addr2.address);
    });

    it("Transfer ownership of Token to minter", async function (){
        const [owner, addr1, addr2] = await ethers.getSigners();
        const Factory = await ethers.getContractFactory("Minter");
        const Gen = await ethers.getContractFactory("TokenGen");
        const Token = await Gen.deploy();
        const Minter = await Factory.deploy(addr1.address, addr2.address, 0, 0);
        await Token.transferOwnership(Minter.address);
        expect(await Token.owner()).to.equal(Minter.address);
    });
});