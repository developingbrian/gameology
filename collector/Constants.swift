//
//  Constants.swift
//  collector
//
//  Created by Brian on 5/5/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation

struct Constants {
    static let youtubeEmbedURL = "https://www.youtube.com/embed/"
    
}

enum Constant {
    static let youtubeEmbedURL = "https://www.youtube.com/embed/"
    
}

enum baseURL : String {
    
    case coverSmall = "https://images.igdb.com/igdb/image/upload/t_cover_small/"
    case screenshotMedium = "https://images.igdb.com/igdb/image/upload/t_screenshot_med/"
    case coverLarge = "https://images.igdb.com/igdb/image/upload/t_cover_big/"
    case logoMedium = "https://images.igdb.com/igdb/image/upload/t_logo_med/"
    case screenshotLarge = "https://images.igdb.com/igdb/image/upload/t_screenshot_big/"
    case screenshotHuge = "https://images.igdb.com/igdb/image/upload/t_screenshot_huge/"
    case thumbnail = "https://images.igdb.com/igdb/image/upload/t_thumb/"
    case micro = "https://images.igdb.com/igdb/image/upload/t_micro/"
    case hd = "https://images.igdb.com/igdb/image/upload/t_720p/"
    case fullHD =
            "https://images.igdb.com/igdb/image/upload/t_1080p/"
}

enum SortSection: String, CaseIterable {
    case title = "title"
    case platformName = "platformID"
    case genre = "genre"
    case releaseDate = "releaseYear"
}
