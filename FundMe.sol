//This function will do:

//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";



contract FundMe {

     using PriceConverter for uint256;

     uint256 public minimumUsd = 50 * 1e18;
     address[] public funders; // here we will store the the address of funders

     mapping(address=>uint256) public addressToAmountFunded;
     

    

    function fund() public payable {    // payable make this function able to fund ..It wil mark as red 
         //Want to be able to set a minimum fund amount in USD

         //1.How do we send ETH to this contract?


         // require is like condition checking in solidity
         require( msg.value.getConversionRate() >= minimumUsd, "Fund is not enough"); //1e18 wei = 1 ETH  
         // msg.value is global data
         
         funders.push(msg.sender); // msg.sender is global...It will return a address
          
         addressToAmountFunded[msg.sender]+= msg.value;
         //What is reverting?
         // undo any action before, and sned remaining gas back
    }




//     function getPrice() public view returns(uint256) {
          
//          //Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e;   // This is the address of goerile testnet
         
//          AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
//          (, int256 price,,,)=priceFeed.latestRoundData();
//          // price will be ETH terms of usd
//          // 3000.00000000

//          return uint256(price*1e10);  //1e10 

//     }
    






//     function getVersion() public view returns(uint256){

//           AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
//           return priceFeed.version();
//     }






    
//     function getConversionRate(uint256 ethAmount) public view returns(uint256){

//          uint256 ethPrice = getPrice();
         
//          // 3000_000000000000000000 = ETH / USD price
//          // 1_000000000000000000 ETH
         


//          uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1e18;

//          return ethAmountInUsd;

//     }






     function withdraw() public {

              /* starting index, ending index, step amount */

              for(uint256 funderIndex = 0; funderIndex<funders.length ; funderIndex++)
              {
                   address funder = funders[funderIndex];

                   addressToAmountFunded[funder] = 0;
              }

     }

     // reset the array 
    // funders = new address[](0); //the array will be completely blank array
        
     

        
        // sending ether in three different ways

     // 1. transfer  (need 2300 gas,if not success , throws error)
    // payable(msg.sender).transfer(address(this).balance);   // here payable is used for typecasting

     // 2. send    (need 2300 gas , returns bool)
   //  bool sendSuccess = payable(msg.sender).send(address(this).balance);
   //  require(sendSuccess,"Send failed");

     // 3. call (forward all gas or set gas, returns bool)
    // (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    // require(callSuccess,"Call failed");


}