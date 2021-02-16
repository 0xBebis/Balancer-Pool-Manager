pragma solidity 0.6.12;

contract Constants {

// Kovan
  address _bFactory = 0x8f7F78080219d4066A8036ccD30D588B416a40DB;
  address _crpFactory = 0x53265f0e014995363AE54DAd7059c018BaDbcD74;
  address _bPool = 0x8d527ddd8318A253647868CDdC1f5eF479b80008;
  address _configurableRightsPool = 0xeFbc366b57aa1c91dDE87b09367310F973D7aB8c;
  address _balancerProxy = 0x5086D91858A5AAC4A770212720B297F38e0DD403;
  // address _balancerPoolManager = 0x6cb30414B2B860b9f3b1aF679DF7e51d9b2c7744;
  // address Pool
  // address DAO
  // address PriceOracle
  address constant sJPY = 0xCcC5c7625c90FC93D2508723e60281E6DE535166;
  address constant sGBP = 0x41d49b1ac182C9d2c8dDf8b450342DE2Ac03aC19;
  address constant sEUR = 0x57E8Bd85F3d8De4557739bc3C5ee0f4bfC931528;
  address constant sUSD = 0x57Ab1ec28D129707052df4dF418D58a2D46d5f51;

  function bFactory() public view returns (address) {
    return _bFactory;
  }

  function crpFactory() public view returns (address) {
    return _crpFactory;
  }

  function bPool() public view returns (address) {
    return _bPool;
  }

  function CRP() public view returns (address) {
    return _crpFactory;
  }

  function bProxy() public view returns (address) {
    return _balancerProxy;
  }

  function JPY() public view returns (address) {
    return sJPY;
  }

  function GBP() public view returns (address) {
    return sGBP;
  }

  function EUR() public view returns (address) {
    return sEUR;
  }

  function USD() public view returns (address) {
    return sUSD;
  }

}
