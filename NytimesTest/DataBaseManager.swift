//
//  DataBaseManager.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit
import CoreData
import Sync

class DataBaseManager: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: NSObject.nameOfApp)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    let dataStack = DataStack(modelName: NSObject.nameOfApp)
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext)!
    }
}
