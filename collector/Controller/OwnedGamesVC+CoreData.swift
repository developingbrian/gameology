//
//  OwnedGamesVC+CoreData.swift
//  collector
//
//  Created by Brian on 10/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension OwnedGamesViewController {
    
    func deleteAllPlatforms() {
        self.getSavedPlatforms()

        let savedPlatforms = persistenceManager.fetch(Platform.self)
        for platform in savedPlatforms {
            persistenceManager.delete(platform)
            
        }
        self.getSavedPlatforms()

        let deadline = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: deadline) {
        }
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
    
    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
        print("checkforPlatform called")
        
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        
        for platform in savedPlatforms {
//            print(platform.name, platform.id)
            if platform.name == name && platform.id == id {
//                print("Platform \(platform.name) is in library")
                return true
            }
            
        }
        
        
        print("Platform is not in library")
        return false
        
        
        
    }
    
    
    func fetchPlatformCoreData(name: String) {
        
        
        
        
        
    }
    //check if platform exists
        //if platform exists
            //retrieve platform
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
        print(platform)
        let platformobj = platform[0]
        
        return platformobj
    }
            //save game object to platform
        //else
            //create platform
            //save game object to platform
    func savePlatformToCoreData(_ id: Int) {
        let platform = Platform(context: persistenceManager.context)
        let platformObject = fetchPlatformObject(platformID: id)
        platform.id = Int32(platformObject.id)
        
        platform.name = platformObject.name
        print(platformObject)
        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedPlatforms()
        }
    }
    
    
    func saveGameToCoreData(_ title: String,_ id: Int,_ imageData: Data,_ platformObject: PlatformObject) {
        print("saveGameToCoreData PlatformObject \(platformObject)")
        let game = SavedGames(context: persistenceManager.context)
        //platform object in core data
//        let platform = Platform(context: persistenceManager.context)
        game.title = title
        game.gameID = Int32(id)
        game.boxartImage = imageData

        //check against platform id to see if platform exists in core data
   
        
        //if platform exists in core data
        
            // add game to platform based on its platform id
        
        //if doesnt exist in core data
        
            //add platform to core data
        
                // add game to platform based on its platform id

        let indexPath = ViewController.savedGameIndex
        if let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell {
           
//            print("checkforplatform \(checkForPlatformInLibrary(name: platformObject.name, id: platformObject.id))")
//            print(Int32(platformObject.id))
//            platform.id = Int32(platformObject.id)
//            print(platform.id)
//            platform.name = platformObject.name
//            print(platformObject.name)
//            print(platform.name)
//
            cell.game?.owned = true
            cell.platformID = platformObject.id
            cell.platformName = platformObject.name
            game.boxartImageURL = cell.game?.boxartFrontImage
            
            if let screenshots = cell.game?.screenshots {
            for screenshot in screenshots {
                
                if let imageID = screenshot.imageID {
                game.screenshotImageIDs?.append(imageID)
                }
            }
            }
            
            
            if let width = cell.game?.boxartInfo?.width {
            game.boxartWidth = Int32(width)
            }
           if let height = cell.game?.boxartInfo?.height {
            game.boxartHeight = Int32(height)
            }
            
            game.releaseDate = cell.game?.releaseDate
            
            game.rating = cell.game?.rating
            if let totalRating = cell.game?.totalRating {
                game.totalRating = Int32(totalRating)
            }
            if let userRating = cell.game?.userRating {
                game.userRating = Int32(userRating)
            }
            
            game.developerName = cell.game?.developer
            game.owned = true
            game.gameID = Int32((cell.game?.id)!)
            game.platformID = Int64((cell.game?.platformID)!)
            // TODO: FIX CORE DATA MAX PLAYER TO STRING

            game.maxPlayers = cell.game?.maxPlayers
            
//            game.platform?.id = Int32(platformObject.id)
//            game.platform?.name = platformObject.name
            game.genre = cell.game?.genreDescriptions
            game.genres = cell.game?.genres
//            let platformObject1 = savePlatformToCoreData(platformObject.id)
//            platformObject1.addToGames(game)
//            platform.addToGames(game)
//            print("platform CORE DATA1 \(platformObject1)")
            
        }

        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedGames()
        }
        
    }
    
    func deletePlatformFromCoreData() {
        print("delete platform from core data")
//        var platform = Platform(context: persistenceManager.context)
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        let indexPath = ViewController.savedGameIndex
        if let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell {
            
            for platform1 in savedPlatforms {
                
//                if platform1.name == nil && platform1.id == nil {
//                    persistenceManager.delete(platform1)
//                }
                
                if platform1.name == cell.platformName && platform1.id == cell.platformID! {
                    print("platforms match")
                    persistenceManager.delete(platform1)
                    break
                }
                
                persistenceManager.save()
            }
                getSavedPlatforms()
            
        }
        
        let deadline = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.getSavedPlatforms()
        }
        
    }
    
    func deleteGameFromCoreData(index: IndexPath) {
        print("deleting game from core data")
//        var platform = Platform(context: persistenceManager.context)
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
        let savedGames = persistenceManager.fetch(SavedGames.self)
        let indexPath = index
        if let cell = tableView.cellForRow(at: indexPath) as? OwnedGamesVCTableViewCell {
            let platform1 = fetchCoreDataPlatformObject(id: cell.platformID!)
            print("platform1 is", platform1)
//            for platform in savedPlatforms {
//                print("platformSavedBefore")
//                print(platform)
//                print("cellPlatform")
//                print(cell.platform)
//                print(platform.id, cell.platformID!)
//                if platform.id == cell.platformID! && platform.name == cell.platformName! {
//                    print("successfully deleting 1 platform")
//            persistenceManager.delete(platform)
//                }
//                print("platformSavedAfter")
//                print(platform)
//            }

            
            //identify from game which platform its under
                //fetch that platform object from core data
                    //platformobject.removeFromGames(currentGame)
                    //check platform object count, if 0 remove platform object
            
            
            
           
            for currentGame in savedGames {
                //if one of the games in saved games == the cell you chose then:
                if currentGame.title == cell.gameName && currentGame.gameID == cell.id! {
                    print("currentGame")
                    print(currentGame)
                    print("platform.removefromgames")
//                    platform.removeFromGames(currentGame)
                    print(platform1.games!.count)
                    platform1.removeFromGames(currentGame)
//                    print(platform1.games?.count)

                    print("persistencemanager.delete(currentGame)")
 
                    persistenceManager.delete(currentGame)
                    
                    if platform1.games!.count < 1 {
                        
//                        print("going to delete the following platform:", platform1.name)
                        persistenceManager.delete(platform1)
                        
                    }
//                    print("persistencemanager.delete(platform)")
//                    persistenceManager.delete(platform)

//                    cell.addToLibraryButton.setImage(UIImage(systemName: "rectangle"), for: .normal)
                    persistenceManager.save()
                    break
                    
                    //remove game from platform
                    
                    //if platform game count < 1 remove platform from core data
                    
                    
                }
                
//
//                for platform in savedPlatforms {
//                                        if platform.id == cell.platform?.id && platform.name == cell.platform?.name {
//                                        persistenceManager.delete(platform)
//                                            break
//                                    }
//                                    }
//
//                if savedPlatforms.count < 0 {
//                    for platform in savedPlatforms {
//                        if platform.id == cell.platform?.id && platform.name == cell.platform?.name {
//                        persistenceManager.delete(platform)
//                    }
//                    }
//                }
                
            }
        }
        
//        deletePlatformFromCoreData()
        
        let deadline = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.getSavedGames()
            self.getSavedPlatforms()
        }
        
        
    }
    
    func getSavedGames() {
        let savedGames = persistenceManager.fetch(SavedGames.self)
        self.ownedGames = savedGames
        printSavedGames()
        
        
    }
    
    func getSavedPlatforms() {
        print("getSavedPlatforms")
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        self.savedPlatforms = savedPlatforms
        printSavedPlatforms()
    }
    
    func printSavedGames() {
        
        ownedGames.forEach { (game) in
            print("game core data")
//            print(game.title, game.gameID)
            
        }
    }
    
    func printSavedPlatforms() {
        
        savedPlatforms.forEach{ (platform) in
            print("platform core data")
//            print(platform.name, platform.id)
        }
    }
    
    
    
}
