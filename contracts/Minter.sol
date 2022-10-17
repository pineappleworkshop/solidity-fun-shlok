//SPDX-License-Identifier: UNIDENTIFIED

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/ITokenGen.sol";
import "./TokenGen.sol";
import "./interfaces/IOwnership.sol";

contract Minter {

    //Authorized wallets
    address public wallet1;

    address public wallet2;

    //Payment Token
    address public paytok;

    uint256 public mintpriceerc20;

    uint256 public mintprice;

    // Minting Contract
    address public minter;

    bool ERC20Sel;

    constructor(address w1, address w2, uint256 mperc20, uint256 mp, bool erc20sel){ 
        wallet1 = w1; 
        wallet2 = w2;
        mintpriceerc20 = mperc20;
        mintprice = mp;
        ERC20Sel = erc20sel;
    }

    //ERC20 to pay for minting, you can also choose a preset ETH price
    function mint(uint256 nummint)external payable{
        
        if(ERC20Sel){
            IERC20(paytok).transferFrom(msg.sender, address(this), mintpriceerc20 * nummint);
            ITokenGen(minter).safeMint(msg.sender);

        }
        else{
            require(msg.value>= mintprice * nummint, "Not enough ETH to mint, choose ERC20 minting or get more ETH");
            ITokenGen(minter).safeMint(msg.sender);
        }


    }

    function setmintprice(uint256 newprice) external onlyOwners{
        mintprice = newprice;
    }

    function setmintpriceerc20(uint256 newprice) external onlyOwners{
        mintpriceerc20 = newprice;
    }

    function setwallets(address w1, address w2) external onlyOwners{
        wallet1 = w1;
        wallet2 = w2;
    }

    function setminter(address m2)external onlyOwners{
        minter = m2;
    }
    //handle withdrawal to 2 wallets

    function withdraw() external onlyOwners {
        uint256 bal = IERC20(paytok).balanceOf(address(this));
        IERC20(paytok).transferFrom(address(this), wallet1, bal/2);
        IERC20(paytok).transferFrom(address(this), wallet2, bal/2);

    }

    function transfertokenownership(address newowner)external onlyOwners{
        IOwnership(minter).transferOwnership(newowner);
    }

    modifier onlyOwners(){
        require(msg.sender == wallet1 || msg.sender == wallet2, "Not an authorized wallet");

        _;
    }
}