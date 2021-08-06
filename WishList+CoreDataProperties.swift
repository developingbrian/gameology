//
//  WishList+CoreDataProperties.swift
//  collector
//
//  Created by Brian on 8/2/21.
//  Copyright © 2021 Brian. All rights reserved.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var boxartHeight: Int32
    @NSManaged public var boxartImage: Data?
    @NSManaged public var boxartImageURL: String?
    @NSManaged public var boxartWidth: Int32
    @NSManaged public var clearlogoImage: Data?
    @NSManaged public var clearlogoImageURL: String?
    @NSManaged public var developerName: String?
    @NSManaged public var fanartImage: Data?
    @NSManaged public var fanartImageURL: String?
    @NSManaged public var gameID: Int32
    @NSManaged public var gameOwned: Bool
    @NSManaged public var genre: String?
    @NSManaged public var genres: Array<String>?
    @NSManaged public var inWishlist: Bool
    @NSManaged public var maxPlayers: String?
    @NSManaged public var overview: String?
    @NSManaged public var platformID: Int64
    @NSManaged public var platformName: String?
    @NSManaged public var rating: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var releaseYear: Int32
    @NSManaged public var title: String?
    @NSManaged public var youtubeURL: String?
    @NSManaged public var isOpen: Bool

}

extension WishList : Identifiable {

}
