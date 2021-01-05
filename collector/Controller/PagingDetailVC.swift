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
    var network = Networking()
    var extraImages : Image?
    var screenshotArray : [GameImages.Inner] = []
    var fanartArray : [GameImages.Inner] = []
    var button = UIButton()
    let persistenceManager = PersistenceManager.shared
    var boxartImage : UIImage?
    let vc = PagingViewController()
    var savedGames : [SavedGames] = [SavedGames]()
    var savedPlatforms : [Platform] = [Platform]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = .black
        print("pagingVC gameObject = \(game)")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")

        let detailVC = firstViewController as? DetailViewController
        let mediaVC = secondViewController as? MediaVC
        let myGameVC = thirdViewController as? MyGameVC
        detailVC?.game = self.game
        mediaVC?.game = self.game
        myGameVC?.game = self.game
        self.network.downloadGameImageJSON(gameID: game.id!) {
            print("PagingVC images downloaded")
            self.extraImages = self.network.image
            
            
            mediaVC?.extraImages = self.extraImages
        }
        var pagingViewController = PagingViewController()
        if game.owned == true {
         pagingViewController = PagingViewController(viewControllers: [firstViewController, secondViewController, thirdViewController])
        } else {
         pagingViewController = PagingViewController(viewControllers: [firstViewController, secondViewController])
    }
    
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 415, height: 60))
        button.backgroundColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.35
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
        guard let platformID = game.platformID else { return }
        guard let owned = game.owned else { return }
        
        let buttonImage = fetchAddToButtonIcon(platformID: platformID, owned: owned)
        if owned {

            button.setTitle("Remove from Library", for: .normal)
        } else {
            button.setTitle("Add to Library", for: .normal)
            }
        button.addTarget(self, action: #selector(self.addToLibraryButtonPressed), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 0)
        button.setImage(UIImage(named: buttonImage), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 300)
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: pagingViewController.view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: pagingViewController.view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.bottomAnchor.constraint(equalTo: pagingViewController.view.bottomAnchor, constant: 0).isActive = true
        
        let color1 = UIColorFromRGB(0x2B95CE)
        let color2 = UIColorFromRGB(0x2ECAD5)
        let liteOrange = UIColorFromRGB(0xe07652)
        let maroon = UIColorFromRGB(0xa7272d)
        let darkerRed = UIColorFromRGB(0x750004)
        let orange = UIColorFromRGB(0xf5a402)
//        button.applyGradient(colors:[liteOrange.cgColor, maroon.cgColor] )
        button.applyGradient(colors:[color2.cgColor, color1.cgColor] )
//        button.applyGradient(colors:[orange.cgColor, darkerRed.cgColor])

        
        pagingViewController.indicatorColor = UIColor.white
//        pagingViewController.applyGradient(colors: [color2.cgColor, color1.cgColor])
        
        
        
        if self.traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            let darkRed = UIColor(red: 167, green: 15, blue: 0, alpha: 1)
            pagingViewController.menuBackgroundColor = lightGray
            pagingViewController.borderColor = lightGray
            pagingViewController.textColor = UIColor.black
           } else {
            let darkGray = UIColor(red: (23/255), green: (25/255), blue: (26/255), alpha: 1)
            let lightOrange = UIColor(red: 227/255, green: 193/255, blue: 58/255, alpha: 1)

            pagingViewController.menuBackgroundColor = darkGray
            pagingViewController.textColor = UIColor.white
            pagingViewController.selectedTextColor = UIColor.white
            pagingViewController.selectedBackgroundColor = color1
            pagingViewController.borderColor = darkGray
            


       }

        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])}

    
    @objc func addToLibraryButtonPressed() -> Void {
        guard let gamePlatformID = game.platformID else { return }
        let ownedImage = fetchSaveToLibraryBtnImg(platformID: gamePlatformID, owned: true)
        let unownedImage = fetchSaveToLibraryBtnImg(platformID: gamePlatformID, owned: false)
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        let platformName = platform.name
        let platformID = platform.id
        
        print("Add to Library Button Pressed")
        guard let title = game.title else { return }
        guard let id = game.id else { return }
        let test = checkForGameInLibrary(name: title, id: id)
        print("game in library = \(test)")
        if checkForGameInLibrary(name: title, id: id) {
            button.setImage(UIImage(named: unownedImage), for: .normal)
            button.setTitle("Add to Library", for: .normal)

            game.owned = false
            let test2 = checkForPlatformInLibrary(name: platformName, id: platformID)
            print("platform in library = \(test2)")
            if checkForPlatformInLibrary(name: platformName, id: platformID) {
                print("Game in library, deleting")
                deleteGameFromCoreData()
 
                let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
                guard let gamesInPlatform = existingPlatform.games else { return }
                if gamesInPlatform.count < 1 {
                    deletePlatformFromCoreData()
                }
                
                vc.reloadMenu()
            }
            
            
        } else {
            button.setImage(UIImage(named: ownedImage), for: .normal)
            button.setTitle("Remove from Library", for: .normal)
            game.owned = true
            guard let gameTitle = game.title, let gameID = game.id else { return }
            let imageData = boxartImage?.pngData()
            if let image = imageData {
            
           saveGameToCoreData(gameTitle, gameID , image, platform)
                print("Paging VC saving game")
            }
            
            let savedGames = persistenceManager.fetch(SavedGames.self)
            
            for currentGame in savedGames {
                
                if currentGame.title == title && currentGame.gameID == Int32(id) {
                    
                    let savedPlatform = persistenceManager.fetch(Platform.self)
                    
                    if savedPlatform.count >= 1 {
                        
                        if checkForPlatformInLibrary(name: platformName, id: platformID) {
                            
                            let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
                            existingPlatform.addToGames(currentGame)
                            
                            
                            
                        } else {
                            savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            newPlatform.addToGames(currentGame)
                            
                        } 
                        
                        
                    }
                    
                    
                }
            }
            vc.reloadMenu()
        }
        
        
//        if let owned = game.owned {
//            if owned {
//                game.owned = false
//                button.setTitle("Add to Library", for: .normal)
//            } else {
//                game.owned = true
//                button.setTitle("Remove from Library", for: .normal)
//            }
//        }
    
        
    }
    
    func saveGameToCoreData(_ title: String,_ id: Int,_ imageData: Data,_ platformObject: PlatformObject) {
        
        let persistedGame = SavedGames(context: persistenceManager.context)
        guard let gamePlatformID = game.platformID else { return }
        let platform = fetchPlatformObject(platformID: gamePlatformID)
        let platformName = platform.name
        let platformID = platform.id
        
        
        persistedGame.title = title
        persistedGame.gameID = Int32(id)
        persistedGame.boxartImage = imageData
        persistedGame.owned = true
        persistedGame.releaseDate = game.releaseDate
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        if let releaseYear = truncatedReleaseDate {
            persistedGame.releaseYear = Int32(releaseYear)!
        }
        persistedGame.rating = game.rating
        persistedGame.developerName = game.developer
        persistedGame.platformName = platformName
        persistedGame.platformID = Int64(platformID)
        
        
        if let maxPlayers = game.maxPlayers {
            persistedGame.maxPlayers = Int64(maxPlayers)
        }
        persistedGame.genre = game.genreDescriptions
        persistedGame.genres = game.genres
        
        
        persistenceManager.save()
        getSavedGames()
        
        
        
    }
    
    func deletePlatformFromCoreData() {
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        guard let platformID = game.platformID else { return }
        
        for platform in savedPlatforms {
            if platform.id == platformID {
                persistenceManager.delete(platform)
                
            }
            
        persistenceManager.save()
            
getSavedPlatforms()
            
        }
        
        
    }
    
    func getSavedGames() {
        let savedGames = persistenceManager.fetch(SavedGames.self)
        self.savedGames = savedGames
        printSavedGames()
        
        
    }
    
    func getSavedPlatforms() {
        print("getSavedPlatforms")
        let savedPlatforms = persistenceManager.fetch(Platform.self)
        self.savedPlatforms = savedPlatforms
        printSavedPlatforms()
    }
    
    func printSavedGames() {
        
        savedGames.forEach { (game) in
            print("game core data")
            print(game.title, game.gameID)
            
        }
    }
    
    func printSavedPlatforms() {
        
        savedPlatforms.forEach{ (platform) in
            print("platform core data")
            print(platform.name, platform.id)
        }
    }
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
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
        let platform = PlatformObject(id: network.platforms["\(platformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)

        return platform
        
    }
        
    
    

    


    
//    func checkForGameInLibrary(name: String, id: Int) -> Bool {
//            print("checkforgame called")
//        let savedGames = persistenceManager.fetch(SavedGames.self)
//
//        for savedGame in savedGames {
//            if savedGame.title == name && savedGame.gameID == id {
//                return true
//            }
//        }
//
//        return false
//
//    }
//
//    func checkForPlatformInLibrary(name: String, id:Int) -> Bool {
//        print("checkforPlatform called")
//
//        let savedPlatforms = persistenceManager.fetch(Platform.self)
//
//        for platform in savedPlatforms {
//            print(platform.name, platform.id)
//            if platform.name == name && platform.id == id {
//                print("Platform \(platform.name) is in library")
//                return true
//            }
//
//        }
        
        
//        print("Platform is not in library")
//        return false
//        
//        
//        
//    }
    
}
