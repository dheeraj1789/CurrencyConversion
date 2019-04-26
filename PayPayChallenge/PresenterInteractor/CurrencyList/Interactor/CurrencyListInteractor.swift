//
//  CurrencyListInteractor.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//

import Foundation

class CurrencyListInteractor: CurrencyListInteractorInputProtocol
{
    weak var presenter: CurrencyListInteractorOutputProtocol?
    var APIDataManager: CurrencyListAPIDataManagerInputProtocol?
    var localDatamanager: CurrencyListLocalDataManagerInputProtocol?
    var currencyListLocalDataManager = CurrencyListLocalDataManager()
    
    init() {}
    
    func getCurrencyList() {
        let currencyListArray = self.currencyListLocalDataManager.loadCurrencyListArrayFromBundle()
        var currencyListItems = [CurrencyListItem]()
        for (key,value) in currencyListArray {
           
                let currencyListItem = CurrencyListItem(currencyName:"\(value)",
                 code: key,symbol:key)
                currencyListItems.append(currencyListItem)
            }
        
        self.presenter?.fetchedCurrencyList(currencyListItems)
    }
}
