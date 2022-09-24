// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details


contract participationAdpater{

    /// @notice inherit the SafeMath library from Openzeppelin
    using SafeMath for uint256;

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

    struct memberMetricsVote{
        uint256 id;
        address member;
        uint256 proposal;
        uint256 vote;
        uint256 contribution;
    }

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

    /// @notice this function takes in 3 engagement metrics as set by a member from a (1-10) range
    function setMetrics(uint256 _proposalValue, uint256 _voteValue, uint256 _contribValue) public onlyOwner returns (bool) {
        require(_proposalValue > 10, "Invalid value above maximum");
        require(_voteValue > 10, "Invalid value above maximum");
        require(_contribValue > 10, "Invalid value above maximum");
        
        contributionVal = _contribValue;

        voteVal = _voteValue;

        proposalVal = _proposalValue;

        // memberMetricsVote storage newMemberMetrics = 
        
        return true;
    }

    /// @notice this formula calculates the user participation metric based on parameters set by the members for 
    /// each engegement criteria
    function calculateUserParticipation(address _member) public onlyOwner returns (bool) {
        //m = v+p+c
        uint256 participationVal =  voteVal + proposalVal + contributionVal;

        /// @notice variable to track cumulative participation value for a member using provided metriccs
        uint256 fullValue = 30;
        
        /// @notice divide the cumulative metrics sum out of 30 to get a singular integer measurable metric for the D.A.O's social engagement
        memberParticipationVal[_member] = participationVal.div(fullValue);

        return true;
    }
}