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



extension ViewController {
    
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
    
    
    func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool {
            print("checkforgame called")
        let savedGames = persistenceManager.fetch(SavedGames.self)
        
        for savedGame in savedGames {
            if savedGame.title == name && savedGame.gameID == id && savedGame.platformID == Int64(platformID) {
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
    
    func checkForGenreInLibrary(name: String) -> Bool {
        
        let savedGenres = persistenceManager.fetch(GameGenre.self)
        
        for genre in savedGenres {
//            print(genre.name)
            if genre.name == name {
//                print("Genre", genre.name, "is saved")
                return true
            }
            
        }
        print("genre is not saved")
        return false
    }
    
    
    func fetchPlatformCoreData(name: String) {
        
        
        
        
        
    }
    //check if platform exists
        //if platform exists
            //retrieve platform
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
        let platformobj = platform[0]
        
        return platformobj
    }
    
    func fetchCoreDataGenreObject(name: String) -> GameGenre {
        let genre = persistenceManager.fetchFilteredByGenre(GameGenre.self, name: name)
        let genreObject = genre[0]
        
        return genreObject
        
        
    }
            //save game object to platform
        //else
            //create platform
            //save game object to platform
    func savePlatformToCoreData(_ id: Int) {
        let platform = Platform(context: persistenceManager.context)
        print(platform)
        let platformObject = fetchPlatformObject(platformID: id)
        platform.id = Int32(platformObject.id)
        
        platform.name = platformObject.name
        print(platformObject)
        print(platform)
        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedPlatforms()
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
            game.platformName = platformObject.name
            game.boxartImageURL = cell.game?.boxartFrontImage
            
            var screenshots : [String] = []
            if let gameScreenshots = cell.game?.screenshots {
            for screenshot in gameScreenshots {
                
                if let imageID = screenshot.imageID {
               
                    screenshots.append(imageID)
                    print("saving screenshots")
                    print("imageID is", imageID)
                }
            }
            }
            game.screenshotImageIDs = screenshots
            
            if let width = cell.game?.boxartInfo?.width {
            game.boxartWidth = Int32(width)
            }
           if let height = cell.game?.boxartInfo?.height {
            game.boxartHeight = Int32(height)
            }
            game.releaseDate = cell.game?.releaseDate
            
          
            var truncatedReleaseDate: String?
            truncatedReleaseDate = cell.game?.releaseDate?.toLengthOf(length: 6)
            if let releaseDate = truncatedReleaseDate {
                game.releaseYear = Int32(releaseDate)!
            }
            game.youtubeURL = cell.game?.youtubePath
            game.overview = cell.game?.overview
//            print("game overview \(game.overview)")
            game.rating = cell.game?.rating
            game.developerName = cell.game?.developer
            game.owned = true
            if let gameID = cell.game?.id {
                game.gameID = Int32(gameID)
            }
            if let platformID = cell.game?.platformID {
                game.platformID = Int64(platformID)
            }
            if let userRating = cell.game?.userRating {
            game.userRating = Int32(userRating)
            }
            if let totalRating = cell.game?.totalRating {
            game.totalRating = Int32(totalRating)
            }
            // TODO: FIX CORE DATA MAX PLAYER TO STRING
//            if let maxPlayers = cell.game?.maxPlayers {
//                game.maxPlayers = maxPlayers
//            }
            
//            game.platform?.id = Int32(platformObject.id)
//            game.platform?.name = platformObject.name
            game.genre = cell.game?.genreDescriptions
            if let genres = cell.game?.genres {
                game.genres = genres
//                print("game.genres is", game.genres)

            } else {
                game.genres?.append("")
            }
            
//            let platformObject1 = savePlatformToCoreData(platformObject.id)
//            platformObject1.addToGames(game)
//            platform.addToGames(game)
//            print("platform CORE DATA1 \(platformObject1)")
            
        }
        print("image ids")
        print(game.screenshotImageIDs)
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            
            self.getSavedGames()
        }
        tableView.reloadData()
        
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
        tableView.reloadData()
    }
    
