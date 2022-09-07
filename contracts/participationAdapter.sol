// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details


contract participationAdpater{

    uint256 proposalVal;
    uint256 voteVal;
    uint256 contributionVal;

    modifier onlyOwner() {
        _;
        require(msg.sender == address(0), "INVALID ORIGIN");
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    // @param Documents a parameter just like in doxygen (must be followed by parameter name)
    /// @return true if the assignment works
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    function setproposalVal() public returns (bool) {
        
    }

    function setvoteVal() public returns (bool) {
        
    }

    function setcontribVal() public returns (bool) {
        
    }

    function setUserParticipation() public returns (bool) {
        
    }
}