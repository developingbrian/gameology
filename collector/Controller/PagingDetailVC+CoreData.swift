//
//  PagingDetailVC+CoreData.swift
//  collector
//
//  Created by Brian on 12/31/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension PagingDetailVC {
    
    
    func saveGameToCoreData(_ title: String,_ id: Int,_ imageData: Data,_ platformObject: PlatformObject) {
        
        let persistedGame = SavedGames(context: persistenceManager.context)
        guard let gamePlatformID = game.platformID else { return }
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        let platformName = platform.name
        let platformID = platform.id
        
        
        persistedGame.title = title
        persistedGame.gameID = Int32(id)
        persistedGame.boxartImage = imageData
        persistedGame.owned = true
        persistedGame.releaseDate = game.releaseDate
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        if let releaseYear = truncatedReleaseDate {
            persistedGame.releaseYear = Int32(releaseYear)!
        }
        persistedGame.rating = game.rating
        persistedGame.boxartImageURL = game.boxartFrontImage
        persistedGame.developerName = game.developer
        persistedGame.platformName = platformName
        persistedGame.platformID = Int64(platformID)
        
        
        if let maxPlayers = game.maxPlayers {
            persistedGame.maxPlayers = Int64(maxPlayers)
        }
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        
        
        persistenceManager.save()
        
        
        
    }
    
    func saveFromWishListToCoreData(wishList: WishList) {
        let persistedGame = SavedGames(context: persistenceManager.context)
        
        
        let platform = fetchPlatformObject(platformID: Int(wishList.platformID))
        
        let platformName = platform.name
        let platformID = platform.id
        
        persistedGame.title = wishList.title
        persistedGame.gameID = wishList.gameID
        persistedGame.owned = true
        persistedGame.releaseDate = wishList.releaseDate
        persistedGame.releaseYear = wishList.releaseYear
        persistedGame.rating = wishList.rating
        persistedGame.boxartImageURL = wishList.boxartImageURL
        persistedGame.developerName = wishList.developerName
        persistedGame.platformName = wishList.platformName
        persistedGame.platformID = wishList.platformID
        persistedGame.maxPlayers = wishList.maxPlayers
        persistedGame.genre = wishList.genre
        persistedGame.genres = wishList.genres
        
        persistenceManager.save()
        
    }
    
    func saveGameToWishList(_ title: String,_ id: Int) {
        
        let persistedGame = WishList(context: persistenceManager.context)
        
        guard let gamePlatformID = game.platformID else { return }
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        
        let platformName = platform.name
        let platformID = platform.id
        
        
        persistedGame.title = title
        persistedGame.gameID = Int32(id)
        persistedGame.inWishlist = true
        persistedGame.releaseDate = game.releaseDate
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        if let releaseYear = truncatedReleaseDate {
            persistedGame.releaseYear = Int32(releaseYear)!
        }
        persistedGame.rating = game.rating
        persistedGame.boxartImageURL = game.boxartFrontImage
        persistedGame.developerName = game.developer
        persistedGame.platformName = platformName
        persistedGame.platformID = Int64(platformID)
        
        
        if let maxPlayers = game.maxPlayers {
            persistedGame.maxPlayers = Int64(maxPlayers)
        }
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        
        
        persistenceManager.save()
    }
    
    
    func checkForGameInLibrary(name: String, id: Int) -> Bool {
            print("checkforgame called")
        let savedGames = persistenceManager.fetch(SavedGames.self)
        
        for savedGame in savedGames {
            if savedGame.title == name && savedGame.gameID == id {
                return true
            }
        }
        
        return false
        
    }
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
        print("Checking for game in wishlist")
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
             if savedGame.title == name && savedGame.gameID == id {
                print("Game is in wishlist")
                return true
        }
          

    }
        
        print("Game is not in wishlist")
        return false
    
    }
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
        let platformObj = platform[0]
        
        return platformObj
    }
    
    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
        print("checkforPlatform called")
        
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        
        for platform in savedPlatforms {
            print(platform.name, platform.id)
            if platform.name == name && platform.id == id {
                print("Platform \(platform.name) is in library")
                return true
            }
            
        }
        
        
        print("Platform is not in library")
        return false
        
        
        
    }
    
    func savePlatformToCoreData(_ id: Int) {
        
        let platform = Platform(context: persistenceManager.context)
        let platformObject = fetchPlatformObject(platformID: id)
        platform.id = Int32(platformObject.id)
        platform.name = platformObject.name
        persistenceManager.save()
        
        
        
    }
    
    func deleteGameFromWishList(title: String, id: Int) {
        
        let savedGames = persistenceManager.fetch(WishList.self)
        for currentGame in savedGames {
            
            if currentGame.title == title && currentGame.gameID == id {
                
                persistenceManager.delete(currentGame)
                persistenceManager.save()
            }
        }
        
    }
    
    func deleteGameFromCoreData() {
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        let savedGames = persistenceManager.fetch(SavedGames.self)
        guard let title = game.title else { return }
        guard let id = game.id else { return }
        guard let platformID = game.platformID else { return }
        let platform = fetchCoreDataPlatformObject(id: platformID)
        for currentGame in savedGames {
            
           if currentGame.title == title && currentGame.gameID == id {
            
            platform.removeFromGames(currentGame)
            persistenceManager.delete(currentGame)
            persistenceManager.save()
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
}
