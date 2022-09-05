// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./treasury.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract vote{

    address public dPOPAddress;
    uint256 public minVoteCount;
    uint256 public maxVoteCount;
    uint256 public proposals;

    struct Proposal {
        uint256 id;
        address proposer;
        bytes32 name;
        uint256 votes;
        /// @notice Current number of votes in favor of this proposal
        uint forVotes;
        /// @notice Current number of votes in opposition to this proposal
        uint againstVotes;
        uint256 date;
        uint256 deadline;
    }

    constructor(address tknAddress){
        dPOPAddress = tknAddress;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    // @param Documents a parameter just like in doxygen (must be followed by parameter name)
    // @return Documents the return variables of a contract’s function state variable
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    function voteProposal() public payable returns (bool) {}

    function name() public returns (bool) {}

    function delegateTokens() public returns (bool) {}

    
}