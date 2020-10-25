// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let byPlatformIDData = try? newJSONDecoder().decode(ByPlatformIDData.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - ByPlatformIDData
struct ByPlatformIDData: Codable {
    let code: Int
    let status: String
    var data: ByPlatformIDDataData?
    let include: Include
    let pages: Pages?
    let remainingMonthlyAllowance, extraAllowance, allowanceRefreshTimer: Int

    enum CodingKeys: String, CodingKey {
        case code, status, data, include, pages
        case remainingMonthlyAllowance = "remaining_monthly_allowance"
        case extraAllowance = "extra_allowance"
        case allowanceRefreshTimer = "allowance_refresh_timer"
    }
}

// MARK: - ByPlatformIDDataData
struct ByPlatformIDDataData: Codable {
    let count: Int?
    var games: [GDBGamesPlatform]
}

// MARK: - Game
struct GDBGamesPlatform: Codable {
    var id: Int?
    var gameTitle: String
    let releaseDate: String?
    let platform, players: Int?
    let overview, lastUpdated: String?
    let rating: String?
    let coop: Coop?
    let youtube: String?
    let os, processor, ram, hdd: String?
    let video, sound: String?
    let developers, genres, publishers: [Int]?
    let alternates: [String]?


    enum CodingKeys: String, CodingKey {
        case id
        case gameTitle = "game_title"
        case releaseDate = "release_date"
        case platform, players, overview
        case lastUpdated = "last_updated"
        case rating, coop, youtube, os, processor, ram, hdd, video, sound, developers, genres, publishers, alternates
    }
}


enum Coop: String, Codable {
    case no = "No"
    case yes = "Yes"
}

struct GameObject: Codable {
    
    var title : String?
    var id : Int?
    var overview : String?
    var boxartFrontImage : String?
    var boxartRearImage: String?
    var fanartImage : String?
    var rating : String?
    var releaseDate: String?
    var owned : Bool?
    var index: Int?
    var developerIDs, genreIDs, pusblisherIDs : [Int]?
    var youtubePath: String?
    var platformID : Int?
    var maxPlayers : Int?
    var genreDescriptions : String?
    var genres : [String]?
    var developer : String?

}

struct GameImages : Codable {
    
    var innerArray : [String?: [Inner]]
    
    struct Inner: Codable {
        
        let id: Int
        let fileName: String
        let type: String
    }
    
}

//enum Rating: String, Codable {
//    case e10Everyone10 = "E10+ - Everyone 10+"
//    case eEveryone = "E - Everyone"
//    case notRated = "Not Rated"
//    case tTeen = "T - Teen"
//}

// MARK: - Include
struct Include: Codable {
    let boxart: Boxart
    let platform: PlatformByPlatform
}

// MARK: - Boxart
struct Boxart: Codable {
    let baseURL: BaseURL
    var data: [String: [ImageData]]

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case data
    }
}

// MARK: - BaseURL
struct BaseURL: Codable {
    let original, small, thumb, croppedCenterThumb: String
    let medium, large: String

    enum CodingKeys: String, CodingKey {
        case original, small, thumb
        case croppedCenterThumb = "cropped_center_thumb"
        case medium, large
    }
}

// MARK: - Datum
struct ImageData: Codable {
    let id: Int
    let type: TypeEnum
    let side: Side
    let filename: String
    let resolution: String?
}

enum Side: String, Codable {
    case back = "back"
    case front = "front"
}

enum TypeEnum: String, Codable {
    case boxart = "boxart"
}

// MARK: - Platform
struct PlatformByPlatform: Codable {
    let data: [String: PlatformIDData]
}

// MARK: - PlatformData
//struct PlatformData: Codable {
//    let platformID : [String: PlatformIDData]
//
//    enum CodingKeys: String, CodingKey {
//        case the6 = "6"
//    }
//}

// MARK: - The6
struct PlatformIDData: Codable {
    let id: Int
    let name, alias: String
}

// MARK: - Pages
struct Pages: Codable {
    let previous: String?
    let current, next: String?
}

