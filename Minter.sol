//SPDX-License-Identifier: UNIDENTIFIED

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Minter {

    //Authorized wallets
    address public wallet1;

    address public wallet2;

    //Payment Token
    address public paytok;

    //ERC20 to pay for minting
    function mint()external payable{


    }


    //handle withdrawal to 2 wallets

    function withdraw() external onlyOwners {
        uint256 bal = IERC20(paytok).balanceOf(address(this));
        IERC20(paytok).transfer(wallet1,bal/2);
        IERC20(paytok).transfer(wallet2,bal/2);

    }

    modifier onlyOwners(){
        require(msg.sender == wallet1 || msg.sender == wallet2, "Not an authorized wallet");

        _;
    }
}