//
//  SavedGames+CoreDataProperties.swift
//  collector
//
//  Created by Brian on 10/28/20.
//  Copyright © 2020 Brian. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedGames {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedGames> {
        return NSFetchRequest<SavedGames>(entityName: "SavedGames")
    }

    @NSManaged public var boxartImage: Data?
    @NSManaged public var boxartImageURL: String?
    @NSManaged public var clearlogoImage: Data?
    @NSManaged public var clearlogoImageURL: String?
    @NSManaged public var developerName: String?
    @NSManaged public var fanartImage: Data?
    @NSManaged public var fanartImageURL: String?
    @NSManaged public var gameID: Int32
    @NSManaged public var genre: String?
    @NSManaged public var genres: Array<String>?
    @NSManaged public var maxPlayers: Int64
    @NSManaged public var overview: String?
    @NSManaged public var owned: Bool
    @NSManaged public var platformID: Int64
    @NSManaged public var platformName: String?
    @NSManaged public var releaseYear: Int32
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var youtubeURL: String?
    @NSManaged public var rating: String?
    @NSManaged public var platform: Platform?

}

extension SavedGames : Identifiable {

}
