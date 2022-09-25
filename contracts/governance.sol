// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./treasury.sol";

/// @title dPOP Governance Contract
/// @author Allan
/// @notice This is the main governance implementation contract for daoPOP proposal/voting functions
/// @dev Governance contract inspired by Compound Protocol's GovernorAlpha contract 
/// https://github.com/compound-finance/compound-protocol/blob/master/contracts/Governance/GovernorAlpha.sol

contract governance{

    string public constant name = "daoPOP Governor Alpha";

    /// @notice dPOP token address
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
        string name;
        /// @notice description of the proposal
        string description;
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

    event ProposalCreated(uint256 id, address proposer, string name, string description, uint256 date, uint256 deadline);

    event ProposalCanceled(uint256 id);

    event MemberVote(address voter, uint256 proposalId, bool support);

    /// @notice this event is initiated when a proposal is succesfully executed
    event ProposalExecuted(uint256 id);

    constructor(address tknAddress){
        dPOPAddress = tknAddress;
        proposalCount = 0;
    }

    /// @notice add a member to the D.A.O
    function addMember(address _member) public returns (bool) {
        memberAddresses[_member] =  true;
        return true;
    }

    /// @notice check if member is part of the D.A.O
    function checkMember(address _account) public view returns (bool){
        return memberAddresses[_account];
    }

    /// @notice submit a proposal to the D.A.O for voting
    function propose(address _proposer, string memory _name, string memory _description, uint256 _date, uint256 _deadline) public returns (uint256) {
        require(memberAddresses[_proposer] =  true, "NonMember cannot propose!!");

        proposalCount++;
        
        uint currrentProposalId = proposalCount;

        Proposal storage newProposal = proposal[currrentProposalId];

        require(newProposal.id != 0, "Invalid proposal Id!");

        newProposal.id = currrentProposalId;
        newProposal.proposer = _proposer;
        newProposal.name = _name;
        newProposal.description = _description;
        newProposal.date = _date;
        newProposal.deadline = _deadline;
        newProposal.active = true;
        newProposal.canceled = false;
        newProposal.executed = false;

        emit ProposalCreated(currrentProposalId, _proposer, _name, _description, _date, _deadline);

        return currrentProposalId;
    }

    /// @notice execute status of proposal once it's result is satisfactory
    function execute(uint256 _id) public returns (bool) {
        require(_id> proposalCount, "Invalid ID!!");
        require(proposal[_id].active == true, "Proposal is not active");
        Proposal storage currentProposal = proposal[_id];

        currentProposal.executed = true;

        emit ProposalExecuted(_id);

        return true;
    }

    /// @notice cancel a proposal
    function cancel(uint256 _id) public returns (bool) {
        require(proposalCount > _id, "Invalid ID!!");
    
        Proposal storage currentProposal = proposal[_id];
        
        require(currentProposal.active == true && currentProposal.canceled == false, "Proposal status is invalid!!");

        currentProposal.canceled = true;

        emit ProposalCanceled(_id);

        return true;

    }
    
    /// @notice get vote receipts of specific proposal and member
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

    /// @notice get the cumulative results of a proposal
    function getProposalResult(uint256 proposalId) public view returns (uint, uint) {
        Proposal storage currentProposal = proposal[proposalId];

        return(currentProposal.forVotes, currentProposal.againstVotes);
    }

    /// @notice check the state of a proposal
    function state(uint256 _id) public view returns (bool) {
        Proposal storage currentProposal = proposal[_id];

        return currentProposal.active;
    }

    /// @notice member votes on a given proposal
    function voteProposal(uint256 _id, address _member, bool _vote) public payable returns (bool) {

        Proposal storage currentProposal = proposal[_id];
        Receipt storage memberReceipt = currentProposal.receipts[_member];

        require(currentProposal.active == true, "Proposal status is inactive!!");
        require(memberReceipt.hasVoted == false, "Member has already voted on this proposal");

        if (_vote) {

            currentProposal.forVotes ++;

        } else {
            currentProposal.againstVotes ++;   
        }

        memberReceipt.hasVoted = true;
        memberReceipt.support = _vote;
        memberReceipt.votes ++;

        emit MemberVote(_member, _id, _vote);

    }  
}