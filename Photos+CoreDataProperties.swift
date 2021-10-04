//
//  Photos+CoreDataProperties.swift
//  collector
//
//  Created by Brian on 9/29/21.
//  Copyright © 2021 Brian. All rights reserved.
//
//

import Foundation
import CoreData


extension Photos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photos> {
        return NSFetchRequest<Photos>(entityName: "Photos")
    }

    @NSManaged public var category: String?
    @NSManaged public var gameTitle: String?
    @NSManaged public var photo: Data?
    @NSManaged public var games: SavedGames?

}

extension Photos : Identifiable {

}
