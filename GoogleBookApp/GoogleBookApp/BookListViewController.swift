//
//  BookListViewController.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

let NAVBAR_HEIGHT = 40

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    static let cellID = "CellID"
    
    var previousSearchText: String? = ""
    
    var viewModel: BooksViewModel? = BooksViewModel.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar : UISearchBar?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: BookListViewController.cellID)
        self.createSearchBar()
    }
    
    func createSearchBar()
    {
        self.searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: NAVBAR_HEIGHT))
        self.searchBar?.delegate = self
        self.searchBar?.showsCancelButton = true
        self.searchBar?.enablesReturnKeyAutomatically = true
        self.searchBar?.returnKeyType = UIReturnKeyType.search
        self.searchBar?.autocorrectionType = UITextAutocorrectionType.no
        self.searchBar?.autocapitalizationType = UITextAutocapitalizationType.none

        self.searchBar?.placeholder = "Search"
        self.tableView.tableHeaderView = self.searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.viewModel!.booksArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListViewController.cellID)
        
        let book = self.viewModel!.booksArray![indexPath.row]
        
        cell?.textLabel?.text = book.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let book = self.viewModel!.booksArray![indexPath.row]
        self.viewModel!.selectedBook = book
        
        self.performSegue(withIdentifier: "BookDetailSegue", sender: self)
    }
    
    func resetResults()
    {
        self.viewModel!.booksArray = []
        self.tableView.reloadData()
        return
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        self.resetResults()
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if let searchText = searchBar.text,
            searchText.count > 2
        {
            self.fireSearchWithSearchText(searchText: searchText)
        }
        else if let searchText = searchBar.text,
            searchText.count == 0
        {
            //This does not work same always but it works on cancel button, maybe a bug.
            self.view.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if let searchText = searchBar.text,
            searchText.count > 2
        {
            self.fireSearchWithSearchText(searchText: searchText)
        }
        
        self.view.endEditing(true)
    }
    
    func fireSearchWithSearchText (searchText: String)
    {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchText(searchText:)), object: self.previousSearchText)
        self.previousSearchText = searchText
        self.perform(#selector(searchText(searchText:)), with: searchText, afterDelay: 0.5)
    }
    
    @objc func searchText(searchText: String)
    {
        BookModel.searchGoogleVolumes(searchString: searchText, successBlock: {
            (bookArray) in
            
            if ((bookArray.count) > 0)
            {
                self.viewModel!.booksArray = bookArray
                self.tableView.reloadData()
            }
        }, errorBlock:
            {
                (errStr) in
                print(errStr ?? "")
        })
    }
}

