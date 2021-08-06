//
//  Constants.swift
//  collector
//
//  Created by Brian on 5/5/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation

struct Constants {
static let igdbAPIKey = "886c478126bb68dd167a6eeec66f0922"
static let screenScaperDevID = "thesuffering"
static let screenScraperDevPassword = "06QOJ0pDreS"
static let gameDBAPIKey = "8b574d53e9ff612a214486cfe8def1f5c045b0e4eaac50cfd54aa7873d89fd7b"
static let gameDBAPIKeyip = "9ae02cc7fbae0bab0e316ad739c7c335b77062eb008a67f14990ecc8b14660e2"
static let youtubeEmbedURL = "https://www.youtube.com/embed/"

    
}

enum Constant {
    static let igdbAPIKey = "886c478126bb68dd167a6eeec66f0922"
    static let screenScaperDevID = "thesuffering"
    static let screenScraperDevPassword = "06QOJ0pDreS"
    static let gameDBAPIKeyip = "9ae02cc7fbae0bab0e316ad739c7c335b77062eb008a67f14990ecc8b14660e2"
    static let gameDBAPIKey = "8b574d53e9ff612a214486cfe8def1f5c045b0e4eaac50cfd54aa7873d89fd7b"
    static let youtubeEmbedURL = "https://www.youtube.com/embed/"
    static let twitchClientID = "8og8u13zzj49cru9v0qgp386m3g39e"
    static let twtichClientSecret = "dtwp54ffq3cyocz5dygktc3mzby8dc"
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
