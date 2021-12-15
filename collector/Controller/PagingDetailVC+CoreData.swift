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
    
    
    func saveGameToCoreData(_ title: String,_ id: Int,_ platformObject: PlatformObject) {
        
        let persistedGame = SavedGames(context: persistenceManager.context)
        guard let gamePlatformID = game.platformID else { return }
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        let platformName = platform.name
        
        
        persistedGame.title = title
        persistedGame.gameID = Int32(id)
        persistedGame.owned = true
        persistedGame.releaseDate = game.releaseDate
        persistedGame.overview = game.overview
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        if let releaseYear = truncatedReleaseDate {
            persistedGame.releaseYear = Int32(releaseYear)!
        }
        persistedGame.youtubeURL = game.youtubePath
        persistedGame.rating = game.rating
        if let totalRating = game.totalRating {
        persistedGame.totalRating = Int32(totalRating)
        }
        if let userRating = game.userRating {
        persistedGame.userRating = Int32(userRating)
        }
        persistedGame.boxartImageURL = game.boxartFrontImage
        var gameScreenshots : [String] = []

        if let screenshots = game.screenshots {
        for screenshot in screenshots {
            
            if let imageID = screenshot.imageID {
                gameScreenshots.append(imageID)
            }
        }
        }
        persistedGame.screenshotImageIDs = gameScreenshots
        
        if let width = game.boxartInfo?.width {
        persistedGame.boxartWidth = Int32(width)
        }
       if let height = game.boxartInfo?.height {
        persistedGame.boxartHeight = Int32(height)
        }
        persistedGame.developerName = game.developer
        persistedGame.platformName = platformName
        persistedGame.platformID = Int64(platform.id)
        
        
        // TODO: FIX CORE DATA MAX PLAYER TO STRING
//
//        if let maxPlayers = game.maxPlayers {
//            persistedGame.maxPlayers = maxPlayers
//        }
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        
        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedGames()
        }
        
    }
    
    func saveFromWishListToCoreData(wishList: WishList) {
        let persistedGame = SavedGames(context: persistenceManager.context)
        
        
//        let platform = fetchPlatformObject(platformID: Int(wishList.platformID))
   
        
        persistedGame.title = wishList.title
        persistedGame.gameID = wishList.gameID
        persistedGame.overview = wishList.overview
        persistedGame.owned = true
        persistedGame.releaseDate = wishList.releaseDate
        persistedGame.releaseYear = wishList.releaseYear
        persistedGame.rating = wishList.rating
        persistedGame.boxartImageURL = wishList.boxartImageURL
        persistedGame.boxartHeight = wishList.boxartHeight
        persistedGame.boxartWidth = wishList.boxartWidth
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
//        let platformID = platform.id
        
        
        persistedGame.title = title
        persistedGame.gameID = Int32(id)
        persistedGame.inWishlist = true
        persistedGame.overview = game.overview
        persistedGame.releaseDate = game.releaseDate
        
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        if let releaseYear = truncatedReleaseDate {
            persistedGame.releaseYear = Int32(releaseYear)!
        }
        persistedGame.rating = game.rating
        persistedGame.boxartImageURL = game.boxartFrontImage
        if let width = game.boxartInfo?.width {
        persistedGame.boxartWidth = Int32(width)
        }
       if let height = game.boxartInfo?.height {
        persistedGame.boxartHeight = Int32(height)
        }
        persistedGame.developerName = game.developer
        persistedGame.platformName = platformName
        persistedGame.platformID = Int64(platform.id)
        
        
        
        if let maxPlayers = game.maxPlayers {
            persistedGame.maxPlayers = maxPlayers
        }
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        
        
        persistenceManager.save()
    }
    
    
    func checkForGameInLibrary(name: String, id: Int) -> Bool {
//            print("checkforgame called")
        let savedGames = persistenceManager.fetch(SavedGames.self)
        
        for savedGame in savedGames {
            if savedGame.title == name && savedGame.gameID == id {
                return true
            }
        }
        
        return false
        
    }
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
//        print("Checking for game in wishlist")
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
             if savedGame.title == name && savedGame.gameID == id {
//                print("Game is in wishlist")
                return true
        }
          

    }
        
//        print("Game is not in wishlist")
        return false
    
    }
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
//        print("platformplatform", platform)
        let platformObj = platform[0]
        
        return platformObj
    }
    
    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
//        print("checkforPlatform called")
        
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        
        for platform in savedPlatforms {
//            print(platform.name, platform.id)
            if platform.name == name && platform.id == id {
//                print("Platform \(platform.name) is in library")
                return true
            }
            
        }
        
        
//        print("Platform is not in library")
        return false
        
        
        
    }
    
    func savePlatformToCoreData(_ id: Int) {
        
        let platform = Platform(context: persistenceManager.context)
        let platformObject = fetchPlatformObject(platformID: id)
        platform.id = Int32(platformObject.id)
        
        platform.name = platformObject.name
        persistenceManager.save()
        
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedPlatforms()
        }
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
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
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
    
    
    func deletePlatformFromCoreData() {
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        guard let platformID = game.platformID else { return }
        
        for platform in savedPlatforms {
            if platform.id == platformID {
                persistenceManager.delete(platform)
                
            }
            
        persistenceManager.save()
            

            
        }
        
        
    }
    
    func getSavedGames() {
        let savedGames = persistenceManager.fetch(SavedGames.self)
        self.savedGames = savedGames
        printSavedGames()
        
        
    }
    
    func getSavedPlatforms() {
//        print("getSavedPlatforms")
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        self.savedPlatforms = savedPlatforms
        printSavedPlatforms()
    }
    
    func printSavedGames() {
        
        savedGames.forEach { (game) in
//            print("game core data")
//            print(game.title, game.gameID)
            
        }
    }
    
    func saveGenreToCoreData(genreName : String) {
        
        let genre = GameGenre(context: persistenceManager.context)
        genre.name = genreName
        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.getSavedGenres()
        }
        
    }
    
    func checkForGenreInLibrary(name: String) -> Bool {
        
        let savedGenres = persistenceManager.fetch(GameGenre.self)
        
        for genre in savedGenres {
            if genre.name == name {
//                print("Genre", genre.name, "is saved")
                return true
            }
            
        }
//        print("genre is not saved")
        return false
    }
    
    func fetchCoreDataGenreObject(name: String) -> GameGenre {
        let genre = persistenceManager.fetchFilteredByGenre(GameGenre.self, name: name)
        let genreObject = genre[0]
        
        return genreObject
        
        
    }
    
    func getSavedGenres() {
        let savedGenres = persistenceManager.fetch(GameGenre.self)
        self.savedGenres = savedGenres
        printSavedGenres()
    }
    
    func printSavedGenres() {
        savedGenres.forEach{ (genre) in
//            print("genre core data")
//            print(genre.name)
            
        }
    }
    
    
    
   func getWishlist() {
        let wishList = persistenceManager.fetch(WishList.self)
        self.wishList = wishList
        printWishList()
    }
    
    func printWishList() {
        wishList.forEach { (game) in
//            print("Wishlist")
//            print(game.title)
            
            
        }
        
    }
    
    func printSavedPlatforms() {
        if savedPlatforms.count < 1 {
//            print("platforms empty")
        } else {
        savedPlatforms.forEach{ (platform) in
//            print("platform core data")
//            print(platform.name, platform.id)
        }
        }
    }
    

    
    
    
}
