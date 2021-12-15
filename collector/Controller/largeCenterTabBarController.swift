//
//  largeCenterTabBarController.swift
//  collector
//
//  Created by Brian on 8/25/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class largeCenterTabBarController: UITabBarController, UITabBarControllerDelegate {
var gradientLayer = CAGradientLayer()
var middleBtn = UIButton()


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    setAppearance()
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.delegate = self
        tabBar.backgroundColor = .clear
        UITabBar.setTransparentTabbar()

        setupMiddleButton()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
      gradientLayer.frame = middleBtn.bounds
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let darkBlue = UIColorFromRGB(0x2ECAD5)
         middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
        middleBtn.layer.cornerRadius = (middleBtn.frame.width / 2)
        middleBtn.clipsToBounds = true
        middleBtn.translatesAutoresizingMaskIntoConstraints = false

        
        
        //STYLE THE BUTTON YOUR OWN WAY
//        middleBtn.applyGradients(colors: [lightBlue.cgColor, darkBlue.cgColor])
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lightBlue.cgColor, darkBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = middleBtn.bounds
        gradientLayer.masksToBounds = false
        middleBtn.layer.insertSublayer(gradientLayer, below: middleBtn.imageView?.layer)
        
        
//        middleBtn.setBackgroundImage(UIImage(systemName: "gamecontroller.fill"), for: .normal)
        middleBtn.setImage(UIImage(systemName: "gamecontroller.fill"), for: .normal)
        middleBtn.tintColor = .white
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        self.tabBar.layoutIfNeeded()
//        self.view.layoutIfNeeded()
    }
    
    

    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
    }

    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")

        
        if appearanceSelection == 0 {
            self.navigationController?.overrideUserInterfaceStyle = .unspecified
            self.tabBarController?.overrideUserInterfaceStyle = .unspecified
            overrideUserInterfaceStyle = .unspecified
        } else if appearanceSelection == 1 {
            overrideUserInterfaceStyle = .light
            self.navigationController?.overrideUserInterfaceStyle = .light
            self.tabBarController?.overrideUserInterfaceStyle = .light



        } else {
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark


        }
        
        if traitCollection.userInterfaceStyle == .light {
//            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            
//            self.tabBar.backgroundColor = lightGray
            

        } else if traitCollection.userInterfaceStyle == .dark {
//            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
//            self.tabBar.backgroundColor = darkGray
        }
    
    
}

}
