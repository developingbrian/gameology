// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let iGDBGames = try? newJSONDecoder().decode(IGDBGames.self, from: jsonData)

import Foundation
import UIKit

struct GameObject {
    
    var title : String?
    var id : Int?
    var overview : String?
    var boxartFrontImage : String?
    var boxartInfo : ImageInfo?
    var boxartImage: UIImage?
    var boxartHeight : Int?
    var boxartWidth : Int?
    var boxartResolution : String?
    var boxartRearImage: String?
    var fanartImage : String?
    var rating : String?
    var releaseDate: String?
    var owned : Bool?
    var index: Int?
    var screenshots : [ImageInfo]?
    var developerIDs, genreIDs, pusblisherIDs : [Int]?
    var youtubePath: String?
    var platformID : Int?
    var maxPlayers : String?
    var genreDescriptions : String?
    var genres : [String]?
    var developer : String?
    var gamePhotos: [NSData]?
    var manualPhotos : [NSData]?
    var boxPhotos : [NSData]?
    var totalRating : Int?
    var userRating : Int?
}

// MARK: - IGDBGame
struct IGDBGame: Codable {
    let id: Int?
    let cover: ImageInfo?
    let firstReleaseDate: Int?
    let gameModes: [GameModes]?
    let genres: [Genre]?
    let involvedCompanies: [InvolvedCompany]?
    let name: String?
    let platforms: [PlatformObject]?
    let screenshots: [ImageInfo]?
    let summary: String?
    let rating, totalRating: Double?
    let videos: [Video]?
    let ageRatings: [AgeRating]?

    enum CodingKeys: String, CodingKey {
        case id, cover
        case firstReleaseDate = "first_release_date"
        case gameModes = "game_modes"
        case genres
        case involvedCompanies = "involved_companies"
        case name, platforms, screenshots, summary, rating
        case totalRating = "total_rating"
        case videos
        case ageRatings = "age_ratings"
    }
}

struct GameModes: Codable {
    let id: Int?
    let name : String?
}

// MARK: - AgeRating
struct AgeRating: Codable {
    let id: Int?
    let rating: Int?
    let category: Int?
    let checksum: String?
    
    
    
}


// MARK: - Cover
struct ImageInfo: Codable {
    let id: Int?
    let alphaChannel, animated: Bool?
    let game, height: Int?
    let imageID, url: String?
    let width: Int?
    let checksum: String?

    enum CodingKeys: String, CodingKey {
        case id
        case alphaChannel = "alpha_channel"
        case animated, game, height
        case imageID = "image_id"
        case url, width, checksum
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id, createdAt: Int?
    let name, slug: String?
    let updatedAt: Int?
    let url: String?
    let checksum: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, slug
        case updatedAt = "updated_at"
        case url, checksum
    }
}

// MARK: - InvolvedCompany
struct InvolvedCompany: Codable {
    let id: Int?
    let company: Company?
    let publisher: Bool?
}

// MARK: - Company
struct Company: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Platform
struct PlatformObject: Codable {
    var id: Int
    var abbreviation, alternativeName: String?
    var category, createdAt, generation: Int?
    var name: String
    var platformLogo: ImageInfo?
    var platformFamily: Int?
    var slug: String?
    var updatedAt: Int?
    var url: String?
    var versions: [Version]?
    var checksum: String?

    enum CodingKeys: String, CodingKey {
        case id, abbreviation
        case alternativeName = "alternative_name"
        case category
        case createdAt = "created_at"
        case generation, name
        case platformLogo = "platform_logo"
        case platformFamily = "platform_family"
        case slug
        case updatedAt = "updated_at"
        case url, versions, checksum
    }
}



// MARK: - Version
struct Version: Codable {
    let id: Int?
    let platformLogo: ImageInfo?

    enum CodingKeys: String, CodingKey {
        case id
        case platformLogo = "platform_logo"
    }
}

// MARK: - Video
struct Video: Codable {
    let id: Int?
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case videoID = "video_id"
    }
}

typealias IGDBGames = [IGDBGame]
