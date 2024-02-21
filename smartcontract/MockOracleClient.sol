/// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

interface ISupraOraclePull {

    //Verified price data
    struct PriceData {
        // List of pairs
        uint256[] pairs;
        // List of prices
        // prices[i] is the price of pairs[i]
        uint256[] prices;
        // List of decimals
        // decimals[i] is the decimals of pairs[i]
        uint256[] decimals;
    }


    function verifyOracleProof(bytes calldata _bytesproof) external  returns (PriceData memory);

}

// Mock contract which can consume oracle pull data
contract MockOracleClient is Ownable{
    // The oracle contract
    ISupraOraclePull internal oracle;

    constructor(address oracle_) Ownable(msg.sender){
        oracle = ISupraOraclePull(oracle_);
    }

    // Extract price data from the bytes/proof data
    function deliverPriceData(bytes calldata _bytesProof) external onlyOwner {
    
        ISupraOraclePull.PriceData memory prices = oracle.verifyOracleProof(_bytesProof);
        
        //Iterate over all the extracted prices.
        //Do something with them!
        for (uint256 i = 0; i < prices.pairs.length; i++) {
            //prices.pairs[i] - The pair ID at the current position. 
            //prices.prices[i] - The price of the pair ID at the current position.
            //prices.decimals[i] - The decimal places of the pair ID at the current position.
        }

    }

    function updatePullAddress(address oracle_) 
    external onlyOwner {
        oracle = ISupraOraclePull(oracle_);
    }
}
