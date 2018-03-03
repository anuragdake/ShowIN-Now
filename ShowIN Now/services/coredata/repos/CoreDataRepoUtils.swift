//
//  CoreDataRepoUtils.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation
import CoreData

func createEntry(object: NSManagedObject) -> Bool{
    do {
        try object.managedObjectContext?.save()
    } catch {
        print(error)
        return false
    }
    return true
}

public func readEntry(condition: NSPredicate, entity: String, context: NSManagedObjectContext?) -> NSManagedObject?{
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.predicate = condition
    do {
        let fetchedElements = try context?.fetch(fetchRequest) as? [NSManagedObject] ?? []
        if fetchedElements.count > 0{
            return fetchedElements[0]
        }
    } catch {
        print(error)
        return nil
    }
    return nil
}

public func readAllEntries(entity: String, context: NSManagedObjectContext?) -> [NSManagedObject]{
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    do {
        return try context?.fetch(fetchRequest) as? [NSManagedObject] ?? []
    } catch {
        print(error)
        return []
    }
}

func deleteAllEntries(entityName: String, context: NSManagedObjectContext?) -> Bool{
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.includesPropertyValues = false
    do {
        let contentItems = try context?.fetch(fetchRequest) as? [NSManagedObject] ?? []
        for content in contentItems {
            context?.delete(content)
        }
        try context?.save()
    } catch {
        print(error)
        return false
    }
    return true
}
