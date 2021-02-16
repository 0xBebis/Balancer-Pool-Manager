pragma solidity 0.6.12;

import "../Constants.sol";

import { RightsManager } from "../libraries/RightsManager.sol";

/*
*  @title:  Pool Builder
*  @author: Justin Bebis
*  @dev:    Use this contract in conjunction with Balancer's CRPFactory to easily create Balancer Smart Pools.
*/

contract PoolBuilder {

  enum PoolType { Treasury, LBP, Reserve }

  /*
  *  @notice: This struct is identical to the one found in Balancer's ConfigurableRightsPool contract.
  *  @dev:    This struct is fed to the CRPFactory. See setters below for construction logic.
  */

  struct PoolParams {
    string poolTokenSymbol;
    string poolTokenName;
    address[] constituentTokens;
    uint[] tokenBalances;
    uint[] tokenWeights;
    uint swapFee;
    }

    /*
    *  @dev: Change default Rights values within their respective Getter functions below.
    *        These arrays can't be initialized to the rights values, as the CRPFactory rejects them as arguments.
    */

    bool[] treasuryRights;
    bool[] lbpRights;
    bool[] reserveRights;

    /*
    *  @param:  Pool Type 0 = Treasury
    *           Pool Type 1 = Liquidity Bootstrapping Pool
    *           Pool Type 2 = Multi-Asset Reserve
    *  @return: A struct containing Rights, for use as a CRPFactory argument.
    */

    function _constructRights(PoolType _type) internal returns (RightsManager.Rights memory) {
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


    function treasury() public returns (bool[] memory) {
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

    function lbp() public returns (bool[] memory) {
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

    function reserve() public returns (bool[] memory) {
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
