//
//  ScreenScraper.swift
//  collector
//
//  Created by Brian on 4/8/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation

struct GameDetails : Decodable {
    
    let response : Response
    
}

struct Response : Decodable {
    
    let gameInfo : Jeu
    
    enum CodingKeys : String, CodingKey {
        case gameInfo = "jeu"
    }
}

struct Jeu : Decodable {
    
    let media : [Media]
    
    enum CodingKeys : String, CodingKey {
        case media = "medias"
    }
}


struct Media : Decodable {
    
    let type : String
    let url : String
    let region : String
    
    
}
