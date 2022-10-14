pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ITokenGen is IERC721 {
    function safeMint(address to)external;
}