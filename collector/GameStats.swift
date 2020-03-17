//
//  GameStats.swift
//  collector
//
//  Created by Brian on 3/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation

struct GameDetail:Decodable {
    
    
   
    var name : String
//    var platforms : Int?
//    var rating : Double?
//    var screenshots : Int?
    var summary: String?
    var cover: Cover?
    var involvedCompanies: [InvolvedCompanies]?
    var totalRating: Double?
    var platforms: [Platform]?
    
    enum CodingKeys: String, CodingKey {
        case name, summary, cover
        case involvedCompanies = "involved_companies"
        case totalRating = "total_rating"
        case platforms
    }
}

struct Cover:Decodable {
    
    var imageID : String?
    
    enum CodingKeys: String, CodingKey  {
        case imageID = "image_id"
    }
    
}

struct InvolvedCompanies:Decodable {
    
    
    var company:Companies?
    
}

struct Companies:Decodable {
    
    var name:String?
    
}






struct Platform: Decodable {
    let id: Int
    let name: String?
    let platformLogo: PlatformLogo?
    let abbreviation: String?
    

    enum CodingKeys: String, CodingKey {
        case id, name
        case platformLogo = "platform_logo"
        case abbreviation
    }
}

struct PlatformLogo: Decodable {
    
    let imageID: String
    
    enum CodingKeys: String, CodingKey {
        case imageID = "image_id"
    }
    
}










