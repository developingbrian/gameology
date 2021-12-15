//
//  SceneDelegate.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import CoreData
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private(set) static var shared: SceneDelegate?

    var window: UIWindow?
    var persistenceManager = PersistenceManager.shared


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
   
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)


//         if UserDefaults.standard.bool(forKey: "isOnboardingDone") == true {
//              //Skip onboarding
//            let mainVC = storyboard.instantiateViewController(identifier: "start")
////            let mainVC = storyboard.instantiateViewController(identifier: "advancedSearch")
//
//            window?.rootViewController = mainVC
//
//         } else {
//              //Show onboarding screens
////              UserDefaults.standard.set(true, forKey: "isOnboardingDone")
//        let contentView = ContentView().environment(\.managedObjectContext, context)
//            let onboardVC = storyboard.instantiateViewController(identifier: "initial")
//            window?.rootViewController = onboardVC
//        window?.rootViewController = UIHostingController(rootView: contentView)
        Self.shared = self
//        var onboardDelegate : OnboardDelegate?
//        onboardDelegate = self
//        let contentView = IntroView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainVC = storyboard.instantiateViewController(withIdentifier: "start")
            let onboardingVC = storyboard.instantiateViewController(withIdentifier: "onboardController")
//            if UserDefaults.standard.bool(forKey: "isOnboardingDone")  == true {
//                window.rootViewController = mainVC
//            } else {
//                window.rootViewController = UIHostingController(rootView: contentView)
//            }
            window.rootViewController = onboardingVC
            self.window = window
            window.makeKeyAndVisible()
        }
//         }
        
//        var context: NSManagedObjectContext!
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        context = appDelegate.persistentContainer.viewContext
//        context.automaticallyMergesChangesFromParent = true
//

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

