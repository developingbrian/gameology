//
//  SavedGames+CoreDataProperties.swift
//  collector
//
//  Created by Brian on 9/29/21.
//  Copyright © 2021 Brian. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedGames {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedGames> {
        return NSFetchRequest<SavedGames>(entityName: "SavedGames")
    }

    @NSManaged public var boxartHeight: Int32
    @NSManaged public var boxartImage: Data?
    @NSManaged public var boxartImageURL: String?
    @NSManaged public var boxartWidth: Int32
    @NSManaged public var boxCondition: Float
    @NSManaged public var boxOwned: Bool
    @NSManaged public var clearlogoImage: Data?
    @NSManaged public var clearlogoImageURL: String?
    @NSManaged public var developerName: String?
    @NSManaged public var digitalCopy: Bool
    @NSManaged public var fanartImage: Data?
    @NSManaged public var fanartImageURL: String?
    @NSManaged public var gameCondition: Float
    @NSManaged public var gameID: Int32
    @NSManaged public var gameOwned: Bool
    @NSManaged public var genre: String?
    @NSManaged public var genres: Array<String>?
    @NSManaged public var hasBeaten: Bool
    @NSManaged public var hasCompleted: Bool
    @NSManaged public var manualCondition: Float
    @NSManaged public var manualOwned: Bool
    @NSManaged public var maxPlayers: String?
    @NSManaged public var notes: String?
    @NSManaged public var overview: String?
    @NSManaged public var owned: Bool
    @NSManaged public var percentComplete: Float
    @NSManaged public var physicalCopy: Bool
    @NSManaged public var platformID: Int64
    @NSManaged public var platformName: String?
    @NSManaged public var pricePaid: String?
    @NSManaged public var rating: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var releaseYear: Int32
    @NSManaged public var title: String?
    @NSManaged public var youtubeURL: String?
    @NSManaged public var screenshotImageIDs: Array<String>?
    @NSManaged public var userRating: Int32
    @NSManaged public var totalRating: Int32
    @NSManaged public var genreType: NSSet?
    @NSManaged public var photo: NSSet?
    @NSManaged public var platform: Platform?

}

// MARK: Generated accessors for genreType
extension SavedGames {

    @objc(addGenreTypeObject:)
    @NSManaged public func addToGenreType(_ value: GameGenre)

    @objc(removeGenreTypeObject:)
    @NSManaged public func removeFromGenreType(_ value: GameGenre)

    @objc(addGenreType:)
    @NSManaged public func addToGenreType(_ values: NSSet)

    @objc(removeGenreType:)
    @NSManaged public func removeFromGenreType(_ values: NSSet)

}

// MARK: Generated accessors for photo
extension SavedGames {

    @objc(addPhotoObject:)
    @NSManaged public func addToPhoto(_ value: Photos)

    @objc(removePhotoObject:)
    @NSManaged public func removeFromPhoto(_ value: Photos)

    @objc(addPhoto:)
    @NSManaged public func addToPhoto(_ values: NSSet)

    @objc(removePhoto:)
    @NSManaged public func removeFromPhoto(_ values: NSSet)

}

extension SavedGames : Identifiable {

}
