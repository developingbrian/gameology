////
////  OwnedGamesVC+CoreData.swift
////  collector
////
////  Created by Brian on 10/19/20.
////  Copyright © 2020 Brian. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreData
//
//extension OwnedGamesViewController {
//    
//    func deleteAllPlatforms() {
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
//    func checkForGameInLibrary(name: String, id: Int) -> Bool {
//        print("checkforgame called")
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//        
//        for savedGame in savedGames {
//            if savedGame.title == name && savedGame.gameID == id {
//                return true
//            }
//        }
//        
//        return false
//        
//    }
//    
//    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
//        print("checkforPlatform called")
//        
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//        
//        for platform in savedPlatforms {
//            if platform.name == name && platform.id == id {
//                return true
//            }
//            
//        }
//        
//        
//        return false
//        
//        
//        
//    }
//    
//    
//    
//    
//    func fetchCoreDataPlatformObject(id: Int) -> Platform {
//        
//        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
//        
//        let platformobj = platform[0]
//        
//        return platformobj
//    }
//    
//    
//    
//    func savePlatformToCoreData(_ id: Int) {
//        let platform = Platform(context: persistenceManager.context)
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
//    
//    func saveGameToCoreData(_ title: String,_ id: Int,_ imageData: Data,_ platformObject: PlatformObject) {
//        
//        let game = SavedGames(context: persistenceManager.context)
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
//            game.boxartImageURL = cell.game?.boxartFrontImage
//            
//            if let screenshots = cell.game?.screenshots {
//                for screenshot in screenshots {
//                    
//                    if let imageID = screenshot.imageID {
//                        game.screenshotImageIDs?.append(imageID)
//                    }
//                }
//            }
//            
//            
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
//            game.rating = cell.game?.rating
//            
//            if let totalRating = cell.game?.totalRating {
//                game.totalRating = Int32(totalRating)
//            }
//            
//            if let userRating = cell.game?.userRating {
//                game.userRating = Int32(userRating)
//            }
//            
//            game.developerName = cell.game?.developer
//            game.owned = true
//            game.gameID = Int32((cell.game?.id)!)
//            game.platformID = Int64((cell.game?.platformID)!)
//            game.maxPlayers = cell.game?.maxPlayers
//            game.genre = cell.game?.genreDescriptions
//            game.genres = cell.game?.genres
//            
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
//        
//    }
//    
//    func deleteGameFromCoreData(index: IndexPath) {
//        
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//        let indexPath = index
//        if let cell = tableView.cellForRow(at: indexPath) as? OwnedGamesVCTableViewCell {
//            let platform1 = fetchCoreDataPlatformObject(id: cell.platformID!)
//            
//            for currentGame in savedGames {
//                
//                if currentGame.title == cell.gameName && currentGame.gameID == cell.id! {
//                    
//                    platform1.removeFromGames(currentGame)
//                    
//                    persistenceManager.delete(currentGame)
//                    
//                    if platform1.games!.count < 1 {
//                        
//                        persistenceManager.delete(platform1)
//                        
//                    }
//                    
//                    persistenceManager.save()
//                    break
//                    
//                }
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
//    func getSavedGames() {
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//        self.ownedGames = savedGames
//        
//        
//    }
//    
//    func getSavedPlatforms() {
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//        self.savedPlatforms = savedPlatforms
//    }
//    
//    
//    
//    
//}
