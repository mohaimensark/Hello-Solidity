//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;


import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // This is importing from github


library PriceConverter{

       

    function getPrice() internal view returns(uint256) {
          
         //Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e;   // This is the address of goerile testnet
         
         AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
         (, int256 price,,,)=priceFeed.latestRoundData();
         // price will be ETH terms of usd
         // 3000.00000000

         return uint256(price*1e10);  //1e10 

    }
    






    function getVersion() internal view returns(uint256){

          AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
          return priceFeed.version();
    }






    
    function getConversionRate(uint256 ethAmount) internal view returns(uint256){

         uint256 ethPrice = getPrice();
         
         // 3000_000000000000000000 = ETH / USD price
         // 1_000000000000000000 ETH
         


         uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1e18;

         return ethAmountInUsd;

    }






}