pragma solidity 0.6.12;

import "../Constants.sol";
import "../common/CRPFactory.sol";
import "../common/ConfigurableRightsPool";
import "../libraries/SmartPoolManager.sol";

import { RightsManager } from "../libraries/RightsManager.sol";

/*
*  @title:  Pool Builder
*  @author: Justin Bebis
*  @dev:    Use this contract in conjunction with Balancer's CRPFactory to easily create Balancer Smart Pools.
*/

interface ICRPFactory {

  function newCrp (
      address factoryAddress,
      ConfigurableRightsPool.PoolParams calldata poolParams,
      RightsManager.Rights calldata rights
  )
      external
      returns (ConfigurableRightsPool);

}

contract PoolBuilder {

    enum PoolType { Treasury, LBP, Reserve }

    uint constant decimals = 1000000000000000000;

    string poolTokenSymbol;
    string poolTokenName;
    address[] constituentTokens;
    uint[] tokenBalances;
    uint[] tokenWeights;
    uint swapFee;

    bool[] treasuryRights;
    bool[] lbpRights;
    bool[] reserveRights;


    /*
    *  @dev: Change default Rights values within their respective Getter functions below.
    *        These arrays can't be initialized to the rights values, as the CRPFactory rejects them as arguments.
    */

    function addConstituentToken (address token, uint _balance, uint _weight) public returns (bool) {
      uint balance = _balance.mul(decimals);
      uint weight = _weight.mul(decimals);
      constituentTokens.push(token);
      tokenBalances.push(balance);
      tokenWeights.push(weight);
      return true;
    }

    function nameToken (string _symbol, string _name) public returns (bool) {
      poolTokenSymbol = symbol;
      poolTokenName = name;
      return true;
    }

    function setSwapFee (uint _swapFeePercent) public returns (bool) {
      swapFee = _swapFee;
    }

    /*
    *  @param:  Pool Type 0 = Treasury
    *           Pool Type 1 = Liquidity Bootstrapping Pool
    *           Pool Type 2 = Multi-Asset Reserve
    *  @return: A struct containing Rights, for use as a CRPFactory argument.
    */

    function constructRights (PoolType _type) internal returns (RightsManager.Rights memory) {
      if (_type == PoolType.Treasury) {
        return RightsManager.constructRights(treasury());
      } else if (_type == PoolType.LBP) {
        return RightsManager.constructRights(lbp());
      } else if (_type == PoolType.Reserve) {
        return RightsManager.constructRights(reserve());
      } else {
        revert("invalid input");
      }
    }

    /*
    *  @returns: treasury() = Balancer's recommended Smart Treasury configuration
    *            lbp()      = Balancer's recommended Liquidity Bootstrapping Pool configuration
    *            reserve()  = Rosen's custom multi-asset reserve configuration
    */


    function treasury () public returns (bool[] memory) {
      if (treasuryRights.length == 6) {
        return treasuryRights;
      } else {
        treasuryRights.push(true);
        treasuryRights.push(true);
        treasuryRights.push(false);
        treasuryRights.push(false);
        treasuryRights.push(true);
        treasuryRights.push(false);
        return treasuryRights;
      }
    }

    function lbp () public returns (bool[] memory) {
      if (lbpRights.length == 6) {
        return lbpRights;
      } else {
        lbpRights.push(true);
        lbpRights.push(false);
        lbpRights.push(true);
        lbpRights.push(true);
        lbpRights.push(true);
        lbpRights.push(false);
        return lbpRights;
      }
    }

    function reserve () public returns (bool[] memory) {
      if (reserveRights.length == 6) {
        return reserveRights;
      } else {
        reserveRights.push(false);
        reserveRights.push(true);
        reserveRights.push(true);
        reserveRights.push(true);
        reserveRights.push(false);
        reserveRights.push(false);
        return reserveRights;
      }
    }

}
