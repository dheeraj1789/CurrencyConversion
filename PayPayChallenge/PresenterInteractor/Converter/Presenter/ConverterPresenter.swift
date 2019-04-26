//
//  ConverterPresenter.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation
import UIKit

class ConverterPresenter: ConverterPresenterProtocol, ConverterInteractorOutputProtocol
{
    weak var view: ConverterViewProtocol?
    var interactor: ConverterInteractorInputProtocol?
    var wireFrame: ConverterWireFrameProtocol?
    
    init() {}
    
    /**
     * Methods for communication VIEW -> PRESENTER
     */
    
    func showCurrencyListView() {
        self.wireFrame?.showCurrencyListViewController()
    }

    func loadView() {
        self.interactor?.initWithBaseCurrencyAndLoad()
    }

    func getCurrencyListWithData(_ baseConverterItem: ConverterItem) {
        self.interactor?.getCurrencyWithData(baseConverterItem)
    }
    
    /**
     * Methods for communication INTERACTOR -> PRESENTER
     */
    
    func initWithBaseConverterItem(_ converterItem: ConverterItem) {
        self.view?.initWithBaseAndReload(currencyName: converterItem.currencyName,code: converterItem.code,amount: converterItem.amount)
    }

    func fetchedConvertedCurrency(_ convertedCurrency:[ConverterItem]) {
        if convertedCurrency.count == 0 {
            self.view?.noContentFromServer()
        } else {
            self.view?.reloadTableViewWithData(convertedCurrency)
        }
    }
}
