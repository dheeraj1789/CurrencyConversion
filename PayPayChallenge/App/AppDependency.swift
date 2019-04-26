//
//  AppDependency.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    var converterWireFrame = ConverterWireFrame()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        converterWireFrame.presentConverterModule(fromView: window)
    }
    
    func configureDependencies() {
        let appWireFrame = AppWireFrame()
        let currencyListWireFrame = CurrencyListWireFrame()
        
        // Converter
        let converterPresenter = ConverterPresenter()
       
        let converterIntractor = ConverterInteractor()
        
        converterIntractor.presenter = converterPresenter
   
        
        converterPresenter.interactor = converterIntractor
        converterPresenter.wireFrame = converterWireFrame
        
        converterWireFrame.appWireFrame = appWireFrame
        converterWireFrame.currencyListWireFrame = currencyListWireFrame
        converterWireFrame.presenter = converterPresenter
        
        // CurrencyList
        let currencyListPresenter = CurrencyListPresenter()
      
        let currencyListInteractor = CurrencyListInteractor()
        
        currencyListInteractor.presenter = currencyListPresenter
      currencyListPresenter.interactor = currencyListInteractor
        currencyListPresenter.wireFrame = currencyListWireFrame
        
        currencyListWireFrame.currencyListPresenter = currencyListPresenter
        currencyListWireFrame.converterPresenter = converterPresenter
    }
}
