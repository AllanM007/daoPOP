// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details


contract participationAdpater{

    /// @notice value to track D.A.O proposal value as set by the community
    uint256 proposalVal;
    /// @notice value to track D.A.O cast vote value as set by the community
    uint256 voteVal;
    /// @notice value to track D.A.O contribution value as set by the community
    uint256 contributionVal;
    /// @notice value to store governance contract address
    address private governanceContract;

    /// @notice mapping to track each member's participation value
    mapping(address => uint256) memberParticipationVal;

    event SetEngagementMetrics();

    constructor(address _govContract){
        governanceContract = _govContract;
    }

    /// @notice this modifier makes sure only the governance contract can call the participationAdapter functions
    modifier onlyOwner() {
        _;
        require(msg.sender == governanceContract, "INVALID ORIGIN");
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    // @param Documents a parameter just like in doxygen (must be followed by parameter name)
    /// @return true if the assignment works
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    /// @notice this formula sets the contribution value metric based on parameters set by the members from a (1-10) range
    function setproposalVal(uint256 _proposalValue) public onlyOwner returns (bool) {
        require(_proposalValue > 10, "Invalid value above maximum");

        proposalVal = _proposalValue;
        
        return true;
    }

    /// @notice this formula sets the vote value metric based on parameters set by the members from a (1-10) range
    function setvoteVal(uint256 _voteValue) public onlyOwner returns (bool) {
        require(_voteValue > 10, "Invalid value above maximum");

        voteVal = _voteValue;
        
        return true;
    }

    /// @notice this formula sets the contribution value metric based on parameters set by the members from a (1-10) range
    function setcontribVal(uint256 _contribValue) public onlyOwner returns (bool) {
        require(_contribValue > 10, "Invalid value above maximum");
        contributionVal = _contribValue;

        return true;
    }

    /// @notice this formula calculates the user participation metric based on parameters set by the members for 
    /// each engegement criteria
    function calculateUserParticipation(address _member) public onlyOwner returns (bool) {
        //m = v+p+c
        uint256 participationVal =  voteVal + proposalVal + contributionVal;
        
        /// @notice divide the cumulative metrics sum out of 30 to get a singular integer measurable metric for the D.A.O's social engagement
        
        memberParticipationVal[_member] = participationVal / 30;

        return true;
    }
}