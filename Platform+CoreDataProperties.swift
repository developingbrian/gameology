//
//  Platform+CoreDataProperties.swift
//  collector
//
//  Created by Brian on 12/17/20.
//  Copyright © 2020 Brian. All rights reserved.
//
//

import Foundation
import CoreData


extension Platform {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Platform> {
        return NSFetchRequest<Platform>(entityName: "Platform")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var games: NSSet?

}

// MARK: Generated accessors for games
extension Platform {

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: SavedGames)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: SavedGames)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSSet)

}

extension Platform : Identifiable {

}
