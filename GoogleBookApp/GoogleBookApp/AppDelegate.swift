//
//  AppDelegate.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
   
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
 
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
   
    }

    func applicationWillTerminate(_ application: UIApplication) {

        self.saveContext()
    }



    lazy var persistentContainer: NSPersistentContainer = {
 
        let container = NSPersistentContainer(name: "GoogleBookApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
      
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()



    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
     
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

