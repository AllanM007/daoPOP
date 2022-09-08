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

    /// @notice mapping to track each member's contribution value
    mapping(address => uint256) memberContribVal;

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

    function setproposalVal(uint256 _proposalValue) public onlyOwner returns (bool) {
        proposalVal = _proposalValue;
        
        return true;
    }

    function setvoteVal(uint256 _voteValue) public onlyOwner returns (bool) {
        voteVal = _voteValue;
        
        return true;
    }

    function setcontribVal(uint256 _contribValue) public onlyOwner returns (bool) {
        contributionVal = _contribValue;

        return true;
    }

    function calculateUserParticipation() public onlyOwner returns (bool) {
     //m = v+p+c   
    }
}