//
// CurrencyListViewController.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation
import UIKit

class CurrencyListViewController: UIViewController, CurrencyListViewProtocol, UITextFieldDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource
{
    var presenter: CurrencyListPresenterProtocol?
    var listArray = [CurrencyListItem]()
    var searchedListArray = [CurrencyListItem]()
    var isSearch = Bool()
    @IBOutlet var listTableView : UITableView!

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.updateView()
    }
    
    func configureView() {
        navigationItem.title = "Currency List"
    }
    
    @IBAction func cancelAction(sender : UIButton) {
        self.dismiss(animated: true) { 
            
        };
    }
    
    func reloadTableViewWithCurrencyList(_ currencyList : [CurrencyListItem]) {
        self.listArray = currencyList
        self.listTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = 1
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return self.searchedListArray.count
        } else {
            return self.listArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.listTableView!.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell)
        
        self.configureCellForTableView(tableView, withCell: cell, withIndexPath: indexPath)
        return cell
    }
    
    func configureCellForTableView(_ tableView: UITableView, withCell cell: UITableViewCell, withIndexPath indexPath: IndexPath) {
        var currencyListItems = [CurrencyListItem]()
        if isSearch {
            currencyListItems = self.searchedListArray
        } else {
            currencyListItems = self.listArray
        }
        if let currencyListItem = currencyListItems[safe: (indexPath as NSIndexPath).row] {
            let codeLabel:UILabel = cell.viewWithTag(113) as! UILabel
         let currencyNameLabel:UILabel = cell.viewWithTag(112) as! UILabel
           codeLabel.text = currencyListItem.code
           currencyNameLabel.text = currencyListItem.currencyName
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currencyListItems = [CurrencyListItem]()
        if isSearch {
            currencyListItems = self.searchedListArray
        } else {
            currencyListItems = self.listArray
        }
        if let currencyListItem = currencyListItems[safe: (indexPath as NSIndexPath).row] {
      
            self.presenter?.selectCurrencyListItem(currencyListItem)
        }
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearch = true
        self.searchedListArray = self.listArray.filter({ (currencyListItem) -> Bool in
            if searchText.isEmpty {
                return true
            } else {
                return  (currencyListItem.code.lowercased().contains(searchText.lowercased())) || (currencyListItem.currencyName.lowercased().contains(searchText.lowercased()))
            }
        })
        self.listTableView.reloadData()
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearch = false
        self.listTableView.reloadData()
        searchBar.resignFirstResponder()
    }

}
