//
//  TheGamesDB.swift
//  collector
//
//  Created by Brian on 9/20/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import RealmSwift

struct TheGamesDBData: Codable {
    
    let code: Int
    let status: String
    let lastEditID : Int
    let data : GameData?
    let include: ExtraItems
    let pages = Page?
    
    enum CodingKeys: String, CodingKey {
        case code, status
        case lastEditID = "last_edit_id"
        case data, include, pages
    }
    
}


struct GameData: Codable {
    let count: Int
    let games: [GameInformation]
}

struct GameInformation: Codeable {
    
    let id: Int?
    let gameTitle: String
    let releaseDate: String
    let platform: Int?
    let overview: String?
    let youtube: String?
    let players: Int?
    let coop: Cooperative?
    let rating: String?
    let developers: [Int]?
    let genres: [Int]?
    let publishers: [Int]?
    let alternates: [String]?
    let uids: [Uids]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case gameTitle = "game_title"
        case releaseDate = "release_date"
        case platform, overview, youtube, players, coop, rating, developers, genres, publishers, alternates, uids
    }
}

enum Cooperative: String, CodingKey {
    case no = "No"
    case yes = "Yes"
}

struct Uids: Codable {
    let uid : String
    let gamesUIDsPatternsID: Int
    
    
    enum CodingKeys: String, CodingKey {
        case uid
        case gamesUIDsPatternsID = "games_uids_patterns_id"
    }
}


struct ExtraItems: Codable {
    
    let boxart : BoxArtData
    let platform: PlatformData
    
}


struct BoxArtData: Codable {
    
    let baseURL: ImagesBaseURL
    var data: [String: [ExtraImages]]
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case data
    }
}

struct ImagesBaseURL: Codable {

    let original, small, thumb, croppedCenterThumb: String
    let medium, large: String

    enum CodingKeys: String, CodingKey {
        case original, small, thumb
        case croppedCenterThumb = "cropped_center_thumb"
        case medium, large
    }

    
}


struct ExtraImages: Codable {
    
    let id: Int
    let type: ImageType
    let side: BoxSide?
    let filename: String
    let resolution: String?
    
}

enum ImageType: String, Codable {
    
    case boxart = "boxart"
    case fanart = "fanart"
    case screenshot = "screenshot"
    case banner = "banner"
    case clearlogo = "clearlogo"
    
    
}

enum BoxSide?: String, Codable {
    case back = "back"
    case front = "front"
}


struct PlatformData: Codable {
    
    let data: [String: PlatformInformation]
}

struct PlatformInformation: Codable {
    
    let id: Int
    let name: String
    let alias: String
    
}

struct Page: Codable {
    
    let previous: String?
    let current: String?
    let next: String?
}
