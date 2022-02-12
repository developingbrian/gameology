//
//  PlatformsVC+CoreData.swift
//  collector
//
//  Created by Brian on 10/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension PlatformsVC {
    


func fetchCoreDataPlatformObject(id: Int) -> Platform {
    
    let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)

    let platformobj = platform[0]
    
    return platformobj
}


}
