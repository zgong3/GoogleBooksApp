//
//  BookCoreData.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData

let core = BookCoreData.shared

final class BookCoreData {
    
    static let shared = BookCoreData()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GoogleBookApp")
        container.loadPersistentStores(completionHandler: { (storeDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
    }()
    
    func save(_ book: BookModel) {
        
        let entity = NSEntityDescription.entity(forEntityName: "CoreBook", in: context)!
        let core = CoreBook(entity: entity, insertInto: context)
        
        

        core.setValue(book.title, forKey: "title")
        core.setValue(book.description, forKey: "bookDescription")
        core.setValue(book.isbn, forKey: "isbn")
        core.setValue(book.authors, forKey: "authors")
        
        print("Saved Fact To Core: \(book.title)")

        
    }
    
    func load() -> [BookModel] {
        
        let fetchRequest = NSFetchRequest<CoreBook>(entityName: "CoreBook")
        
        var facts = [BookModel]()
        
        do {
            let coreFacts = try context.fetch(fetchRequest)
            for core in coreFacts {
                facts.append(BookModel(from: core))
            }
            
        } catch {
            print("Couldn't Fetch Fact: \(error.localizedDescription)")
        }
        
        return facts
    }
    

    
    
    
}
