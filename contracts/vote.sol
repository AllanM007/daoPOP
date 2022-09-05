// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract vote{

    mapping(string => uint256) proposalVotes;

    constructor(){}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    // @param Documents a parameter just like in doxygen (must be followed by parameter name)
    // @return Documents the return variables of a contract’s function state variable
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    function voteProposal() public returns (bool) {}

    function name() public returns (bool) {}
}