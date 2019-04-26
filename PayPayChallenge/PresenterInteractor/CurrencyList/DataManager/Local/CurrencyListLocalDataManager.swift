//
// CurrencyListLocalDataManager.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//


import Foundation

class CurrencyListLocalDataManager: CurrencyListLocalDataManagerInputProtocol
{
    init() {}
    
    func loadCurrencyListArrayFromBundle() -> Dictionary<String,String> {
        var data:Dictionary<String,String> = [:]
        
        CoreDataOperation.shared.getParsedData(entityName: "Country", attributeName: "country"){
            (responseData2:Currency?) in
            data = (responseData2?.currencies!)!
        }
     return data
    }
}
