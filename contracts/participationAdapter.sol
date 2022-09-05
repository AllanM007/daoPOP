// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract Treasury{
    modifier onlyOwner() {
        _;
        require(msg.sender == address(0), "INVALID ORIGIN");
    }
}