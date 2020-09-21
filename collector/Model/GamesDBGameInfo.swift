//
//  GamesDB.swift
//  collector
//
//  Created by Brian on 4/8/20.
//  Copyright © 2020 Brian. All rights reserved.
//

//import Foundation
//
//
//struct GameDB : Decodable {
//    var data : GameData
//}
//
//
//
//struct GameData : Decodable {
//    
//    var games : [Games]
//   
//    
//}
//
//struct Games : Decodable {
//    var id : Int
//    var players : Int?
    
//    enum CodingKeys : String, CodingKey {
//        case id
//        case players
//    }
    
//    init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//
//     if container.contains(.players) {
//            self.players = try container.decode(Int.self, forKey: .players)
//
//        }
//        
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let byGameName = try? newJSONDecoder().decode(ByGameName.self, from: jsonData)

import Foundation

// MARK: - ByGameName
struct ByGameName: Codable {
    let code: Int
    let status: String
    let data: ByGameNameData?
    let include: GameNameInclude?
    let pages: Pages
    let remainingMonthlyAllowance, extraAllowance, allowanceRefreshTimer: Int

    enum CodingKeys: String, CodingKey {
        case code, status, data, include, pages
        case remainingMonthlyAllowance = "remaining_monthly_allowance"
        case extraAllowance = "extra_allowance"
        case allowanceRefreshTimer = "allowance_refresh_timer"
    }
}

// MARK: - ByGameNameData
struct ByGameNameData: Codable {
    let count: Int
    let games: [Game]
}

// MARK: - Game
struct Game: Codable {
    let id: Int?
    let gameTitle, releaseDate: String
    let platform, players: Int?
    let overview, lastUpdated, rating, coop: String?
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

// MARK: - Include
struct GameNameInclude: Codable {
    let boxart: GameNameBoxart?
    let platform: GameNamePlatform?
}

// MARK: - Boxart
struct GameNameBoxart: Codable {
    let baseURL: GameNameBaseURL
    let data: [String: [GameData]]?

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case data
    }
}

// MARK: - BaseURL
struct GameNameBaseURL: Codable {
    let original, small, thumb, croppedCenterThumb: String
    let medium, large: String

    enum CodingKeys: String, CodingKey {
        case original, small, thumb
        case croppedCenterThumb = "cropped_center_thumb"
        case medium, large
    }
}

// MARK: - Datum
struct GameData: Codable {
    let id: Int
    let type: String
    let side: GameNameSide
    let filename: String
    let resolution: String?
}

enum GameNameSide: String, Codable {
    
    case back = "back"
    case front = "front"
    
}

// MARK: - Platform
struct GameNamePlatform: Codable {
    let data: PlatformData
}

// MARK: - PlatformData
struct PlatformData: Codable {
    let data: [String: GameNameData]


}

// MARK: - The7
struct GameNameData: Codable {
    let id: Int
    let name, alias: String
}

// MARK: - Pages
struct GameNamePages: Codable {
    let previous: String?
    let current: String?
    let next: String?
}

//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
