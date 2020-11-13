//
//  PagingDetailVC.swift
//  collector
//
//  Created by Brian on 11/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import Parchment

class PagingDetailVC: UIViewController {

    var game = GameObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = .black

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")

        let detailVC = firstViewController as? DetailViewController
        detailVC?.game = game
        let pagingViewController = PagingViewController(viewControllers: [firstViewController, secondViewController, thirdViewController])
    
    
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 415, height: 60))
        button.backgroundColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.35
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
        let buttonImage = fetchAddToButtonIcon(platformID: game.platformID, owned: game.owned)
        button.setTitle("Add to Library", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 0)
        button.setImage(UIImage(named: buttonImage), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 300)
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: pagingViewController.view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: pagingViewController.view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.bottomAnchor.constraint(equalTo: pagingViewController.view.bottomAnchor, constant: 0).isActive = true
        
        pagingViewController.indicatorColor = UIColor.gray
        
            pagingViewController.textColor = UIColor.black

        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])}

}
