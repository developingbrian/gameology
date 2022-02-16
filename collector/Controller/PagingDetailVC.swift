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
    var network = Networking.shared
    var button = UIButton()
    var wishlistButton = UIButton()
    let persistenceManager = PersistenceManager.shared
    var boxartImage : UIImage?
    var pagingViewController = PagingViewController()
    var savedGames : [SavedGames] = [SavedGames]()
    var savedGenres : [GameGenre] = []
    var wishList : [WishList] = [WishList]()
    var savedPlatforms : [Platform] = [Platform]()
    var viewControllers : [UIViewController] = []
    let titles = ["Details", "Media", "My Game"]
    let gradientLayer = CAGradientLayer()
    let screenSize = UIScreen.main.bounds
    var titled = ""
    var gameID = 0
    let buttonImgView = UIImageView()

    deinit {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppearance()
        self.pagingViewController.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
        pagingViewController.delegate = self
        pagingViewController.dataSource = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
        viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        let detailVC = firstViewController as? DetailViewController
        let mediaVC = secondViewController as? MediaVC
        let myGameVC = thirdViewController as? MyGameVC
        
        detailVC?.game = self.game
        mediaVC?.game = self.game
        myGameVC?.game = self.game

        if let gameTitle = game.title {
            titled = gameTitle
        }
        if let id = game.id {
            gameID = id
        }

        view.addSubview(pagingViewController.view)
        
        addChild(pagingViewController)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        createAddToLibraryButton()
        createWishlistButton()
        
        pagingViewController.indicatorColor = .white
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pagingViewController.indicatorOptions = .visible(height: 3, zIndex: 1, spacing: insets , insets: insets)
        
        setAppearance()
    }

    override func viewDidLayoutSubviews() {
        gradientLayer.frame = button.bounds
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return true
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
            let color1 = UIColorFromRGB(0x2B95CE)
            
            pagingViewController.menuBackgroundColor = .tertiarySystemBackground
            pagingViewController.borderColor = .gray
            pagingViewController.textColor = .black
            pagingViewController.selectedBackgroundColor = color1
            pagingViewController.selectedTextColor = .white
            pagingViewController.reloadData()
            navigationController?.view.backgroundColor = .white
        } else if traitCollection.userInterfaceStyle == .dark {
            let color1 = UIColorFromRGB(0x2B95CE)
            
            pagingViewController.menuBackgroundColor = .tertiarySystemBackground
            pagingViewController.textColor = UIColor.white
            pagingViewController.selectedTextColor = UIColor.white
            pagingViewController.selectedBackgroundColor = color1
            pagingViewController.borderColor = .tertiarySystemBackground
            pagingViewController.reloadData()
            navigationController?.view.backgroundColor = .black
        }
    }

    func createWishlistButton() {
        wishlistButton = UIButton(type: .system)
        if persistenceManager.isGameInWishlist(gameID: gameID) {
            wishlistButton.setTitle("Wishlist", for: .normal)
            wishlistButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            wishlistButton.setTitle("Wishlist", for: .normal)
            wishlistButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        wishlistButton.contentHorizontalAlignment = .left
        wishlistButton.contentVerticalAlignment = .bottom
        wishlistButton.semanticContentAttribute = .forceRightToLeft
        wishlistButton.sizeToFit()
        wishlistButton.addTarget(self, action: #selector(self.addToWishListButtonPressed), for: .touchUpInside)
        
        if persistenceManager.isGameInLibrary(gameID: gameID) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: wishlistButton)
        }
    }
    
    func createAddToLibraryButton() {
        let screenWidth = screenSize.width
        
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 310, height: 60))
        button.backgroundColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        
        var platformID = 0
        if game.platformID != nil {platformID = game.platformID!}
        
        let gameOwned = persistenceManager.isGameInLibrary(gameID: gameID)
        let buttonImage = fetchAddToButtonIcon(platformID: platformID, owned: gameOwned)
        buttonImgView.image = UIImage(named: buttonImage)
        buttonImgView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(buttonImgView)
        
        var width = screenWidth
        if screenWidth < 414 {
            width = screenWidth * 0.005
        } else {
            width = screenWidth * 0.1
        }

        NSLayoutConstraint.activate([
            
            buttonImgView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: width),
            
            buttonImgView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            buttonImgView.heightAnchor.constraint(equalToConstant: 45),
            buttonImgView.widthAnchor.constraint(equalToConstant: 76)
            
        ])
        
        if persistenceManager.isGameInLibrary(gameID: gameID) {
            
            button.setTitle("Remove from Library", for: .normal)
        } else {
            button.setTitle("Add to Library", for: .normal)
        }

        button.addTarget(self, action: #selector(self.didPressLibraryButton), for: .touchUpInside)
        
        button.imageView?.contentMode = .scaleAspectFit
        
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: pagingViewController.view.bottomAnchor, constant: -5),
            button.leadingAnchor.constraint(equalTo: pagingViewController.view.leadingAnchor, constant: 5),
            button.trailingAnchor.constraint(equalTo: pagingViewController.view.trailingAnchor, constant: -5),
            button.heightAnchor.constraint(equalToConstant: 55)
            
        ])
        
        let color2 = UIColorFromRGB(0x2ECAD5)
        let color1 = UIColorFromRGB(0x2B95CE)
        button.layer.cornerRadius = 6
        button.backgroundColor = .red
        button.layoutIfNeeded()
        gradientLayer.colors = [color2.cgColor
                                ,color1.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = button.bounds
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        gradientLayer.cornerRadius = 6
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func addToWishListButtonPressed() -> Void {
        guard let id = game.id else { return }

        if persistenceManager.isGameInWishlist(gameID: id) {
            persistenceManager.removeGameFromWishlist(gameID: id)
            wishlistButton.setImage(UIImage(systemName: "star"), for: .normal)
            wishlistButton.setTitle("Wishlist", for: .normal)
            wishlistButton.sizeToFit()
        } else {
            persistenceManager.saveGameToWishlist(game: game)
            wishlistButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            wishlistButton.setTitle("Wishlist", for: .normal)
            wishlistButton.sizeToFit()
        }

    }

    @objc func didPressLibraryButton() {
        guard let gameID = game.id else { return }

        switch persistenceManager.isGameInLibrary(gameID: gameID) {
            case true:
                promptDeleteConfirmation()

            case false:
                addGameToLibrary()
        }

        if persistenceManager.isGameInWishlist(gameID: gameID) {
            wishlistButton.setTitle("Add to Wishlist", for: .normal)
            wishlistButton.setImage(UIImage(systemName: "star"), for: .normal)
            wishlistButton.sizeToFit()
        }

        self.navigationItem.rightBarButtonItem = nil
        pagingViewController.reloadData()
    }

    func addGameToLibrary() {
        guard let platformID = game.platformID else { return }
        persistenceManager.saveGameToLibrary(game: game)
        let imageIcon = game.fetchLibraryIcon(platformID: platformID, isOwned: true)
        buttonImgView.image = imageIcon
        button.setTitle("Remove from Library", for: .normal)
    }

    func removeGameFromLibrary() {
        guard let platformID = game.platformID else { return }
        guard let gameID = game.id else { return }
        let platformIsInLibrary = self.persistenceManager.isPlatformInLibrary(platformID: platformID)

        if platformIsInLibrary {
            self.persistenceManager.removeGameFromLibrary(gameID: gameID)
        }

        let imageIcon = game.fetchLibraryIcon(platformID: platformID, isOwned: false)
        buttonImgView.image = imageIcon
        button.setTitle("Add To Library", for: .normal)

    }


    func promptDeleteConfirmation() {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let deleteAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] action in
            self?.removeGameFromLibrary()
        }

        let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved data and information will not be able to be restored.", preferredStyle: .alert)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

}






extension PagingDetailVC : PagingViewControllerDataSource, PagingViewControllerDelegate {

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: titles[index])
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
    }

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        guard let gameID = game.id else { return 2 }

        if persistenceManager.isGameInLibrary(gameID: gameID) {
            return 3
        } else {
            return 2
        }
    }
    
}
