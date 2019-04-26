//
// ConverterInteractor.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//


import Foundation

class ConverterInteractor: ConverterInteractorInputProtocol
{
    weak var presenter: ConverterInteractorOutputProtocol?
    var APIDataManager: ConverterAPIDataManagerInputProtocol?
    var localDatamanager: ConverterLocalDataManagerInputProtocol?
    
    init() {}
    
    /**
     * Methods for communication PRESENTER -> INTERACTOR
     */
    
    func initWithBaseCurrencyAndLoad() {
        let converterItem = ConverterItem(currencyName: "United States Dollar", code: "USD", amount: "1")
        self.presenter?.initWithBaseConverterItem(converterItem)
    }

    func getCurrencyWithData(_ baseConverterItemObject: ConverterItem) {
        var baseConverterItem = baseConverterItemObject
        if baseConverterItem.isFreshLoad == true {
            
            CoreDataOperation.shared.getParsedData(entityName: "Currencies", attributeName: "currency"){
                (responseData:CountryRate?) in
           var exchangeData = responseData?.quotes
                if exchangeData != nil && exchangeData!.count > 0{
                    var converterItems = [ConverterItem]()
                CoreDataOperation.shared.getParsedData(entityName: "Country", attributeName: "country"){
                    (responseData2:Currency?) in
             
                   
                    let listArray = responseData2?.currencies
                    if listArray != nil && listArray!.count>0{
                  
                    
                    for (key, value) in listArray!  {
                        
                        let keyValue = "USD\(key)"
                        
                        let baseKeyValue = "USD\(baseConverterItem.code)"
                        let filteredCountryData = exchangeData![keyValue]!
                        let exhangeBaseValue = exchangeData![baseKeyValue]!
               
                    let amount = (filteredCountryData/exhangeBaseValue)*((baseConverterItem.amount as NSString).floatValue)
                        
                        let converterItem = ConverterItem(currencyName: "\(value)",code: key, amount:"\(amount)")
                            converterItems.append(converterItem)
                      //  }
                    }
                    baseConverterItem.convertedList = converterItems
                    self.presenter?.fetchedConvertedCurrency(self.returnConverterItemsWithBaseConverter(baseConverterItem: baseConverterItem))
                    }
                }
            }
            }
        } else {
            self.presenter?.fetchedConvertedCurrency(self.returnConverterItemsWithBaseConverter(baseConverterItem: baseConverterItem))
        }
    }
    
    func returnConverterItemsWithBaseConverter(baseConverterItem : ConverterItem) -> [ConverterItem] {
        var baseAmount = baseConverterItem.amount
        if (baseConverterItem.amount.isEmpty || Double(baseConverterItem.amount) == 0 || Double(baseConverterItem.amount) == nil) {
            baseAmount = "1"
        } else {
            baseAmount = baseConverterItem.amount.replacingOccurrences(of: ",", with: "")
        }
        
        var convertedList = baseConverterItem.convertedList
        
        for i in stride(from: 0, to: convertedList.count, by: 1) {
            var converterItem = convertedList[i] as ConverterItem
            let convertedAmount = Double(baseAmount)! * Double(converterItem.amount)!
            converterItem.convertedAmount = NSString (format : "%.4f", Double(convertedAmount)) as String
            
            convertedList[i] = converterItem
        }
        return convertedList
    }
}
