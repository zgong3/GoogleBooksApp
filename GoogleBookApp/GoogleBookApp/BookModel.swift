//
//  Book.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/14/19.
//  Copyright © 2019 mac. All rights reserved.
//
import Foundation

struct BookModel
{
    let  title: String
    let description : String
    let isbn : String
    let authors: String
    static var books : [BookModel] = []
    
    init(from core: CoreBook) {
        self.title = core.title!
        self.description = core.bookDescription!
        self.isbn = core.isbn!
        self.authors = core.authors!
    }
    
    init(title: String, description: String, isbn: String, authors: String)
    {
        self.title = title
        self.description = description
        self.isbn = isbn
        self.authors = authors
    }
    
    static func searchGoogleVolumes (searchString: String, successBlock:@escaping (([BookModel])->Void), errorBlock:@escaping ((_ errorString: String?)->Void))
    {
        BookAPI.sharedInstance.getDataWithQuery (searchString: searchString, successBlock: {
            (json) in
            
            let responseDict = json as! Dictionary<String, Any?>
            let volumes = responseDict["items"]! as! [Dictionary<String, Any?>]
            
            books.removeAll()
            for volume in volumes
            {
                if let volumeInfo = volume["volumeInfo"]
                {
                    guard let title = (volumeInfo as! Dictionary<String, Any?>)["title"]
                        else { continue }
                    guard let authors = (volumeInfo as! Dictionary<String, Any?>)["authors"]
                        else { continue }
                    
                    let authorsString = (authors as! [String]).joined(separator: ",")
                    
                    guard let description = (volumeInfo as! Dictionary<String, Any?>)["description"]
                        else { continue }
                    
                    guard let isbnArray = (volumeInfo as! Dictionary<String, Any?>)["industryIdentifiers"]
                        else { continue }
                    
                    guard let isbn13Dict = (isbnArray as! [Dictionary<String, String>]).filter({ (dict) -> Bool in
                        return (dict["type"] == "ISBN_13")
                    }).first
                        else { continue }
                    
                    let isbn13 = isbn13Dict["identifier"]
                    
                    let book = BookModel(title: title as! String, description: description as! String, isbn: isbn13 ?? "", authors: authorsString)
                    books.append(book)
                }
            }
            
            DispatchQueue.main.async {
                successBlock(books)
            }
            
            
        }) {
            (errStr) in
            
            DispatchQueue.main.async
                {
                    errorBlock(errStr)
            }
        }
    }
}

