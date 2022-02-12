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
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        persistedGame.maxPlayers = game.maxPlayers
        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedGames()
        }
        
    }
    
    func saveFromWishListToCoreData(wishList: WishList) {
        let persistedGame = SavedGames(context: persistenceManager.context)
        
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
        
        let savedGames = persistenceManager.fetch(SavedGames.self)
        
        for savedGame in savedGames {
            if savedGame.title == name && savedGame.gameID == id {
                return true
            }
        }
        
        return false
        
    }
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
        
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
            if savedGame.title == name && savedGame.gameID == id {
                
                return true
            }
            
            
        }
        
        return false
        
    }
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
        
        let platformObj = platform[0]
        
        return platformObj
    }
    
    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
        
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        
        for platform in savedPlatforms {
            
            if platform.name == name && platform.id == id {
                
                return true
            }
            
        }
        
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
        
    }
    
    func getSavedPlatforms() {
        
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        self.savedPlatforms = savedPlatforms
        
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
                return true
            }
            
        }
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
    }
    
    
    
    func getWishlist() {
        let wishList = persistenceManager.fetch(WishList.self)
        self.wishList = wishList
    }
    
}
