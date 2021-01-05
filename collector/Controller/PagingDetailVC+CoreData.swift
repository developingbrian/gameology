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
