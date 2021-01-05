//
//  MyGameTableViewCells+CoreData.swift
//  collector
//
//  Created by Brian on 12/7/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import CoreData


//extension CopyCell {
//    
//    
//    func savePhotoToCoreData(image: UIImage, category: String, gameTitle: String) {
//        
//        
//        let userStorage = Photos(context: persistenceManager.context)
//        let pngImageData = image.pngData()
//        
//        userStorage.photo = pngImageData
//        userStorage.category = category
//        userStorage.gameTitle = gameTitle
//        persistenceManager.save()
//        
//        let deadline = DispatchTime.now() + 2
//        
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//
//                
//            self.getSavedPhotos()
//            }
//        
//        
//    }
//}
