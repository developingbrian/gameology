//
//  WishlistVC+CoreData.swift
//  collector
//
//  Created by Brian on 2/27/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import Foundation
import CoreData


extension WishlistVC {
    func printSavedGenres() {
        savedGenres.forEach{ (genre) in
//            print("genre core data")
//            print(genre.name)
            
        }
    }
    
    func getSavedGenres() {
        let savedGenres = persistenceManager.fetch(GameGenre.self)
        self.savedGenres = savedGenres
        printSavedGenres()
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
//        print("genre is not saved")
        return false
    }
    
    func fetchCoreDataGenreObject(name: String) -> GameGenre {
        let genre = persistenceManager.fetchFilteredByGenre(GameGenre.self, name: name)
        let genreObject = genre[0]
        
        return genreObject
        
        
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
    
    
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
        let platformObj = platform[0]
        
        return platformObj
    }
    
    
    func savePlatformToCoreData(_ id: Int) {
        
        let platform = Platform(context: persistenceManager.context)
        let platformObject = fetchPlatformObject(platformID: id)
        platform.id = Int32(platformObject.id)
        
        platform.name = platformObject.name
        persistenceManager.save()
        
        
        
    }
    
    
    
    
}
