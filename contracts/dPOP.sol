// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title dPOP governance token implementation contract
/// @author Allan
/// @notice basic ERC20 token for dPOP

contract dPOP is ERC20{
    constructor(address treasuryAddress, uint256 tokenSupply) ERC20("daoPOP", "dPOP"){
        _mint(treasuryAddress, tokenSupply);
    }
}