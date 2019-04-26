//
//  ConverterWireFrame.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation
import UIKit

let ConverterViewIdentifier = "ConverterView"

class ConverterWireFrame: ConverterWireFrameProtocol
{
    var appWireFrame : AppWireFrame?
    var converterView : ConverterViewController?
    var currencyListWireFrame : CurrencyListWireFrame?
    var presenter: ConverterPresenterProtocol & ConverterInteractorOutputProtocol = ConverterPresenter()
    
    func presentConverterModule(fromView window: AnyObject) {
        let view = converterViewFromStoryboard()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view

        converterView = view
        appWireFrame?.showRootViewController(view, inWindow: window as! UIWindow)
    }
    
    func showCurrencyListViewController() {
        self.currencyListWireFrame?.presentCurrencyListModule(fromView: converterView!)
    }
    
    func converterViewFromStoryboard() -> ConverterViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ConverterViewIdentifier) as! ConverterViewController
        return viewController
    }

    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
