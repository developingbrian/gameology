// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let iGDBGames = try? newJSONDecoder().decode(IGDBGames.self, from: jsonData)

import Foundation
import UIKit


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
    let releaseDate : [ReleaseDate]?

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
        case releaseDate = "release_dates"
    }
}

struct GameModes: Codable {
    let id: Int?
    let name : String?
}

// MARK: - ReleaseDate
struct ReleaseDate: Codable {
    let id, category, createdAt: Int
    let date: Int?
    let game: Int
    let human: String
    let m: Int?
    let platform, region, updatedAt: Int
    let y: Int?
    let checksum: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case createdAt = "created_at"
        case date, game, human, m, platform, region
        case updatedAt = "updated_at"
        case y, checksum
    }
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
    let logo: ImageInfo?
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
