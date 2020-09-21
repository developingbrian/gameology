////
////  ScreenScraper.swift
////  collector
////
////  Created by Brian on 4/8/20.
////  Copyright © 2020 Brian. All rights reserved.
////
//
//import Foundation
//
//struct GameDetails : Decodable {
//
//    let response : Response
//
//}
//
//struct Response : Decodable {
//
//    let gameInfo : Jeu?
//
//    enum CodingKeys : String, CodingKey {
//        case gameInfo = "jeu"
//    }
//}
//
//struct Jeu : Decodable {
//
//    let media : [Media]
//
//    enum CodingKeys : String, CodingKey {
//        case media = "medias"
//    }
//}
//
//
//struct Media : Decodable {
//
//    let type : String
//    let url : String
//    let region : String?
//
//
//}

import Foundation

// MARK: - ScreenScraper
struct ScreenScraper: Codable {
    let header: Header
    let response: Response
}

// MARK: - Header
struct Header: Codable {
    let apIversion, dateTime: String
    let commandRequested: String
    let success, error: String

    enum CodingKeys: String, CodingKey {
        case apIversion = "APIversion"
        case dateTime, commandRequested, success, error
    }
}

// MARK: - Response
struct Response: Codable {
    let serveurs: Serveurs
    let ssuser: Ssuser?
    let jeu: Jeu
}

// MARK: - Jeu
struct Jeu: Codable {
    let id: String
    let romid: String?
    let notgame: String
    let noms: [DateElement]
    let regions: Regions?
    let cloneof: String?
    let systeme: Systeme?
    let editeur: Editeur?
    let developpeur: Developpeur?
    let joueurs, note: Joueurs?
    let topstaff, rotation: String
    let synopsis: [Synopsis]
    let classifications: [Classification]?
    let dates: [DateElement]?
    let genres, modes, familles, numeros: [Famille]?
    let medias: [Media]
    let roms: [ROM]
    let rom: ROM?
}

// MARK: - Classification
struct Classification: Codable {
    let type, text: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let region, text: String
}

struct Systeme: Codable {
    let id, text: String
}

struct Editeur: Codable {
    let id, text: String
}

// MARK: - Developpeur
struct Developpeur: Codable {
    let id, text: String
}

// MARK: - Famille
struct Famille: Codable {
    let id, nomcourt, principale, parentid: String
    let noms: [Synopsis]
}

// MARK: - Synopsis
struct Synopsis: Codable {
    let langue, text: String
}

// MARK: - Joueurs
struct Joueurs: Codable {
    let text: String
}

// MARK: - Media
struct Media: Codable {
    let type: String
    let parent: Parent
    let url: String
    let region: String?
    let crc, md5, sha1: String
    let size: String?
    let format: Format
    let subparent, id: String?
}

enum Format: String, Codable {
    case jpg = "jpg"
    case mp4 = "mp4"
    case pdf = "pdf"
    case png = "png"
    case svg = "svg"
}

enum Parent: String, Codable {
    case classification = "classification"
    case developpeur = "developpeur"
    case editeur = "editeur"
    case genre = "genre"
    case jeu = "jeu"
    case joueurs = "joueurs"
    case note = "note"
    case region = "region"
}

// MARK: - Regions
struct Regions: Codable {
    let shortname: String
}

// MARK: - ROM
struct ROM: Codable {
    let id, romnumsupport, romtotalsupport, romfilename: String
    let romregions, romtype, romsupporttype: String?
    let romsize, romcrc, rommd5, romsha1: String
    let romcloneof, beta, demo, proto: String
    let trad, hack, unl, alt: String
    let best, netplay: String
}

// MARK: - Serveurs
struct Serveurs: Codable {
    let cpu1, cpu2, threadsmin, nbscrapeurs: String
    let apiacces, closefornomember, closeforleecher: String
}

// MARK: - Ssuser
struct Ssuser: Codable {
    let id, numid, niveau, contribution: String
    let uploadsysteme, uploadinfos, romasso, uploadmedia: String
    let propositionok, propositionko, quotarefu, maxthreads: String
    let maxdownloadspeed, requeststoday, requestskotoday, maxrequestspermin: String
    let maxrequestsperday, maxrequestskoperday, visites, datedernierevisite: String
    let favregion: String
}
