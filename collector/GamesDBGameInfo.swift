//
//  GamesDB.swift
//  collector
//
//  Created by Brian on 4/8/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation


struct GameDB : Decodable {
    var data : GameData
}



struct GameData : Decodable {
    
    var games : [Games]
   
    
}

struct Games : Decodable {
    var id : Int
    var players : Int?
    
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
}
