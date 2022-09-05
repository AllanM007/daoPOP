// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract treasury{

    uint256 public exchangeRate;
    address dPOPAddress;
    mapping(address => uint256) public accountTokenBalances;

    event succesfulExchangeRate(uint256 rate);
    event succesfulFundDeployment(address account, uint256 amount);
    event succesfulJoinTransfer(address account, uint256 amount);
    event succesfulExitTransfer(address account, uint256 amount);

    constructor(address tokenAddress){
        dPOPAddress = tokenAddress;
    }

    function transferdPOP(address _recipientAddress, uint256 _amount) public returns (bool) {
        ERC20(dPOPAddress).transfer(_recipientAddress, _amount);

        accountTokenBalances[_recipientAddress] = _amount; 

        emit succesfulJoinTransfer(_recipientAddress, _amount);

        return true;
    }

    /// @notice sets exchange rate for dPOP/ETH which is decided by the community members
    /// @dev this private function sets/updates the exchangeRate variable
    // @param just like in doxygen (must be followed by parameter name)
    /// @return true if the update was succesful
    // @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

    function setExchangeRate(uint256 _fxRate) private returns (bool) {

        exchangeRate = _fxRate;

        emit succesfulExchangeRate(_fxRate);

        return true;
    }

    function deployFunds(address _recipientAddress, uint256 _amount) public returns (bool) {

        ERC20(address(0)).transfer(_recipientAddress, _amount);

        emit succesfulFundDeployment(_recipientAddress, _amount);

        return true;   
    }

    function transferETH(address _recipientAddress, uint256 _amount) public returns (bool) {
        
        ERC20(address(0)).transfer(_recipientAddress, _amount);

        accountTokenBalances[_recipientAddress] = _amount; 

        emit succesfulExitTransfer(_recipientAddress, _amount);

        return true;
    }
}