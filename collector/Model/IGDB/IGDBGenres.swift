//
//  IGDBGenres.swift
//  collector
//
//  Created by Brian on 5/4/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import Foundation

import Foundation

// MARK: - IGDBGenre
struct IGDBGenre: Codable {
    let id, createdAt: Int?
    let name, slug: String?
    let updatedAt: Int?
    let url: String?
    let checksum: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, slug
        case updatedAt = "updated_at"
        case url, checksum
    }
}

typealias IGDBGenres = [IGDBGenre]