    func
    deleteGameFromCoreData() {
        print("deleting game from core data")
//        var platform = Platform(context: persistenceManager.context)
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
        let savedGames = persistenceManager.fetch(SavedGames.self)
        let indexPath = ViewController.savedGameIndex
        if let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell {
            let platform1 = fetchCoreDataPlatformObject(id: cell.platformID!)

            print("game info", cell.game?.title, cell.game?.platformID, ViewController.savedGameIndex)
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
                if currentGame.title == cell.game?.title && currentGame.gameID == (cell.game?.id)! {
                    print("currentGame")
                    print(currentGame)
                    print("platform.removefromgames")
//                    platform.removeFromGames(currentGame)
                    platform1.removeFromGames(currentGame)

                    print("persistencemanager.delete(currentGame)")
 
                    persistenceManager.delete(currentGame)
//                    print("persistencemanager.delete(platform)")
//                    persistenceManager.delete(platform)
                    var unownedImage = ""
                    if let platformID = cell.game?.platformID {
                     unownedImage = fetchAddToButtonIcon(platformID: platformID, owned: false)
                    }
//                    let unownedImage = fetchSaveToLibraryBtnImg(platformID: (cell.game?.platformID)!, owned: false)
                    print("viewcontroller + coredata \(unownedImage)")
                    cell.addToLibraryButton.setImage(UIImage(named: unownedImage), for: .normal)
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
        self.savedGames = savedGames
        printSavedGames()
        
        
    }
    
    func getSavedPlatforms() {
        print("getSavedPlatforms")
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        self.savedPlatforms = savedPlatforms
        printSavedPlatforms()
    }
    
    func getSavedGenres() {
        let savedGenres = persistenceManager.fetch(GameGenre.self)
        self.savedGenres = savedGenres
        printSavedGenres()
    }
    
    func printSavedGames() {
        
        savedGames.forEach { (game) in
            print("game core data")
//            print(game.title, game.gameID)
            
        }
    }
    
    func printSavedGenres() {
        savedGenres.forEach{ (genre) in
            print("genre core data")
//            print(genre.name)
            
        }
    }
    
    func printSavedPlatforms() {
        
        savedPlatforms.forEach{ (platform) in
            print("platform core data")
//            print(platform.name, platform.id)
        }
    }
    

    func saveGameToWishList(_ title: String,_ id: Int, game: GameObject) {
        
        let persistedGame = WishList(context: persistenceManager.context)
        
        
            guard let gamePlatformID = game.platformID else { return }
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        
        let platformName = platform.name
//        let platformID = platform.id
        
        
        persistedGame.title = title
        persistedGame.gameID = Int32(id)
        
        if let userRating = game.userRating {
        persistedGame.userRating = Int32(userRating)
            print("userRating", userRating, persistedGame.userRating)

        }
        if let totalRating = game.totalRating {
            persistedGame.totalRating = Int32(totalRating)

            print("totalRating", totalRating, persistedGame.totalRating)

            
        }
        
        var screenshotsArray : [String]? = []
        if let screenshots = game.screenshots {
            for screenshot in screenshots {
                if let imageID = screenshot.imageID {
                    
                    print("adding screenshot", imageID)
                    screenshotsArray?.append(imageID)
                }
            }
        }
        print("screenshots array", screenshotsArray)
        persistedGame.screenshotImageIDs = screenshotsArray
//        persistedGame.screenshotImageIDs?.append(contentsOf: screenshotsArray)
        print("persisted screenshots", persistedGame.screenshotImageIDs)
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
        persistedGame.youtubeURL = game.youtubePath
        
        
        if let maxPlayers = game.maxPlayers {
            persistedGame.maxPlayers = maxPlayers
        }
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        print("genres", persistedGame.genres)
        
        
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
    
    func getWishlist() {
         let wishList = persistenceManager.fetch(WishList.self)
         self.wishList = wishList
         printWishList()
     }
    
    func printWishList() {
        wishList.forEach { (game) in
            print("Wishlist")
//            print(game.title)
            
            
        }
        
    }
    
}
