// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./treasury.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract governance{

    /// @notice dPOP token address parameter
    address public dPOPAddress;
    /// @notice conditional integer to track vote count a proposal cannot go below
    uint256 public minVoteCount;
    /// @notice conditional integer to track vote count a proposal has to achieve
    uint256 public maxVoteCount;
    /// @notice integer to track proposalCount
    uint256 private proposalCount;
    /// @notice mapping to track membership if addresses
    mapping(address => bool) public memberAddresses;
    /// @notice mapping to track vote receipts of members
    mapping(address => Receipt) receipts;
    /// @notice mapping to easily track proposals
    mapping(uint256 => Proposal) proposal;

    struct Proposal {
        /// @notice id for identifying proposal
        uint256 id;
        /// @notice address of the proposer
        address proposer;
        /// @notice name of the proposal
        bytes32 name;
        /// @notice Current number of votes in favor of this proposal
        uint forVotes;
        /// @notice Current number of votes in opposition to this proposal
        uint againstVotes;
        /// @notice date when proposal was submitted
        uint256 date;
        /// @notice date when proposal voting should be completed
        uint256 deadline;
        /// @notice cancellation status of proposal
        bool active;
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

    enum voteOutcome { yes, maybe, no }

    event ProposalCreated(uint256 id, address proposer, string description, uint256 date, uint256 deadline);

    event ProposalCanceled(uint256 id);

    event MemberVote(address voter, uint256 proposalId, bool support, uint256 votes);

    /// @notice this event is initiated when a proposal is succesfully executed
    event ProposalExecuted(uint256 id);

    constructor(address tknAddress){
        dPOPAddress = tknAddress;
        proposalCount = 0;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    // @param Documents a parameter just like in doxygen (must be followed by parameter name)
    // @return Documents the return variables of a contract’s function state variable
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    function addMember(address _member) public returns (bool) {
        memberAddresses[_member] =  true;
        return true;
    }

    function checkMember(address _account) public view returns (bool){
        return memberAddresses[_account];
    }

    function propose(address _proposer, bytes32 _name, uint256 _date, uint256 _deadline) public returns (bool) {
        require(memberAddresses[_proposer] =  true, "NonMember cannot propose!!");
        uint256 currrentpProposalId = proposalCount;

        // proposal[proposalCount++] = Proposal(
        //     proposalCount++,
        //     _proposer,
        //     _name,
        //     _date,
        //     _deadline,
        //     false,
        //     false,
        //     0,
        //     receipts[_proposer] = 0
        // );


        proposalCount++;
    }
    function execute(uint256 _id) public returns (bool) {
        require(_id> proposalCount, "Invalid ID!!");
        require(proposal[_id].active == true, "Proposal is not active");
        Proposal storage currentProposal = proposal[_id];

        currentProposal.executed = true;

        emit ProposalExecuted(_id);

        return true;
    }
    function cancel(uint256 _id) public returns (bool) {
        require(proposalCount > _id, "Invalid ID!!");
    
        Proposal storage currentProposal = proposal[_id];
        
        require(currentProposal.active == true && currentProposal.canceled == false, "Proposal status is invalid!!");

        currentProposal.canceled = true;

        emit ProposalCanceled(_id);

        return true;

    }
    function getReceipts(uint256 _proposalId, address _member) public view returns (bool, bool, uint256) {

        Proposal storage currentProposal = proposal[_proposalId];

        if (currentProposal.proposer == _member) {

            Receipt storage memberReceipt = currentProposal.receipts[_member];

            return (memberReceipt.hasVoted, memberReceipt.support, memberReceipt.votes);
        } else {
            return (false, false, 0);
        }
    }
    // function getProposal(uint256 _proposalId, address _member) public view returns (/// @notice address of the proposer
    //     address, bytes32, uint, uint, uint256, uint256, bool, bool, bool, mapping(address => Receipt) receipts;) {
    //     Proposal storage currentProposal = proposal[_proposalId];

    //     return true;
    // }
    function getProposalResult(uint256 proposalId) public view returns (uint, uint) {
        Proposal storage currentProposal = proposal[proposalId];

        return(currentProposal.forVotes, currentProposal.againstVotes);
    }
    function state(uint256 _id) public view returns (bool) {
        Proposal storage currentProposal = proposal[_id];

        return currentProposal.active;
    }
    function voteProposal(uint256 _id, address _member, uint256 _forVote, uint256 _againstVote) public payable returns (bool) {}
        
}