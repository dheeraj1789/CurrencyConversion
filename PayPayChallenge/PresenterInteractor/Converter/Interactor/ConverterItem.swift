//
// ConverterItem.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//

import Foundation

struct ConverterItem {
    /**
    *  Attributes here
    */
    var currencyName : String
   
    var code : String
    var amount : String
    var convertedAmount : String
    var convertedList : [ConverterItem]
    var isFreshLoad : Bool

    init(currencyName: String, code: String, amount: String) {
        self.currencyName = currencyName
        self.code = code
        self.amount = amount
        self.convertedAmount = self.amount
        self.isFreshLoad = false
        self.convertedList = []
    }
}
