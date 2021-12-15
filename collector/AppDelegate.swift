//
//  AppDelegate.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        SDImageCache.shared.config.maxDiskAge = 3600 * 24 * 7 //1 Week
                
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 20 //Aprox 20 images
        //SDImageCache.shared().config.shouldCacheImagesInMemory = false //Default True => Store images in RAM cache for Fast performance
//        SDImageCache.shared.config.shouldDecompressImages = false
                
//        SDWebImageDownloader.shared.shouldDecompressImages = false
                
        SDImageCache.shared.config.diskCacheReadingOptions = NSData.ReadingOptions.mappedIfSafe
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

