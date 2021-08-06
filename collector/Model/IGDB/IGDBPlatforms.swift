// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let iGDBPlatforms = try? newJSONDecoder().decode(IGDBPlatforms.self, from: jsonData)

import Foundation

// MARK: - IGDBPlatform

//struct Platforms: Codable {
//    var consolePlatforms: [String]?
//    var portablePlatforms: [String]?
//
//
//}

struct IGDBPlatform: Codable {
    let id: Int
    let alternativeName: String?
    let category, createdAt: Int?
    let name: String
    let platformLogo: Int?
    let slug: String?
    let updatedAt: Int?
    let url: String?
    let versions, websites: [Int]?
    let checksum: String?
    let generation, platformFamily: Int?
    let abbreviation: String?
 
    enum CodingKeys: String, CodingKey {
        case id
        case alternativeName = "alternative_name"
        case category
        case createdAt = "created_at"
        case name
        case platformLogo = "platform_logo"
        case slug
        case updatedAt = "updated_at"
        case url, versions, websites, checksum, generation
        case platformFamily = "platform_family"
        case abbreviation
    }
}

typealias IGDBPlatforms = [IGDBPlatform]
