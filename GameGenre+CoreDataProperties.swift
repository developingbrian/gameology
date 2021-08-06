//
//  GameGenre+CoreDataProperties.swift
//  collector
//
//  Created by Brian on 8/2/21.
//  Copyright © 2021 Brian. All rights reserved.
//
//

import Foundation
import CoreData


extension GameGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameGenre> {
        return NSFetchRequest<GameGenre>(entityName: "GameGenre")
    }

    @NSManaged public var name: String?
    @NSManaged public var ofGame: NSSet?

}

// MARK: Generated accessors for ofGame
extension GameGenre {

    @objc(addOfGameObject:)
    @NSManaged public func addToOfGame(_ value: SavedGames)

    @objc(removeOfGameObject:)
    @NSManaged public func removeFromOfGame(_ value: SavedGames)

    @objc(addOfGame:)
    @NSManaged public func addToOfGame(_ values: NSSet)

    @objc(removeOfGame:)
    @NSManaged public func removeFromOfGame(_ values: NSSet)

}

extension GameGenre : Identifiable {

}
