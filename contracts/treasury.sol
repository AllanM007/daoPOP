// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract treasury{

    address dPOPAddress;
    uint256 public exchangeRate;
    uint256 public totalTokenHolders;
    mapping(address => uint256) public accountTokenBalances;

    event succesfulExchangeRate(uint256 rate);
    event succesfulJoinTransfer(address account, uint256 amount);
    event succesfulExitTransfer(address account, uint256 amount);
    event succesfulFundDeployment(address account, uint256 amount);

    constructor(address tokenAddress){
        dPOPAddress = tokenAddress;
        totalTokenHolders = 0;
    }

    function transferdPOP(address _recipientAddress, uint256 _amount) public returns (bool) {
        ERC20(dPOPAddress).transfer(_recipientAddress, _amount);

        accountTokenBalances[_recipientAddress] = _amount; 

        totalTokenHolders ++;

        emit succesfulJoinTransfer(_recipientAddress, _amount);

        return true;
    }

    /// @notice sets exchange rate for dPOP/ETH which is decided by the community members
    /// @dev this private function sets/updates the exchangeRate variable
    /// @return true if the update was succesful

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