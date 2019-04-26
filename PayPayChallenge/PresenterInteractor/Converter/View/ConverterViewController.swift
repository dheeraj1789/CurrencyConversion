//
//  ConverterViewController.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation
import UIKit

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}

class ConverterViewController: UIViewController, ConverterViewProtocol, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
  
    
    var presenter: ConverterPresenterProtocol?
    var baseConverterItem : ConverterItem!
    
    @IBOutlet var mainTableView : UITableView!
    @IBOutlet var baseAmountTextField : UITextField!
    @IBOutlet var baseCountryImageView : UIImageView!
    @IBOutlet var baseCountryCodeLabel : UILabel!
    @IBOutlet var baseCountryNameLabel : UILabel!
    @IBOutlet var baseCurrencySymbolLabel : UILabel!

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
     
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Methods

    func configureView() {
        navigationItem.title = "Currency Converter"
         self.presenter?.loadView()
        self.addPullToRefresh()
       
    }
    
    func addPullToRefresh() {
        self.baseConverterItem.isFreshLoad = true
self.presenter?.getCurrencyListWithData(self.baseConverterItem)
   
    }
    
    func convertAmountWithBaseValue(amount : String) {
        self.baseConverterItem.amount = amount
        self.baseConverterItem.isFreshLoad = false
        self.presenter?.getCurrencyListWithData(self.baseConverterItem)
    }
    
  
    
    // MARK: Actions

    @IBAction func showCurrecnyList(sender: UIButton) {
        self.presenter?.showCurrencyListView()
    }
    
    // MARK: UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = 1
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.baseConverterItem.convertedList.count
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier : String
        identifier = "cell"
        
        let cell:UITableViewCell = (self.mainTableView!.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell)
        
       self.configureCellForTableView(tableView, withCell: cell, withIndexPath: indexPath)
        return cell
    }
    
    func configureCellForTableView(_ tableView: UITableView, withCell cell: UITableViewCell, withIndexPath indexPath: IndexPath) {
        if let converterItem = self.baseConverterItem.convertedList[safe: (indexPath as NSIndexPath).row] {
            let amountTextField:UITextField = cell.viewWithTag(222) as! UITextField
       
            let symbolLabel:UILabel = cell.viewWithTag(221) as! UILabel
            let countryNameLabel:UILabel = cell.viewWithTag(224) as! UILabel
            amountTextField.text = converterItem.convertedAmount
            symbolLabel.text = converterItem.code
            countryNameLabel.text = "1 \(self.baseConverterItem.code) = \( NSString(format : "%.4f", Double(converterItem.amount)!) as String) \(converterItem.currencyName)"
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let converterItem = self.baseConverterItem.convertedList[safe: (indexPath as NSIndexPath).row] {
            self.baseConverterItem.amount = baseAmountTextField.text!
         
            self.initWithBaseAndReload(currencyName: converterItem.currencyName,code: converterItem.code, amount: self.baseConverterItem.amount)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0;
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let filtered = string.components(separatedBy: NSCharacterSet(charactersIn:"0123456789.").inverted).joined(separator: "")
        if (string == filtered) {
            let txtAfterUpdate: NSString = textField.text! as NSString
            self.convertAmountWithBaseValue(amount: txtAfterUpdate.replacingCharacters(in: range, with: string))
            return true
        } else {
            return false
        }
    }
    
    /**
     * Methods for communication PRESENTER -> VIEW
     */
    
    func initWithBaseAndReload(currencyName: String,  code: String, amount: String) {
        self.baseConverterItem = ConverterItem(currencyName: currencyName, code: code, amount: amount)
        
     
        self.baseCountryCodeLabel.text = self.baseConverterItem.code
        self.baseCountryNameLabel.text = self.baseConverterItem.currencyName
        self.baseCurrencySymbolLabel.text = self.baseConverterItem.code
        self.baseConverterItem.amount = self.baseAmountTextField.text!
              addPullToRefresh()
        
   
    }
    
    func reloadTableViewWithData(_ converterItems: [ConverterItem]) {
        DispatchQueue.main.async {
    self.baseConverterItem.convertedList = converterItems
            self.mainTableView.reloadData()
            self.baseAmountTextField.becomeFirstResponder()
        }
    }
    
    func noContentFromServer() {
        DispatchQueue.main.async {
            //self.mainTableView.stopPullToRefresh()
        }
    }
}

