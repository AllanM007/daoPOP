// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./treasury.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract governance{

    address public dPOPAddress;
    uint256 public minVoteCount;
    uint256 public maxVoteCount;
    uint256 public proposalCount;
    address[] public memberAddresses;
    mapping(address => Receipt) receipts;
    /// @notice mapping to easily track proposals
    mapping(address => Proposal) proposals;

    struct Proposal {
        /// @notice id for identifying proposal
        uint256 id;
        /// @notice address of the proposer
        address proposer;
        /// @notice name of the proposal
        bytes32 name;
        /// @notice number of votes a proposal has
        uint256 votes;
        /// @notice Current number of votes in favor of this proposal
        uint forVotes;
        /// @notice Current number of votes in opposition to this proposal
        uint againstVotes;
        /// @notice date when proposal was submitted
        uint256 date;
        /// @notice date when proposal voting should be completed
        uint256 deadline;
        /// @notice cancellation status of proposal
        bool canceled;
        /// @notice execution status of proposal
        bool executed;
        /// @notice vote receipts for each member@proposal
        mapping(address => Receipt) receipts;
    }

    struct Receipt {
        /// @notice boolean whether user has voted
        bool hasVoted;
        /// @notice boolean whether the member supports the proposal or not
        bool support;
        /// @notice number of votes user had based on their tokenCount
        uint256 votes;
    }

    event ProposalCreated(uint256 id, address proposer, string description, uint256 date, uint256 deadline);

    event ProposalCanceled(uint256 id);

    event MemberVote(address voter, uint256 proposalId, bool support, uint256 votes);

    event ProposalExecuted(uint256 id);

    constructor(address tknAddress){
        dPOPAddress = tknAddress;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    // @param Documents a parameter just like in doxygen (must be followed by parameter name)
    // @return Documents the return variables of a contract’s function state variable
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    function propose() public returns (bool) {}
    function execute() public returns (bool) {}
    function cancel() public returns (bool) {}
    function getReceipts(uint256 proposalId, address voter) public returns (bool) {}
    function getProposal(uint256 proposalId, address voter) public returns (bool) {}
    function getProposalResult(uint256 proposalId, address voter) public returns (bool) {}
    function state() public returns (bool) {}
    function voteProposal() public payable returns (bool) {}
    function delegateTokens() public returns (bool) {}

    
}