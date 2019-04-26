//
//  CurrencyListItem.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation

struct CurrencyListItem
{
    var currencyName : String
    var code : String
    var symbol : String
    
    init(currencyName: String, code: String, symbol: String) {
        self.currencyName = currencyName
        self.code = code
        self.symbol = symbol
    }
}
