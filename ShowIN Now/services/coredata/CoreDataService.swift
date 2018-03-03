//
//  CoreDataService.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataService {
    public let persistentStoreCoordinator : NSPersistentStoreCoordinator?
    private let databaseName: String = "ShowIn-Now"
    
    public static let sharedInstance = CoreDataService()
    
    private init() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let applicationDocumentsDirectoryurls: NSURL = urls[urls.count - 1] as NSURL
        let managedObjectModel = NSManagedObjectModel(contentsOf: Bundle.main.url(forResource: databaseName, withExtension: "momd")!)!
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectoryurls.appendingPathComponent(databaseName + ".sqlite")
        do {
            let options = [ NSInferMappingModelAutomaticallyOption : true,
                            NSMigratePersistentStoresAutomaticallyOption : true]
            try persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch let  error as NSError {
            print(error.localizedDescription)
            abort()
        }
    }
    
    public func showsRepo(context: NSManagedObjectContext) -> ShowRepo{
        return ShowRepo.init(managedContext: context)
    }
}
