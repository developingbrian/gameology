//
//  ViewController+CoreData.swift
//  collector
//
//  Created by Brian on 10/3/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import CoreData
import UIKit



//extension ViewController {
//    
//    func deleteAllPlatforms() {
//        //
//        self.getSavedPlatforms()
//
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//        for platform in savedPlatforms {
//            persistenceManager.delete(platform)
//
//        }
//        self.getSavedPlatforms()
//
//        let deadline = DispatchTime.now() + 2
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//        }
//    }
//
//
//    func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool {
//        //
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//
//        for savedGame in savedGames {
//            if savedGame.title == name && savedGame.gameID == id && savedGame.platformID == Int64(platformID) {
//                return true
//            }
//        }
//
//        return false
//
//    }
//
//    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
//        //
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//
//        for platform in savedPlatforms {
//
//            if platform.name == name && platform.id == id {
//
//                return true
//            }
//
//        }
//
//        return false
//
//
//
//    }
//
//    func checkForGenreInLibrary(name: String) -> Bool {
//        //
//        let savedGenres = persistenceManager.fetch(GameGenre.self)
//
//        for genre in savedGenres {
//
//            if genre.name == name {
//
//                return true
//            }
//
//        }
//
//        return false
//    }
//
//
//    func fetchPlatformCoreData(name: String) {
//      //
//
//
//
//
//    }
//
//
//    func fetchCoreDataPlatformObject(id: Int) -> Platform {
//        //
//        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
//        let platformobj = platform[0]
//
//        return platformobj
//    }
//
//    func fetchCoreDataGenreObject(name: String) -> GameGenre {
//        //
//        let genre = persistenceManager.fetchFilteredByGenre(GameGenre.self, name: name)
//        let genreObject = genre[0]
//
//        return genreObject
//
//
//    }
//
//    func savePlatformToCoreData(_ id: Int) {
//        //
//        let platform = Platform(context: persistenceManager.context)
//
//        let platformObject = fetchPlatformObject(platformID: id)
//        platform.id = Int32(platformObject.id)
//
//        platform.name = platformObject.name
//
//        persistenceManager.save()
//
//        let deadline = DispatchTime.now() + 2
//
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//
//            self.getSavedPlatforms()
//        }
//    }
//
//    func saveGenreToCoreData(genreName : String) {
//        //
//        let genre = GameGenre(context: persistenceManager.context)
//        genre.name = genreName
//
//        persistenceManager.save()
//
//        let deadline = DispatchTime.now() + 2
//
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//            self.getSavedGenres()
//        }
//
//    }
//
//    func saveGameToCoreData(_ title: String,_ id: Int,_ imageData: Data,_ platformObject: PlatformObject) {
//        //
//        let game = SavedGames(context: persistenceManager.context)
//        //platform object in core data
//
//        game.title = title
//        game.gameID = Int32(id)
//        game.boxartImage = imageData
//
//
//        let indexPath = ViewController.savedGameIndex
//        if let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell {
//
//            cell.game?.owned = true
//            cell.platformID = platformObject.id
//            cell.platformName = platformObject.name
//            game.platformName = platformObject.name
//            game.boxartImageURL = cell.game?.boxartFrontImage
//
//            var screenshots : [String] = []
//            if let gameScreenshots = cell.game?.screenshots {
//                for screenshot in gameScreenshots {
//
//                    if let imageID = screenshot.imageID {
//
//                        screenshots.append(imageID)
//
//                    }
//                }
//            }
//            game.screenshotImageIDs = screenshots
//            game.maxPlayers = cell.game?.maxPlayers
//            if let width = cell.game?.boxartInfo?.width {
//                game.boxartWidth = Int32(width)
//            }
//
//            if let height = cell.game?.boxartInfo?.height {
//                game.boxartHeight = Int32(height)
//            }
//
//            game.releaseDate = cell.game?.releaseDate
//
//
//            var truncatedReleaseDate: String?
//            truncatedReleaseDate = cell.game?.releaseDate?.toLengthOf(length: 6)
//
//            if let releaseDate = truncatedReleaseDate {
//                game.releaseYear = Int32(releaseDate)!
//            }
//
//            game.youtubeURL = cell.game?.youtubePath
//            game.overview = cell.game?.overview
//
//            game.rating = cell.game?.rating
//            game.developerName = cell.game?.developer
//            game.owned = true
//
//            if let gameID = cell.game?.id {
//                game.gameID = Int32(gameID)
//            }
//
//            if let platformID = cell.game?.platformID {
//                game.platformID = Int64(platformID)
//            }
//
//            if let userRating = cell.game?.userRating {
//                game.userRating = Int32(userRating)
//            }
//
//            if let totalRating = cell.game?.totalRating {
//                game.totalRating = Int32(totalRating)
//            }
//
//            game.genre = cell.game?.genreDescriptions
//            if let genres = cell.game?.genres {
//                game.genres = genres
//
//
//            } else {
//                game.genres?.append("")
//            }
//
//        }
//
//
//        persistenceManager.save()
//
//        let deadline = DispatchTime.now() + 2
//
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//
//            self.getSavedGames()
//        }
//        tableView.reloadData()
//
//    }
//
//    func deletePlatformFromCoreData() {
//
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//        let indexPath = ViewController.savedGameIndex
//        if let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell {
//
//            for platform1 in savedPlatforms {
//
//                if platform1.name == cell.platformName && platform1.id == cell.platformID! {
//
//                    persistenceManager.delete(platform1)
//                    break
//                }
//
//                persistenceManager.save()
//            }
//            getSavedPlatforms()
//
//        }
//
//        let deadline = DispatchTime.now() + 2
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//            self.getSavedPlatforms()
//        }
//        tableView.reloadData()
//    }
//
//
//
//    func
//    deleteGameFromCoreData() {
//        //
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//        let indexPath = ViewController.savedGameIndex
//        if let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell {
//            let platform1 = fetchCoreDataPlatformObject(id: cell.platformID!)
//
//            for currentGame in savedGames {
//
//                if currentGame.title == cell.game?.title && currentGame.gameID == (cell.game?.id)! {
//
//                    platform1.removeFromGames(currentGame)
//
//                    persistenceManager.delete(currentGame)
//
//                    var unownedImage = ""
//                    if let platformID = cell.game?.platformID {
//                        unownedImage = fetchAddToButtonIcon(platformID: platformID, owned: false)
//                    }
//
//                    cell.addToLibraryButton.setImage(UIImage(named: unownedImage), for: .normal)
//                    persistenceManager.save()
//                    break
//
//
//                }
//
//
//            }
//        }
//
//
//        let deadline = DispatchTime.now() + 2
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//            self.getSavedGames()
//            self.getSavedPlatforms()
//        }
//
//
//    }
//    
//    
//    
//    func getSavedGames() {
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//        self.savedGames = savedGames
//        
//        
//    }
//    
//    func getSavedPlatforms() {
//        
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//        self.savedPlatforms = savedPlatforms
//        
//    }
//    
//    func getSavedGenres() {
//        let savedGenres = persistenceManager.fetch(GameGenre.self)
//        self.savedGenres = savedGenres
//    }
//    
//    
//    
//    func saveGameToWishList(_ title: String,_ id: Int, game: GameObject) {
//        //
//        let persistedGame = WishList(context: persistenceManager.context)
//        
//        
//        guard let gamePlatformID = game.platformID else { return }
//        let platform = fetchPlatformObject(platformID: gamePlatformID)
//        
//        let platformName = platform.name
//        
//        persistedGame.title = title
//        persistedGame.gameID = Int32(id)
//        
//        if let userRating = game.userRating {
//            persistedGame.userRating = Int32(userRating)
//            
//        }
//        if let totalRating = game.totalRating {
//            persistedGame.totalRating = Int32(totalRating)
//            
//        }
//        
//        var screenshotsArray : [String]? = []
//        if let screenshots = game.screenshots {
//            for screenshot in screenshots {
//                if let imageID = screenshot.imageID {
//                    
//                    screenshotsArray?.append(imageID)
//                }
//            }
//        }
//        persistedGame.screenshotImageIDs = screenshotsArray
//        
//        persistedGame.inWishlist = true
//        persistedGame.overview = game.overview
//        persistedGame.releaseDate = game.releaseDate
//        
//        var truncatedReleaseDate: String?
//        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
//        if let releaseYear = truncatedReleaseDate {
//            persistedGame.releaseYear = Int32(releaseYear)!
//        }
//        persistedGame.rating = game.rating
//        persistedGame.boxartImageURL = game.boxartFrontImage
//        if let width = game.boxartInfo?.width {
//            persistedGame.boxartWidth = Int32(width)
//        }
//        if let height = game.boxartInfo?.height {
//            persistedGame.boxartHeight = Int32(height)
//        }
//        persistedGame.developerName = game.developer
//        persistedGame.platformName = platformName
//        persistedGame.platformID = Int64(platform.id)
//        persistedGame.youtubeURL = game.youtubePath
//        
//        
//        if let maxPlayers = game.maxPlayers {
//            persistedGame.maxPlayers = maxPlayers
//        }
//        persistedGame.genre = game.genreDescriptions
//        persistedGame.genres = game.genres
//        
//        persistenceManager.save()
//        
//        
//    }
//    
//    func deleteGameFromWishList(title: String, id: Int) {
//       //
//        let savedGames = persistenceManager.fetch(WishList.self)
//        for currentGame in savedGames {
//            
//            if currentGame.title == title && currentGame.gameID == id {
//                
//                persistenceManager.delete(currentGame)
//                persistenceManager.save()
//            }
//        }
//        
//    }
//    
//    func getWishlist() {
//        let wishList = persistenceManager.fetch(WishList.self)
//        self.wishList = wishList
//    }
//    
//    
//    
//    
//}
