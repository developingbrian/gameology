//
//  MyGameVC+CoreData.swift
//  collector
//
//  Created by Brian on 11/22/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MyGameVC {
    func savePhotoToCoreData(image: UIImage, category: String, gameTitle: String) {
        
        
        let userStorage = Photos(context: persistenceManager.context)
        let pngImageData = image.pngData()
        
        userStorage.photo = pngImageData
        userStorage.category = category
        userStorage.gameTitle = gameTitle
        persistenceManager.save()
        
        let deadline = DispatchTime.now()
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {

                
            self.getSavedPhotos()
            }
        
        
    }
    
    func getSavedPhotos() {
        
        let gamePhoto = persistenceManager.fetchUserPhotos(Photos.self, category: "gamePhoto", gameTitle: game.title!)
         print("there are \(gamePhotos.count) game photos")
         let manualPhoto = persistenceManager.fetchUserPhotos(Photos.self, category: "manualPhoto", gameTitle: game.title!)
         
         let boxPhoto = persistenceManager.fetchUserPhotos(Photos.self, category: "boxPhoto", gameTitle: game.title!)
//        self.userPhotos = savedPhotos
        
        let index = IndexPath(row: 0, section: 0) 
            
            if let cell = self.tableView.cellForRow(at: index) as? PhotoCell {
                cell.gamePhotos = gamePhoto
                print(cell.gamePhotos)
                cell.boxPhotos = boxPhoto
                cell.manualPhotos = manualPhoto
                cell.collectionReloadData()
            }
    
}
    
    func hasUserPhotos(category: String?) -> Bool {
        
        let savedPhotos = persistenceManager.fetch(Photos.self)
        var returnValue = false
        
        if category != nil {
            
        for photo in savedPhotos {
            if photo.category == category {
                returnValue = true            }
        }
            
        } else {
            if savedPhotos.count > 0 {
                returnValue = true
            } else {
                returnValue = false
            }
            
        }
            return returnValue
        
    }
}

extension PhotoCell {
    
    
    func savePhotoToCoreData(image: UIImage, category: String) {
        let userStorage = Photos(context: persistenceManager.context)
        let pngImageData = UIImage.pngData(image)
        
        userStorage.photo = pngImageData()
        
        persistenceManager.save()
        
        let deadline = DispatchTime.now() + 2
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.getSavedPhotos()
        }
        
    }
    
    
    func deletePhotoFromCoreData(image: Data, category: String) {
        let savedPhotos = persistenceManager.fetch(Photos.self)
        
        for photo in savedPhotos {
//            print("deleting photo core data, category = \(category), photo.category = \(photo.category), image = \(image), photo.photo = \(photo)")
            if photo.category == category && photo.photo == image {
            persistenceManager.delete(photo)
            persistenceManager.save()
            }
        }
        
        getSavedPhotos()
        
    }
    
    func getSavedPhotos() {
        
        let savedPhotos = persistenceManager.fetch(Photos.self)
        self.userPhotos = savedPhotos
        printSavedPhotos()
    }
    
    func printSavedPhotos() {
        self.userPhotos.forEach { (photo) in
//            print(photo.photo)
        }
    }
    
    
    
    
    
}
