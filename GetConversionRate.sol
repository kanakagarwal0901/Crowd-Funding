// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function GetValue() public view returns(uint){
        AggregatorV3Interface Feed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,) =  Feed.latestRoundData();
        return uint(price * 1e10);
    }
    function GetVersion() public view returns(uint){
        AggregatorV3Interface Feed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return Feed.version();
    }
    function Conversion(uint EthValue) public view returns(uint){
        uint UnitPrice = GetValue();
        uint usd =  (UnitPrice * EthValue)/1e18;
        return usd;
    }
}
