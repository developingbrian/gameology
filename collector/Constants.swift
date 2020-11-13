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
static let youtubeEmbedURL = "https://www.youtube.com/embed/"

    
}

enum Constant {
    static let igdbAPIKey = "886c478126bb68dd167a6eeec66f0922"
    static let screenScaperDevID = "thesuffering"
    static let screenScraperDevPassword = "06QOJ0pDreS"
    static let gameDBAPIKey = "8b574d53e9ff612a214486cfe8def1f5c045b0e4eaac50cfd54aa7873d89fd7b"
    static let youtubeEmbedURL = "https://www.youtube.com/embed/"
    
}

enum baseURL : String{
    
    case original = "https://cdn.thegamesdb.net/images/original/"
    case small = "https://cdn.thegamesdb.net/images/small/"
    case thumb = "https://cdn.thegamesdb.net/images/thumb/"
    case medium = "https://cdn.thegamesdb.net/images/medium/"
    case large = "https://cdn.thegamesdb.net/images/large/"
    case croppedCenterThumb = "https://cdn.thegamesdb.net/images/cropped_center_thumb/"
}
