//
//  GamesDBImages.swift
//  collector
//
//  Created by Brian on 4/9/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation


struct GameDBData : Decodable {
    let data : GameDataImages?
}

struct GameDataImages : Decodable {
    
    let images : Images
    let baseURL : DetailBaseURL
    
    enum CodingKeys: String, CodingKey {
        case images
        case baseURL = "base_url"
    }
}
struct DetailBaseURL : Decodable {
    let original : String
    let small : String
    let thumb : String
    let croppedCenterThumb: String
    let medium : String
    let large: String
    
    enum CodingKeys: String, CodingKey {
        case original
        case small
        case thumb
        case medium
        case large
        case croppedCenterThumb = "cropped_center_thumb"
    }
}

struct Images : Decodable {
    
    var innerArray: [String?: [Inner]]
    
    struct Inner: Decodable {
        let id : Int
        let fileName  : String
        let type : String
        
        enum CodingKeys : String, CodingKey {
            case id
            case fileName = "filename"
            case type
            
        }
    }
    
    private struct CustomCodingKeys: CodingKey {
        var stringValue : String
        init?(stringValue : String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        self.innerArray = [String: [Inner]]()
        for key in container.allKeys {
            let value = try container.decode([Inner].self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
            self.innerArray[key.stringValue] = value
        }
    }

}
//struct Images : Decodable {
//
//    let id  : Int
//    let fileName : String
//    let type : String
//
//    enum TopLevelCodingKeys:  String, CodingKey {
//        case images
//
//    }
//
//    enum UserCodingKeys: String, CodingKey {
//        case id
//        case fileName = "filename"
//        case type
//
//    }
//
//
//    init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: TopLevelCodingKeys.self)
//            let userContainer = try container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .images)
//            id = try userContainer.decode(Int.self, forKey: .id)
//            fileName = try userContainer.decode(String.self, forKey: .fileName)
//            type = try userContainer.decode(String.self, forKey: .type)
//
//        }
    
    


//struct ImageInfo : Decodable {
//    
//    var id : Int
//    var filename : String
//    var type : String
//    
//}
