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
    var extraImages : Image?
    var screenshotArray : [GameImages.Inner] = []
    var fanartArray : [GameImages.Inner] = []
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


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)


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
        
        print("pagingVC gameObject = \(game)")
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
        
        let logo = UIImage(named: "glogo44")
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
        print("setting appearance in pagingVC")
        
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

        } else if traitCollection.userInterfaceStyle == .dark {
           let color1 = UIColorFromRGB(0x2B95CE)

            pagingViewController.menuBackgroundColor = .tertiarySystemBackground
            pagingViewController.textColor = UIColor.white
            pagingViewController.selectedTextColor = UIColor.white
            pagingViewController.selectedBackgroundColor = color1
            pagingViewController.borderColor = .tertiarySystemBackground
            pagingViewController.reloadData()
        }
    }
    
    
    func createWishlistButton() {
        
        wishlistButton = UIButton(type: .system)
        if checkForGameInWishList(name: titled, id: gameID) {
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

        
        if checkForGameInLibrary(name: titled, id: gameID) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: wishlistButton)
        }
    }
    
    func createAddToLibraryButton() {
        let screenWidth = screenSize.width
        
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 430, height: 60))
        button.backgroundColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.35
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
   
        
        var platformID = 0
        if game.platformID != nil {platformID = game.platformID!}

        let gameOwned = checkForGameInLibrary(name: titled, id: gameID)
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
//            buttonImgView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -5),
//            buttonImgView.topAnchor.constraint(equalTo: button.topAnchor, constant: 5),
         
            buttonImgView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: width),
            
            buttonImgView.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            buttonImgView.heightAnchor.constraint(equalToConstant: 45),
            buttonImgView.widthAnchor.constraint(equalToConstant: 76)

        ])
        print("buttonImage = \(buttonImage)")
        if checkForGameInLibrary(name: titled, id: gameID) {

            button.setTitle("Remove from Library", for: .normal)
        } else {
            button.setTitle("Add to Library", for: .normal)
            }
        
        
        button.addTarget(self, action: #selector(self.addToLibraryButtonPressed), for: .touchUpInside)

        button.imageView?.contentMode = .scaleAspectFit

        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: pagingViewController.view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: pagingViewController.view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: pagingViewController.view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
        let color2 = UIColorFromRGB(0x2ECAD5)
        let color1 = UIColorFromRGB(0x2B95CE)

        button.backgroundColor = .red
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
        button.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    @objc func addToWishListButtonPressed() -> Void {
        
        
        guard let gameTitle = game.title else { return }
        guard let id = game.id else { return }
        if checkForGameInWishList(name: titled, id: id) {
            
            deleteGameFromWishList(title: gameTitle, id: id)
            wishlistButton.setImage(UIImage(systemName: "star"), for: .normal)
            wishlistButton.setTitle("Wishlist", for: .normal)
            wishlistButton.sizeToFit()
            getWishlist()
        } else {
            
            saveGameToWishList(gameTitle, id)
            wishlistButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            wishlistButton.setTitle("Wishlist", for: .normal)
            wishlistButton.sizeToFit()

            getWishlist()
            
        }
        
    }
    
    
    @objc func addToLibraryButtonPressed() -> Void {
        guard let gamePlatformID = game.platformID else { return }
        _ = fetchSaveToLibraryBtnImg(platformID: gamePlatformID, owned: true)
        let unownedImage = fetchAddToButtonIcon(platformID: gamePlatformID, owned: false)
      
        let ownedImage = fetchAddToButtonIcon(platformID: gamePlatformID, owned: true)
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        let platformName = platform.name
        let platformID = platform.id
        
        print("Add to Library Button Pressed")
        guard let gameTitle = game.title else { return }
        guard let id = game.id else { return }
        let test = checkForGameInLibrary(name: gameTitle, id: id)
        print("game in library = \(test)")
        if checkForGameInLibrary(name: gameTitle, id: id) {
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { (action) in
                
                self.buttonImgView.image = UIImage(named: unownedImage)
                self.button.setTitle("Add to Library", for: .normal)

                self.game.owned = false
                let test2 = self.checkForPlatformInLibrary(name: platformName, id: platformID)
            print("platform in library = \(test2)")
                if self.checkForPlatformInLibrary(name: platformName, id: platformID) {
                print("Game in library, deleting")
                    self.deleteGameFromCoreData()
 
                    let existingPlatform = self.fetchCoreDataPlatformObject(id: platformID)
                guard let gamesInPlatform = existingPlatform.games else { return }
                if gamesInPlatform.count < 1 {
                    self.deletePlatformFromCoreData()
                }
                    self.getSavedGames()
                    self.getSavedPlatforms()
//                self.viewDidLoad()
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.wishlistButton)

                    self.pagingViewController.reloadData()
            }
            }
            let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved pictures and stats will not be able to be restored.", preferredStyle: .alert)
            alert.addAction(deleteConfirmation)
            alert.addAction(cancel)
            self.present(alert, animated: true) {
                
            }

        }
            
            
 else {
            self.buttonImgView.image = UIImage(named: ownedImage)
            button.setTitle("Remove from Library", for: .normal)
            game.owned = true
    guard let gameTitle = game.title, let gameID = game.id, let image = boxartImage else {
                print("One of the following may be nil:")
//                print("game.title", game.title)
//                print("game.id", game.id)
//                print("image", boxartImage)
                return }
    let imageData = image.jpegData(compressionQuality: 1)
//            print("imageData \(imageData)")
            
                
           saveGameToCoreData(gameTitle, gameID , imageData, platform)
    
                print("Paging VC saving game")
            
            
            let savedGames = persistenceManager.fetch(SavedGames.self)
            
            for currentGame in savedGames {
                print("starting loop")
//                print("title", currentGame.title, gameTitle)
                print("game.id", currentGame.gameID, gameID)
                if currentGame.title == gameTitle && currentGame.gameID == Int32(gameID) {
                    
                    if let genres = currentGame.genres {
//                        let savedGenres = persistenceManager.fetch(GameGenre.self)
                        
                            
                            for genre in genres {
                                
//                                    if savedGenres.count >= 1 {
                                    
                                if checkForGenreInLibrary(name: genre) {
                                    //genre exists-retrieving and adding to game
                                    let existingGenre = fetchCoreDataGenreObject(name: genre)
                                    currentGame.addToGenreType(existingGenre)
                                    persistenceManager.save()
                                    
                                } else {
                                    //genre doesnt exist, creating and then adding to game
                                    saveGenreToCoreData(genreName: genre)
                                    
                                    let newGenre = fetchCoreDataGenreObject(name: genre)
                                    currentGame.addToGenreType(newGenre)
                                    persistenceManager.save()
                                }
                            
//                                    } else {
//
//
//                                        saveGenreToCoreData(genreName: genre)
//
//                                        let newGenre = fetchCoreDataGenreObject(name: genre)
//                                        currentGame.addToGenreType(newGenre)
//                                        persistenceManager.save()
//                                    }
                                
                            }
                        
       
                        
                    
                    }
                    
                    
                    
                    print("testing for platform")
                    let savedPlatform = persistenceManager.fetch(Platform.self)
                    
                    if savedPlatform.count >= 1 {
                        
                        if checkForPlatformInLibrary(name: platformName, id: platformID) {
                            print("existing platform")
                            let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
                            existingPlatform.addToGames(currentGame)
                            persistenceManager.save()
//                            print(existingPlatform.games)

                        
                            
                        } else {
                            print("new platform")
                            savePlatformToCoreData(platformID)
                            persistenceManager.save()
                            print("newplatform platform id = \(platformID)")
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
//                            print(newPlatform.games)

                        }
                    }
                    else {
                          savePlatformToCoreData(platformID)
                        let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                        newPlatform.addToGames(currentGame)
                        persistenceManager.save()
//                        print(newPlatform.games)

                        
                        
                        
                    }
                    
                    
                }
            }
    if checkForGameInWishList(name: gameTitle, id: gameID) {
        
        deleteGameFromWishList(title: titled, id: gameID)
        wishlistButton.setTitle("Add to Wishlist", for: .normal)
        wishlistButton.setImage(UIImage(systemName: "star"), for: .normal)
        wishlistButton.sizeToFit()
    }
            getSavedGames()
            getSavedPlatforms()
            self.navigationItem.rightBarButtonItem = nil
            pagingViewController.reloadData()
        }
    
        
    }
    

    
    
    
    func fetchSaveToLibraryBtnImg(platformID: Int, owned: Bool) -> String {
        switch platformID {
        case 7:
            if owned {
                return "nes-minus-inversed"
            } else {
               return "nes-plus-inversed"
            }
        case 6:
            if owned {
                return "snes-minus-inversed"
            } else {
                return "snes-plus-inversed"
            }
        case 3:
            if owned {
                return "n64-minus-inversed"
            } else {
                return "n64-plus-inversed"
            }
        case 4:
            if owned {
                return "gb-minus-inversed"
            } else {
                return "gb-plus-inversed"
            }
        case 2:
            if owned {
                //gamecube
                return "gc-minus-inversed"
            } else {
                return "gc-plus-inversed"
            }
        case 5:
            if owned {
                return "gba-minus-inversed"
            } else {
                return "gba-plus-inversed"
            }
        case 18:
            if owned {
                return "genesis-minus-inversed"
            } else {
                return "genesis-plus-inversed"
            }
        case 21:
            if owned {
                //Sega CD
                return "cd-minus-inversed"
            } else {
                return "cd-plus-inversed"
            }
        default:
            if owned {
                return "folder_placeholder_owned_black"
            } else {
                return "folder_placeholder_unowned"
            }
        }
    }
    

    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {

        var platform = PlatformObject(id: 0, abbreviation: nil, alternativeName: nil, category: nil, createdAt: nil, generation: nil, name: "", platformLogo: nil, platformFamily: nil, slug: nil, updatedAt: nil, url: nil, versions: nil, checksum: nil)
        
        let platforms = network.platforms
        
        for platformObject in platforms {
            
            if platformObject.id == platformID {
                
                 platform = PlatformObject(id: platformObject.id, abbreviation: platformObject.abbreviation, alternativeName: platformObject.alternativeName, category: platformObject.category, createdAt: platformObject.createdAt, generation: platformObject.generation, name: platformObject.name, platformLogo: nil, platformFamily: platformObject.platformFamily, slug: platformObject.slug, updatedAt: platformObject.updatedAt, url: platformObject.url, versions: nil, checksum: platformObject.checksum)
               
            }
        }
        
        return platform
        
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
        guard let title = game.title else { return 2 }
        guard let gameID = game.id else { return 2 }
        
        print(title)
        print(gameID)
        
        print("numberofViewControllers \(title) \(gameID)")
        if checkForGameInLibrary(name: title, id: gameID) {
            print("returning 3")
            return 3
        } else {
            print("returning 2")

            return 2
        }
    }
    
}
