//
//  BookDetailViewController.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BooksViewModel
{
    static let sharedInstance = BooksViewModel()
    var booksArray : [BookModel]?
    var selectedBook : BookModel?
}


class BookDetailViewController: UIViewController {
    
    var viewModel: BooksViewModel? = BooksViewModel.sharedInstance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.updateUIFromViewModel()
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    @IBOutlet weak var bookThumbnail: UIImageView!
    
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookISBNLabel: UILabel!
    
    var bookTitle : [String] = []
    
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        
        bookTitle.append(self.viewModel!.selectedBook!.title)
        print(bookTitle)
        
        core.save(self.viewModel!.selectedBook!)
        
        
      
        
    }
    func updateUIFromViewModel()
    {
        self.bookTitleLabel.text = self.viewModel?.selectedBook?.title
        self.bookDescriptionLabel.text = self.viewModel?.selectedBook?.description
        self.bookISBNLabel.text = self.viewModel?.selectedBook?.isbn
        self.bookAuthorLabel.text = self.viewModel?.selectedBook?.authors
        
        self.bookDescriptionLabel.sizeToFit()
    }
    
}
