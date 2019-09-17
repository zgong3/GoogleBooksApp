//
//  SavedBooksViewController.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SavedBooksViewController: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    
    var books = [BookModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         books = core.load()
        
    }
    
    
    var names : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblList.tableFooterView = UIView(frame: .zero)
    }

}

extension SavedBooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favcell.identifier, for: indexPath) as! favcell
        let book = books[indexPath.row]
        cell.books = book
        return cell
    }
    
    
    
}


extension SavedBooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

