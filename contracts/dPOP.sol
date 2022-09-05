// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract dPOP is ERC20{
    constructor(address treasuryAddress, uint256 tokenSupply) ERC20("daoPOP", "dPOP"){
        _mint(treasuryAddress, tokenSupply);
    }
}