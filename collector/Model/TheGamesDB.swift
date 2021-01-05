//
//  TheGamesDB.swift
//  collector
//
//  Created by Brian on 9/20/20.
//  Copyright © 2020 Brian. All rights reserved.
//

//import Foundation
//
//class TheGamesDBData: Object, Codable{
//
//    let code = RealmOptional<Int>()
//    @objc dynamic var status: String? = nil
//    let lastEditID = RealmOptional<Int>()
//    @objc dynamic var data : GamesData?
//    @objc dynamic var include : ExtraItems?
//    @objc dynamic var pages : Page?
//
// 
//
//    enum CodingKeys: String, CodingKey {
//        case code, status
//        case lastEditID = "last_edit_id"
//        case data, include, pages
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.code.value = try container.decodeIfPresent(Int.self, forKey: .code)
//        self.status = try container.decodeIfPresent(String.self, forKey: .status)
//        self.lastEditID.value = try container.decodeIfPresent(Int.self, forKey: .lastEditID)
//        self.data = try container.decodeIfPresent(GamesData.self, forKey: .data)
//        self.include = try container.decodeIfPresent(ExtraItems.self, forKey: .include)
//        self.pages = try container.decodeIfPresent(Page.self, forKey: .pages)
//    }
//
//}
//
//
//class GamesData: Object, Codable {
//    let count = RealmOptional<Int>()
//    let games = List<GameInformation>()
//    
//    enum CodingKeys: String, CodingKey {
//        case count
//        case games
//    }
//    
//
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.count.value = try container.decodeIfPresent(Int.self, forKey: .count)
//        let gamesList = try container.decodeIfPresent([GameInformation].self, forKey: .games) ?? [GameInformation()]
//        games.append(objectsIn: gamesList)
//    }
// 
// 
//}
//
//class GameInformation: Object, Codable {
//    
//    let id = RealmOptional<Int>()
//    @objc dynamic var gameTitle: String = ""
//    @objc dynamic var releaseDate: String? = nil
//    let platform = RealmOptional<Int>()
//    @objc dynamic var overview: String? = nil
//    @objc dynamic var youtube: String? = nil
//    let players = RealmOptional<Int>()
//    @objc dynamic var coop : String? = nil
//    @objc dynamic var rating: String? = nil
//    let developers = List<Int>()
//    @objc dynamic var lastUpdated: String? = nil
//    let genres = List<Int>()
//    let publishers = List<Int>()
//    let alternates = List<String>()
//    var uids = List<Uids>()
//    @objc dynamic var video: String? = nil
//    @objc dynamic var sound: String? = nil
//    @objc dynamic var os: String? = nil
//    @objc dynamic var processor: String? = nil
//    @objc dynamic var ram : String? = nil
//    @objc dynamic var hdd: String? = nil
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case gameTitle = "game_title"
//        case releaseDate = "release_date"
//        case lastUpdated = "last_updated"
//        case platform, overview, youtube, players, coop, rating, developers, genres, publishers, alternates, uids, video, sound, os, processor, ram, hdd
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id.value = try container.decodeIfPresent(Int.self, forKey: .id)
//        self.gameTitle = try container.decode(String.self, forKey: .gameTitle)
//        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
//        self.platform.value = try container.decodeIfPresent(Int.self, forKey: .platform)
//        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
//        self.youtube = try container.decodeIfPresent(String.self, forKey: .youtube)
//        self.players.value = try container.decodeIfPresent(Int.self, forKey: .players)
//        self.coop = try container.decodeIfPresent(String.self, forKey: .coop)
//        self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
//        let genreList = try container.decode([Int].self, forKey: .genres)
//        self.genres.append(objectsIn: genreList)
//        let publishersList = try container.decode([Int].self, forKey: .publishers)
//        self.publishers.append(objectsIn: publishersList)
//        let alternatesList = try container.decode([String].self, forKey: .alternates)
//        self.alternates.append(objectsIn: alternatesList)
//        let uidList = try container.decode([Uids].self, forKey: .uids)
//        self.uids.append(objectsIn: uidList)
//        self.video = try container.decodeIfPresent(String.self, forKey: .video)
//        self.sound = try container.decodeIfPresent(String.self, forKey: .sound)
//        self.os = try container.decodeIfPresent(String.self, forKey: .os)
//        self.processor = try container.decodeIfPresent(String.self, forKey: .processor)
//        self.ram = try container.decodeIfPresent(String.self, forKey: .ram)
//        self.hdd = try container.decodeIfPresent(String.self, forKey: .hdd)
//        
//        
//    }
//    
//}
//
//
//
//class Uids: Object, Codable {
//    @objc dynamic var uid : String = ""
//    @objc dynamic var gamesUIDsPatternsID: Int = 0
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case uid
//        case gamesUIDsPatternsID = "games_uids_patterns_id"
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.uid = try container.decode(String.self, forKey: .uid)
//        self.gamesUIDsPatternsID = try container.decode(Int.self, forKey: .gamesUIDsPatternsID)
//        
//    }
//}
//
//
//class ExtraItems: Object, Codable {
//    
//    @objc dynamic var boxart : BoxArtData?
//    @objc dynamic var platform: PlatformDataInfo?
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case boxart
//        case platform
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.boxart = try container.decodeIfPresent(BoxArtData.self, forKey: .boxart)
//        self.platform = try container.decodeIfPresent(PlatformDataInfo.self, forKey: .platform)
//    }
//    
//}
//
//
//class BoxArtData: Object, Codable {
//    
//    @objc dynamic var baseURL: ImagesBaseURL?
////    var data: [String: [ExtraImages]]
//    var data = List<ExtraImages>()
//    
//    enum CodingKeys: String, CodingKey {
//        case baseURL = "base_url"
//        case data
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.baseURL = try container.decodeIfPresent(ImagesBaseURL.self, forKey: .baseURL)
//        let extraImagesList = try container.decode([ExtraImages].self, forKey: .data)
//        self.data.append(objectsIn: extraImagesList)
//        
//    }
//}
//
//
//
//class ImagesBaseURL: Object, Codable {
//
//    @objc dynamic var original : String = ""
//    @objc dynamic var small : String = ""
//    @objc dynamic var thumb : String = ""
//    @objc dynamic var croppedCenterThumb: String = ""
//    @objc dynamic var medium : String = ""
//    @objc dynamic var large: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case original, small, thumb
//        case croppedCenterThumb = "cropped_center_thumb"
//        case medium, large
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.original = try container.decode(String.self, forKey: .original)
//        self.small = try container.decode(String.self, forKey: .small)
//        self.thumb = try container.decode(String.self, forKey: .thumb)
//        self.croppedCenterThumb = try container.decode(String.self, forKey: .croppedCenterThumb)
//        self.medium = try container.decode(String.self, forKey: .medium)
//        self.large = try container.decode(String.self, forKey: .large)
//    }
//
//    
//}
//
//
//class ExtraImages: Object, Codable {
//    
//    @objc dynamic var gameID: String = ""
//    @objc dynamic var id: Int = 0
//    @objc dynamic var type : String? = nil
//    @objc dynamic var side: String? = nil
//    @objc dynamic var filename: String = ""
//    @objc dynamic var resolution: String? = nil
//    
//    enum CodingKeys: String, CodingKey {
//        case gameID
//        case id
//        case type
//        case side
//        case filename
//        case resolution
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.gameID = try container.decode(String.self, forKey: .gameID)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.type = try container.decodeIfPresent(String.self, forKey: .type)
//        self.side = try container.decodeIfPresent(String.self, forKey: .side)
//        self.filename = try container.decode(String.self, forKey: .filename)
//        self.resolution = try container.decodeIfPresent(String.self, forKey: .resolution)
//    }
//    
//}
//
////
////enum ImageType: String, Codable {
////
////    case boxart = "boxart"
////    case fanart = "fanart"
////    case screenshot = "screenshot"
////    case banner = "banner"
////    case clearlogo = "clearlogo"
////
////
////}
////
////enum BoxSide: String, Codable {
////    case back = "back"
////    case front = "front"
////}
//
//
//
//class PlatformDataInfo: Object, Codable {
//    
////    let data: [String: PlatformInformation]
//    let data = List<PlatformDict>()
//    
//    enum CodingKeys: String, CodingKey {
//        case data
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let dataList = try container.decode([PlatformDict].self, forKey: .data)
//        self.data.append(objectsIn: dataList)
//        
//    }
//    
//}
//
//class PlatformDict: Object, Codable {
//    
//    @objc dynamic var name = ""
//    @objc dynamic var platformInfo : PlatformInformation?
//    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case platformInfo
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.platformInfo = try container.decode(PlatformInformation.self, forKey: .platformInfo)
//    }
//}
//
//class PlatformInformation: Object, Codable {
//    
//    @objc dynamic var id: Int = 0
//    @objc dynamic var name: String = ""
//    @objc dynamic var alias: String = ""
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case alias
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.alias = try container.decode(String.self, forKey: .alias)
//    }
//    
//    
//}
//
//class Page: Object, Codable {
//    
//    @objc dynamic var previous: String? = nil
//    @objc dynamic var current: String? = nil
//    @objc dynamic var next: String? = nil
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case previous
//        case current
//        case next
//    }
//    
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.previous = try container.decodeIfPresent(String.self, forKey: .previous)
//        self.current = try container.decodeIfPresent(String.self, forKey: .current)
//        self.next = try container.decodeIfPresent(String.self, forKey: .next)
//
//    }
//    
//}
