//
//  OnboardVC.swift
//  collector
//
//  Created by Brian on 12/6/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import SwiftUI



class OnboardController: UIViewController {
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        let splashView = SplashView()
        let introView = IntroView()
        
        if UserDefaults.standard.bool(forKey: "isOnboardingDone") == true {
            
            let launchController = UIHostingController.init(rootView: splashView)
            
            self.addChild(launchController)
            launchController.didMove(toParent: self)
            self.view.addSubview(launchController.view)
            
            launchController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                launchController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                launchController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                launchController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                launchController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
            
        } else {
            
            UserDefaults.standard.set(true, forKey: "isOnboardingDone")
            
            let onboardController = UIHostingController.init(rootView: introView)
            
            self.addChild(onboardController)
            
            
            onboardController.didMove(toParent: self)
            
            
            self.view.addSubview(onboardController.view)
            
            
            onboardController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                onboardController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                onboardController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                onboardController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                onboardController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
            
        }
    }
    
    func createObserver() {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(segueToStart(_:)), name: NSNotification.Name(rawValue: "push"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateInterfaceStyle(_:)), name: NSNotification.Name(rawValue: "interfaceStyle"), object: nil)
    }
    
    
    @objc func updateInterfaceStyle(_ notification : Notification) {
        
        if let style = notification.userInfo?["style"] as? Int {
            
            switch style {
            case 0:
                overrideUserInterfaceStyle = .unspecified
            case 1:
                overrideUserInterfaceStyle = .light
            case 2 :
                overrideUserInterfaceStyle = .dark
            default:
                overrideUserInterfaceStyle = .unspecified
            }
            
            
            
        }
        
        
    }
    
    
    
    @objc func segueToStart(_ notification: Notification) {
        
        let loadedStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //Load the ViewController
        let startVC =  loadedStoryboard.instantiateViewController(withIdentifier: "start")
        startVC.modalTransitionStyle = .crossDissolve
        startVC.modalPresentationStyle = .fullScreen
        
        
        present(startVC, animated: true, completion: {
            
        })
        
    }
    
}
