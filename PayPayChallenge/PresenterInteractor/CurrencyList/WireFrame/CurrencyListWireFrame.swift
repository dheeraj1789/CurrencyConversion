//
// CurrencyListWireFrame.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation
import UIKit

let CurrencyListViewIdentifier = "CurrencyListView"

class CurrencyListWireFrame: CurrencyListWireFrameProtocol
{
    var currencyListPresenter : CurrencyListPresenter?
    var converterPresenter : ConverterPresenter?

    var presentedViewController : UIViewController?

    func presentCurrencyListModule(fromView view: UIViewController) {
        // Generating module components
        let currencyListView = currencyListViewFromStoryboard()
        
        currencyListView.presenter = currencyListPresenter
        currencyListPresenter?.view = currencyListView
        
        view.present(currencyListView, animated: true) { 
            
        };
        presentedViewController = view
    }
    
    func dismissCurrencyListWithSelectedData(_ converterItem : CurrencyListItem) {
        presentedViewController?.dismiss(animated: true, completion: { 
            self.converterPresenter?.initWithBaseConverterItem(ConverterItem(currencyName: converterItem.currencyName, code: converterItem.code,amount:"1"))
        })
    }
    
    func currencyListViewFromStoryboard() -> CurrencyListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: CurrencyListViewIdentifier) as! CurrencyListViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
