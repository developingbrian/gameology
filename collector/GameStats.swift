////
////  GameStats.swift
////  collector
////
////  Created by Brian on 3/10/20.
////  Copyright © 2020 Brian. All rights reserved.
////
//
//import Foundation
//
//struct Game:Decodable {
//    
//    var ageRating : [AgeRatings]?
//    var name : String?
//    var genres: [Genre] = []
//    
//    //    var platforms : Int?
//    //    var rating : Double?
//    //    var screenshots : Int?
//    var summary: String?
//    var cover: Cover?
//    var firstReleaseDate : Double?
//    var involvedCompanies: [InvolvedCompanies]?
//    var totalRating: Double?
//    var platforms: [Platform]?
//    var screenshots: [Screenshots]?
//    
//    enum CodingKeys: String, CodingKey {
//        case ageRating = "age_ratings"
//        case name, genres, summary, cover
//        case firstReleaseDate = "first_release_date"
//        case involvedCompanies = "involved_companies"
//        case totalRating = "total_rating"
//        case platforms
//        case screenshots
//    }
//    
//    //    indirect enum Covers: Decodable {
//    //        case cover(Cover)
//    //        case int(Int)
//    
//    //    init(from decoder: Decoder) throws {
//    //        let value = try decoder.singleValueContainer()
//    //        do {
//    //            print("cover")
//    //            self = .cover(try value.decode(Cover.self))
//    //        } catch DecodingError.typeMismatch {
//    //            print("int")
//    //            self = .int(try value.decode(Int.self))
//    //        }
//    //    }
//    //    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        //        summary = try container.decode(String.self, forKey: .summary)
//        //        totalRating = try container.decode(Double.self, forKey: .totalRating)
//        //        involvedCompanies = try container.decode([InvolvedCompanies]?.self, forKey: .involvedCompanies)
//        
//        if container.contains(.platforms) {
//            self.platforms = try container.decode([Platform]?.self, forKey: .platforms)
//            
//        }
//        
//        if container.contains(.firstReleaseDate) {
//            self.firstReleaseDate = try container.decode(Double?.self, forKey: .firstReleaseDate)
//        }
//        
//        if container.contains(.genres) {
//            self.genres = try container.decode([Genre].self, forKey: .genres)
//        }
//        
//        if container.contains(.ageRating) {
//            self.ageRating = try container.decode([AgeRatings]?.self, forKey: .ageRating)
//        }
//        
//        if container.contains(.summary) {
//            self.summary =  try container.decode(String.self, forKey: .summary)
//        } else {
//            self.summary = nil
//        }
//        if container.contains(.screenshots) {
//            self.screenshots = try container.decode([Screenshots]?.self, forKey: .screenshots) } else {
//            
//            self.screenshots = nil
//        }
//        
//        
//        
//        
//        if container.contains(.totalRating) {
//            self.totalRating = try container.decode(Double.self, forKey: .totalRating)
//        } else {
//            self.totalRating = nil
//        }
//        
//        if container.contains(.involvedCompanies) {
//            self.involvedCompanies = try container.decode([InvolvedCompanies]?.self, forKey: .involvedCompanies)
//            
//        } else {
//            self.involvedCompanies = nil
//        }
//        if container.contains(.cover) {
//            do {
//                cover = try container.decode(Cover.self, forKey: .cover)
//            } catch DecodingError.typeMismatch {
//                cover = nil
//            }
//            
//        } else {
//            cover = nil
//        }
//    }
//    //    init(from decoder: Decoder) throws {
//    //        let values = try decoder.container(keyedBy: CodingKeys.self)
//    //        self.name = try values.decode(String.self, forKey: .name)
//    //        self.platforms = try values.decode([Platform]?.self, forKey: .platforms)
//    //
//    //        if values.contains(.summary) {
//    //            self.summary =  try values.decode(String.self, forKey: .summary)
//    //        } else {
//    //            self.summary = nil
//    //        }
//    //
//    //        if let coverDecode = self.cover as? Cover {
//    //            var cover = coverDecode
//    //                cover = try values.decode(Cover.self, forKey: .cover)
//    ////           self.cover = try values.decode(Cover.self, forKey: .cover)
//    //        } else {
//    //            self.cover = nil
//    //        }
//    //
//    ////        if (self.cover as? Cover) != nil {
//    ////                self.cover = try values.decode(Cover.self, forKey: .cover)
//    ////                  } else {
//    ////                self.cover = nil
//    ////                  }
//    //
//    //        if values.contains(.totalRating) {
//    //            self.totalRating = try values.decode(Double.self, forKey: .totalRating)
//    //        } else {
//    //            self.totalRating = nil
//    //        }
//    //
//    //        if values.contains(.involvedCompanies) {
//    //            self.involvedCompanies = try values.decode([InvolvedCompanies]?.self, forKey: .involvedCompanies)
//    //
//    //        } else {
//    //            self.involvedCompanies = nil
//    //        }
//    //    }
//    
//}
//
//struct Genre : Decodable {
//    
//    
//    var name: String?
//}
//
//
//struct AgeRatings: Decodable {
//    
//    var id : Int?
//    var category : Int?
//    var rating : Int?
//    
//    
//    
//    
//    
//}
//
//
//
//struct Cover: Decodable {
//    
//    var id : UInt64?
//    var imageID : String?
//    
//    enum CodingKeys: String, CodingKey  {
//        case id
//        case imageID = "image_id"
//    }
//    
//}
//
//struct Screenshots:Decodable {
//    
//    var imageID : String?
//    
//    enum CodingKeys: String, CodingKey {
//        case imageID = "image_id"
//    }
//}
//
//struct InvolvedCompanies:Decodable {
//    
//    
//    var company: Companies?
//    
//}
//
//struct Companies:Decodable {
//    
//    var name: String?
//    
//}
//
//
//
//
//
//
//struct Platform: Decodable {
//    let id: Int
//    let name: String?
//    let platformLogo: PlatformLogo?
//    let versions: [PlatformVersion]?
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case platformLogo = "platform_logo"
//        case versions
//    }
//}
//
//struct PlatformVersion: Decodable {
//    
//    let platformLogo : PlatformLogo?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case platformLogo = "platform_logo"
//    }
//}
//
//struct PlatformLogo: Decodable {
//    
//    let imageID: String?
//    let url: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case imageID = "image_id"
//        case url
//    }
//    
//}
//
//
//
//
//extension AgeRatings {
//    
//    
//    enum Category  : Int, Decodable {
//        
//        case pegi = 1
//        case esrb
//        
//        var description: String {
//            return String(self.rawValue)
//        }
//        
//    }
//    
//    enum Rating : Int, Decodable {
//        
//        // PEGI
//        case three = 1
//        case seven
//        case twelve
//        case sixteen
//        case eighteen
//        // ESRB
//        case ratingPending = 6
//        case earlyChildhood
//        case everyone
//        case everyone10Plus
//        case teen
//        case mature
//        case adultsOnly
//        
//        var description: String {
//            return String(self.rawValue)
//        }
//    }
//}
//
//
//
//
//
