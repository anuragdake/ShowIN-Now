//
//  Show+CoreDataProperties.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//
//

import Foundation
import CoreData


extension Show {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Show> {
        return NSFetchRequest<Show>(entityName: "Show")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var rating: Float
    @NSManaged public var airdate: String?
    @NSManaged public var airtime: String?
    @NSManaged public var genres: [String]?
    @NSManaged public var imageUrl: String?
    @NSManaged public var summary: String?

}
