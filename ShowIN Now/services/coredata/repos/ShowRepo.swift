//
//  ShowRepo.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation
import CoreData

public class ShowRepo{
    private var managedContext: NSManagedObjectContext?
    private let entityName: String = "Show"
    
    init(managedContext: NSManagedObjectContext?) {
        self.managedContext = managedContext
    }
    
    private func showObjectFromDictionary(show: [String : Any]) -> Show{
        let showManagedObject = Show(entity: NSEntityDescription.entity(forEntityName: entityName, in: managedContext!)!, insertInto: managedContext!)
        if let id = show["id"] {
            showManagedObject.id =  id as? Int32 ?? 0
            
            if let airDate = show["airdate"]{
                showManagedObject.airdate = airDate as? String ?? ""
            }
            if let airTime = show["airtime"]{
                showManagedObject.airtime = airTime as? String ?? ""
            }
            
            if let showDetails = show["show"] as? [String : Any]{
                if let name = showDetails["name"] {
                    showManagedObject.name =  name as? String ?? ""
                }
                
                if let type = showDetails["type"]{
                    showManagedObject.type = type as? String ?? ""
                }
                
                if let summary = showDetails["summary"]{
                    showManagedObject.summary = summary as? String ?? ""
                }
                
                if let generes = showDetails["genres"]{
                    showManagedObject.genres = generes as? [String] ?? []
                }
                
                if let image = showDetails["image"] as? [String : Any],  let imageUrl = image["medium"]{
                    showManagedObject.imageUrl = imageUrl as? String ?? ""
                }
                
                if let ratings = showDetails["rating"] as? [String : Any],  let avgRating = ratings["average"]{
                    showManagedObject.rating = avgRating as? Float ?? 0
                }
            }
        }
        return showManagedObject
    }
    
    func createShows(showsArray: [Dictionary<String, Any>]) -> Bool{
        for show:Dictionary in showsArray {
            if !createEntry(object: showObjectFromDictionary(show: show)){
                return false
            }
        }
        return true
    }
    
    func deleteAllShows() -> Bool{
        return deleteAllEntries(entityName: entityName, context: managedContext)
    }
    
    public func showHavingId(showId: Int32) -> Show?{
        return readEntry(condition: NSPredicate(format: "id == %d", showId), entity: entityName, context: managedContext) as? Show ?? nil
    }
    
    func allShows() -> [Show]{
        return readAllEntries(entity: entityName, context: managedContext) as? [Show] ?? []
    }
}
