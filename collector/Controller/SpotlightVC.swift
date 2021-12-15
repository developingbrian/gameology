//
//  SpotlightVC.swift
//  collector
//
//  Created by Brian on 5/6/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import SDWebImage

class SpotlightVC: UIViewController {
    
    var detailVC: PagingDetailVC?
    static let sectionHeaderElementKind = "section-header-element-kind"
    var comingSoonPlatformID = 167
    var recentlyReleasedPlatformID = 167
    var top20PlatformID = 167
    let screen = UIScreen.main.bounds
    var boxartImage : UIImage?
    
    let label = UILabel()
    let refreshButton = GradientButton(gradientStartColor: .red, gradientEndColor: .orange)
    var dataFetchComplete = false
    let appearance = UINavigationBarAppearance()

    @IBOutlet weak var spinview: UIView!
    var top20MenuPlatforms : [String] {
        var platforms : [String] = []
        let currentPlatformName = fetchPlatformName(platformID: top20PlatformID)
        for platform in top20Platforms {
            //need to figure out how to set the currently selected true before here
                if platform.platformName == currentPlatformName {
                    platform.isSelected = true
                } else {
                    platform.isSelected = false
                }
            

        }
        
        for platform in top20Platforms {
            if platform.isSelected == false {
                platforms.append(platform.platformName!)
            }
        }
        platforms.sort()
        return platforms
    }
    
    
    var comingSoonMenuPlatforms: [String] {
        var platforms : [String] = []
        let currentPlatformName = fetchPlatformName(platformID: comingSoonPlatformID)

        for platform in comingSoonPlatforms {
                if platform.platformName == currentPlatformName {
                    platform.isSelected = true
                } else {
                    platform.isSelected = false
                }
            

        }
        
        for platform in comingSoonPlatforms {
            if platform.isSelected == false {
                platforms.append(platform.platformName!)
            }
        }
        platforms.sort()
        return platforms
    }
    
    var recentlyAddedMenuPlatforms: [String] {
        var platforms : [String] = []
        
        let currentPlatformName = fetchPlatformName(platformID: recentlyReleasedPlatformID)

        for platform in recentlyReleasedPlatforms {
            if platform.platformName == currentPlatformName {
                    platform.isSelected = true
            } else {
                platform.isSelected = false
            }
            

        }
        
        for platform in recentlyReleasedPlatforms {
            if platform.isSelected == false {
                platforms.append(platform.platformName!)
            }
        }
        platforms.sort()
        return platforms
        
        
    }

    var comingSoonMenuItems: [UIAction] {
//        var menuPlatforms : [String] = []
//        for platform in comingSoonPlatforms {
//            if platform.isSelected == false {
//                menuPlatforms.append(platform.platformName!)
//            }
//        }
        print("recentlyreleasedmenu", recentlyAddedMenuPlatforms)
        print("top20menu", top20MenuPlatforms)
        print("comingsoonmenu", comingSoonMenuPlatforms)
        print(comingSoonMenuPlatforms.count)
        var platformImage0 = ""
        var platformImage1 = ""
        var platformImage2 = ""
        var platformImage3 = ""

        
     
        var index = 0
        for platform in comingSoonMenuPlatforms {
            
            if platform == "XBox Series X|S" || platform == "XBox One" {
                switch index {
                case 0:
                    platformImage0 = "xboxonesymbol"
                case 1:
                    platformImage1 = "xboxonesymbol"

                case 2:
                    platformImage2 = "xboxonesymbol"

                case 3:
                    platformImage3 = "xboxonesymbol"
                default:
                    print("invalid platform")
                }

                }
            
            
            if platform == "PlayStation 5" || platform == "PlayStation 4" {
                switch index {
                case 0:
                    platformImage0 = "playstationlogo"
                case 1:
                    platformImage1 = "playstationlogo"

                case 2:
                    platformImage2 = "playstationlogo"

                case 3:
                    platformImage3 = "playstationlogo"
                default:
                    print("invalid platform")
                }

                }

            
            
            if platform == "Nintendo Switch" {
                switch index {
                case 0:
                    platformImage0 = "switchlogo"
                case 1:
                    platformImage1 = "switchlogo"

                case 2:
                    platformImage2 = "switchlogo"

                case 3:
                    platformImage3 = "switchlogo"
                default:
                    print("invalid platform")
                }

                
                }
            
            index += 1

            }
        
        
        
        
        return [
            UIAction(title: comingSoonMenuPlatforms[0], image: UIImage(named: platformImage0)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.comingSoonMenuPlatforms[0])
                
                
                self.network.fetchIGDBComingSoonData(platformID: platformID) {_ in
                        self.comingSoonGames.removeAll()
                    self.comingSoonGames = self.network.comingSoonArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.comingSoonGames[0].platformID {
                        self.comingSoonPlatformID = platformID
                    }
                    
                    for platform in self.comingSoonPlatforms {
                        
                        if platform.platformName == self.comingSoonMenuPlatforms[0] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }
                
                
            }),
            
            UIAction(title: comingSoonMenuPlatforms[1], image: UIImage(named: platformImage1)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.comingSoonMenuPlatforms[1])
                self.network.fetchIGDBComingSoonData(platformID: platformID) { error in
                    self.comingSoonGames.removeAll()

                    self.comingSoonGames = self.network.comingSoonArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.comingSoonGames[0].platformID {
                        self.comingSoonPlatformID = platformID
                    }
                    
                    for platform in self.comingSoonPlatforms {
                        
                        if platform.platformName == self.comingSoonMenuPlatforms[1] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            }),
            UIAction(title: comingSoonMenuPlatforms[2], image: UIImage(named: platformImage2)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.comingSoonMenuPlatforms[2])
                self.network.fetchIGDBComingSoonData(platformID: platformID) { error in
                    self.comingSoonGames.removeAll()

                    self.comingSoonGames = self.network.comingSoonArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.comingSoonGames[0].platformID {
                        self.comingSoonPlatformID = platformID
                    }
                    
                    for platform in self.comingSoonPlatforms {
                        
                        if platform.platformName == self.comingSoonMenuPlatforms[2] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            }),
            UIAction(title: comingSoonMenuPlatforms[3], image: UIImage(named: platformImage3)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.comingSoonMenuPlatforms[3])
                self.network.fetchIGDBComingSoonData(platformID: platformID) { error in
                    self.comingSoonGames.removeAll()

                    self.comingSoonGames = self.network.comingSoonArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.comingSoonGames[0].platformID {
                        self.comingSoonPlatformID = platformID
                    }
                    
                    for platform in self.comingSoonPlatforms {
                        
                        if platform.platformName == self.comingSoonMenuPlatforms[3] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            })
        ]
    }
    

    
    
    var comingSoonMenu: UIMenu {
        return UIMenu(title: "Change Platform", image: nil, identifier: nil, options: [], children: comingSoonMenuItems)
    }
    
    var recentlyReleasedMenuItems: [UIAction] {
//        var menuPlatforms : [String] = []
//        for platform in recentlyReleasedPlatforms {
//            if platform.isSelected == false {
//                menuPlatforms.append(platform.platformName!)
//            }
//        }
        
        
        var platformImage0 = ""
        var platformImage1 = ""
        var platformImage2 = ""
        var platformImage3 = ""

        
     
        var index = 0
        for platform in recentlyAddedMenuPlatforms {
            
            if platform == "XBox Series X|S" || platform == "XBox One" {
                switch index {
                case 0:
                    platformImage0 = "xboxonesymbol"
                case 1:
                    platformImage1 = "xboxonesymbol"

                case 2:
                    platformImage2 = "xboxonesymbol"

                case 3:
                    platformImage3 = "xboxonesymbol"
                default:
                    print("invalid platform")
                }

                }
            
            
            if platform == "PlayStation 5" || platform == "PlayStation 4" {
                switch index {
                case 0:
                    platformImage0 = "playstationlogo"
                case 1:
                    platformImage1 = "playstationlogo"

                case 2:
                    platformImage2 = "playstationlogo"

                case 3:
                    platformImage3 = "playstationlogo"
                default:
                    print("invalid platform")
                }

                }

            
            
            if platform == "Nintendo Switch" {
                switch index {
                case 0:
                    platformImage0 = "switchlogo"
                case 1:
                    platformImage1 = "switchlogo"

                case 2:
                    platformImage2 = "switchlogo"

                case 3:
                    platformImage3 = "switchlogo"
                default:
                    print("invalid platform")
                }

                
                }
            
            index += 1

            }
        
        return [
            UIAction(title: recentlyAddedMenuPlatforms[0], image: UIImage(named: platformImage0)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.recentlyAddedMenuPlatforms[0])
                
                
                self.network.fetchIGDBRecentlyReleasedData(platformID: platformID) { error in
                    self.recentlyReleasedGames.removeAll()
                    self.recentlyReleasedGames = self.network.recentlyReleasedArray
                    print("reloading recently released games")
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.recentlyReleasedGames[0].platformID {
                        self.recentlyReleasedPlatformID = platformID
                    }
                    
                    for platform in self.recentlyReleasedPlatforms {
                        
                        if platform.platformName == self.recentlyAddedMenuPlatforms[0] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }
                
            }),
            UIAction(title: recentlyAddedMenuPlatforms[1], image: UIImage(named: platformImage1)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.recentlyAddedMenuPlatforms[1])
                self.network.fetchIGDBRecentlyReleasedData(platformID: platformID) { error in
                    self.recentlyReleasedGames.removeAll()

                    self.recentlyReleasedGames = self.network.recentlyReleasedArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.recentlyReleasedGames[0].platformID {
                        self.recentlyReleasedPlatformID = platformID
                    }
                    
                    for platform in self.recentlyReleasedPlatforms {
                        
                        if platform.platformName == self.recentlyAddedMenuPlatforms[1] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            }),
            UIAction(title: recentlyAddedMenuPlatforms[2], image: UIImage(named: platformImage2)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.recentlyAddedMenuPlatforms[2])
                self.network.fetchIGDBRecentlyReleasedData(platformID: platformID) { error in
                    self.recentlyReleasedGames.removeAll()

                    self.recentlyReleasedGames = self.network.recentlyReleasedArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.recentlyReleasedGames[0].platformID {
                        self.recentlyReleasedPlatformID = platformID
                    }
                    
                    for platform in self.recentlyReleasedPlatforms {
                        
                        if platform.platformName == self.recentlyAddedMenuPlatforms[2] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            }),
            UIAction(title: recentlyAddedMenuPlatforms[3], image: UIImage(named: platformImage3)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.recentlyAddedMenuPlatforms[3])
                self.network.fetchIGDBRecentlyReleasedData(platformID: platformID) { error in
                    self.recentlyReleasedGames.removeAll()

                    self.recentlyReleasedGames = self.network.recentlyReleasedArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.recentlyReleasedGames[0].platformID {
                        self.recentlyReleasedPlatformID = platformID
                    }
                    
                    for platform in self.recentlyReleasedPlatforms {
                        
                        if platform.platformName == self.recentlyAddedMenuPlatforms[3] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            })
        ]
    }
    

    
    
    var recentlyReleasedMenu: UIMenu {
        return UIMenu(title: "Change Platform", image: nil, identifier: nil, options: [], children: recentlyReleasedMenuItems)
    }
    
    
    var top20MenuItems: [UIAction] {
        
        
        var platformImage0 = ""
        var platformImage1 = ""
        var platformImage2 = ""
        var platformImage3 = ""

        
     
        var index = 0
        for platform in top20MenuPlatforms {
            
            if platform == "XBox Series X|S" || platform == "XBox One" {
                switch index {
                case 0:
                    platformImage0 = "xboxonesymbol"
                case 1:
                    platformImage1 = "xboxonesymbol"

                case 2:
                    platformImage2 = "xboxonesymbol"

                case 3:
                    platformImage3 = "xboxonesymbol"
                default:
                    print("invalid platform")
                }

                }
            
            
            if platform == "PlayStation 5" || platform == "PlayStation 4" {
                switch index {
                case 0:
                    platformImage0 = "playstationlogo"
                case 1:
                    platformImage1 = "playstationlogo"

                case 2:
                    platformImage2 = "playstationlogo"

                case 3:
                    platformImage3 = "playstationlogo"
                default:
                    print("invalid platform")
                }

                }

            
            
            if platform == "Nintendo Switch" {
                switch index {
                case 0:
                    platformImage0 = "switchlogo"
                case 1:
                    platformImage1 = "switchlogo"

                case 2:
                    platformImage2 = "switchlogo"

                case 3:
                    platformImage3 = "switchlogo"
                default:
                    print("invalid platform")
                }

                
                }
            
            index += 1

            }

        
        return [
            UIAction(title: top20MenuPlatforms[0], image: UIImage(named: platformImage0)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.top20MenuPlatforms[0])
                self.network.fetchIGDBTop20Data(platformID: platformID) { error in
                    self.topTwentyGames.removeAll()
                    self.topTwentyGames = self.network.topTwentyArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.topTwentyGames[0].platformID {
                        self.top20PlatformID = platformID
                    }
                    
                    for platform in self.top20Platforms {
                        
                        if platform.platformName == self.top20MenuPlatforms[0] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }
            }),
            UIAction(title: top20MenuPlatforms[1], image: UIImage(named: platformImage1)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.top20MenuPlatforms[1])
                self.network.fetchIGDBTop20Data(platformID: platformID) { error in
                    self.topTwentyGames.removeAll()

                    self.topTwentyGames = self.network.topTwentyArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.topTwentyGames[0].platformID {
                        self.top20PlatformID = platformID
                    }
                    
                    for platform in self.top20Platforms {
                        
                        if platform.platformName == self.top20MenuPlatforms[1] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            }),
            UIAction(title: top20MenuPlatforms[2], image: UIImage(named: platformImage2)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.top20MenuPlatforms[2])
                self.network.fetchIGDBTop20Data(platformID: platformID) { error in
                    self.topTwentyGames.removeAll()

                    self.topTwentyGames = self.network.topTwentyArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.topTwentyGames[0].platformID {
                        self.top20PlatformID = platformID
                    }
                    
                    for platform in self.top20Platforms {
                        
                        if platform.platformName == self.top20MenuPlatforms[2] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            }),
            UIAction(title: self.top20MenuPlatforms[3], image: UIImage(named: platformImage3)?.withTintColor(.label), handler: { (_) in
                print("button pressed")
                let platformID = self.fetchPlatformID(platformName: self.top20MenuPlatforms[3])
                self.network.fetchIGDBTop20Data(platformID: platformID) { error in
                    self.topTwentyGames.removeAll()

                    self.topTwentyGames = self.network.topTwentyArray
                    self.spotlightCollectionView.reloadData()
                    if let platformID = self.topTwentyGames[0].platformID {
                        self.top20PlatformID = platformID
                    }
                    
                    for platform in self.top20Platforms {
                        
                        if platform.platformName == self.top20MenuPlatforms[3] {
                            platform.isSelected = true
                        } else {
                            platform.isSelected = false
                        }
                        
                    }
                }

            })
        ]
    }
    

    
    
    var top20Menu: UIMenu {
        return UIMenu(title: "Change Platform", image: nil, identifier: nil, options: [], children: top20MenuItems)
    }
    
    let platformNames = ["PlayStation 4", "PlayStation 5", "XBox One", "XBox Series X|S", "Nintendo Switch"]
    
    class Platforms {
        var platformName : String?
        var isSelected : Bool?
    }
    
    var comingSoonPlatforms : [Platforms] = []
    var recentlyReleasedPlatforms : [Platforms] = []
    var top20Platforms : [Platforms] = []
    
    
    
    public enum SpotlightSection: String, CaseIterable {
       case comingSoon = "Games Coming Soon"
       case recentlyReleased = "Recently Released Games"
       case top20 = "Top 20 Games"
    }

    @IBOutlet weak var spotlightCollectionView: UICollectionView!
    var comingSoonGames : [GameObject] = []
    var recentlyReleasedGames : [GameObject] = []
    var topTwentyGames: [GameObject] = []
    let network = Networking.shared
    
    
    override func viewWillDisappear(_ animated: Bool) {
        clearImageCacheFromMemory()
    }
    
    override func didReceiveMemoryWarning() {
        clearImageCacheFromMemory()
    }
    
    func clearImageCacheFromMemory() {
        let imageCache = SDImageCache.shared
        imageCache.clearMemory()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        setAppearance()
        comingSoonPlatforms.removeAll()
        recentlyReleasedPlatforms.removeAll()
        top20Platforms.removeAll()


        for platformName in platformNames {

            let platform = Platforms()
            platform.platformName = platformName
            platform.isSelected = false
            comingSoonPlatforms.append(platform)
            recentlyReleasedPlatforms.append(platform)
            top20Platforms.append(platform)
        }
        
        registerVC()

//        spotlightCollectionView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        setupLabel()
        self.navigationController?.navigationBar.isTranslucent = false
      
        

        spotlightCollectionView.collectionViewLayout = setupCollectionViewLayout()

        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
        var top20MenuPlatforms : [String] = []
        for platform in top20Platforms {
            if platform.isSelected == false {
                top20MenuPlatforms.append(platform.platformName!)
            }
        }
        

        
        spotlightCollectionView.dataSource = self
        spotlightCollectionView.delegate = self
        spotlightCollectionView.register(ComingSoonCell.self, forCellWithReuseIdentifier: ComingSoonCell.cellIdentifier)
        spotlightCollectionView.register(NewReleasesCell.self, forCellWithReuseIdentifier: NewReleasesCell.cellIdentifier)
        spotlightCollectionView.register(TopTwentyCell.self, forCellWithReuseIdentifier: TopTwentyCell.cellIdentifier)
        spotlightCollectionView.register(SpotlightHeaderView.self, forSupplementaryViewOfKind: SpotlightVC.sectionHeaderElementKind, withReuseIdentifier: SpotlightHeaderView.reuseIdentifier)

        
        altPrepareData()
//        prepareData()
//        spinview.isHidden = false
//        self.showSpinner(onView: spinview, userInterfaceStyle: traitCollection.userInterfaceStyle)
//        tabBarController?.view.isUserInteractionEnabled = false
//
//        while dataFetchComplete == false {
//            print("dataFetchComplete = ", dataFetchComplete)
//            if network.genreFetchSuccess == true && network.platformFetchSuccess == true && network.gameFetchSuccess == true {
//                
//                dataFetchComplete = true
//                tabBarController?.view.isUserInteractionEnabled = true
//                removeSpinner()
//
//            }
//            
//        }
    }
    

    func altPrepareData() {
        if network.comingSoonArray.count > 0 {
            comingSoonGames = network.comingSoonArray
            if let platformID = self.comingSoonGames[0].platformID {
                self.comingSoonPlatformID = platformID
            }
            print("coming soon games", comingSoonGames)
        }
        
        if network.topTwentyArray.count > 0 {
            topTwentyGames = network.topTwentyArray
            if let platformID = self.topTwentyGames[0].platformID {
                self.top20PlatformID = platformID
            }
        }
        
        if network.recentlyReleasedArray.count > 0 {
            
            recentlyReleasedGames = network.recentlyReleasedArray
            if let platformID = self.recentlyReleasedGames[0].platformID {
                self.recentlyReleasedPlatformID = platformID
        }
        }
        spotlightCollectionView.isHidden = false
        spotlightCollectionView.reloadData()
        
    }
    
    func prepareData() {
//        let priceObject = network.scrapePriceCharting(platformID: 48, gameName: "grand-theft-auto-v", uneditedGameName: "Grand Theft Auto V")
//        print("priceObject is", priceObject.title, priceObject.loosePrice, priceObject.cibPrice, priceObject.newPrice)
        
        label.isHidden = true
        refreshButton.isHidden = true
        spotlightCollectionView.isHidden = false
        
        spinview.isHidden = false
        
        tabBarController?.view.isUserInteractionEnabled = false
        print("user interface style", traitCollection.userInterfaceStyle.rawValue)
        self.showSpinner(onView: spinview, userInterfaceStyle: traitCollection.userInterfaceStyle)
//        self.showSpinner(onView: self.spinview)
        let platformIDS = [48, 49, 130, 167, 169]
        
        
            self.label.isHidden = true
            self.spotlightCollectionView.isHidden = false
            let randomPlatformIDComingSoon = platformIDS.randomElement()
            self.network.fetchIGDBComingSoonData(platformID: randomPlatformIDComingSoon!) { error in
                if error == nil {
                self.comingSoonGames = self.network.comingSoonArray
                self.spotlightCollectionView.reloadData()
                if let platformID = self.comingSoonGames[0].platformID {
                    self.comingSoonPlatformID = platformID
                }
                    
           
                    
                } else {
                    self.spotlightCollectionView.isHidden = true
                    self.label.isHidden = false
                    self.refreshButton.isHidden = false

                    self.removeSpinner()
                    self.spinview.isHidden = true
                    self.tabBarController?.view.isUserInteractionEnabled = true

                }
            }
        
                let randomPlatformIDRecentlyReleased = platformIDS.randomElement()
                self.network.fetchIGDBRecentlyReleasedData(platformID: randomPlatformIDRecentlyReleased!) { error in
                    if error == nil {
                        print("recently released data")
                        self.recentlyReleasedGames = self.network.recentlyReleasedArray
                        self.spotlightCollectionView.reloadData()
                        if let platformID = self.recentlyReleasedGames[0].platformID {
                            self.recentlyReleasedPlatformID = platformID
                    }
                        
                        
                    } else {
                        self.spotlightCollectionView.isHidden = true
                        self.label.isHidden = false
                        self.refreshButton.isHidden = false

                        self.removeSpinner()
                        self.spinview.isHidden = true
                        self.tabBarController?.view.isUserInteractionEnabled = true

                        
                    }
                }
                    
                

                            let randomPlatformIDTop20 = platformIDS.randomElement()
                            self.network.fetchIGDBTop20Data(platformID: randomPlatformIDTop20!) { error in
                                if error == nil {
                                print("top20 fetched")
                                self.topTwentyGames = self.network.topTwentyArray
                                self.spotlightCollectionView.reloadData()
                                if let platformID = self.topTwentyGames[0].platformID {
                                    self.top20PlatformID = platformID
                                }
                                    
                                } else {
                                    self.spotlightCollectionView.isHidden = true
                                    self.label.isHidden = false
                                    self.refreshButton.isHidden = false
                                    self.removeSpinner()
                                    self.spinview.isHidden = true
                                    self.tabBarController?.view.isUserInteractionEnabled = true
                                    
                                    
                                }
                            }
        
                            
//
//
//                        } else {
//                            self.spotlightCollectionView.isHidden = true
//                            self.label.isHidden = false
//                            self.refreshButton.isHidden = false
//
//                            self.removeSpinner()
//                            self.spinview.isHidden = true
//                            self.tabBarController?.view.isUserInteractionEnabled = true
//                        }
//
//
//                    }
//
//                } else {
//                    self.spotlightCollectionView.isHidden = true
//                    self.label.isHidden = false
//                    self.refreshButton.isHidden = false
//
//                    self.removeSpinner()
//                    self.spinview.isHidden = true
//                    self.tabBarController?.view.isUserInteractionEnabled = true
//                }
                
       
                    

                        
                
                        
                 
                        
                        
                     
                    
                    

                
        
        self.network.fetchIGDBGenreData { error in
//            print("attempting to fetch genre data")
            if error == nil {
//            print("success fetching genre data")
            
                self.network.fetchIGDBPlatformData { error in
//            UserDefaults.standard.setValue(nil, forKey: "lastFetchedPlatform")
            if error == nil {
                 var lastFetchedPlatform = UserDefaults.standard.value(forKey: "lastFetchedPlatform")
                if lastFetchedPlatform == nil {
                    UserDefaults.standard.setValue(18, forKey: "lastFetchedPlatform")
                    lastFetchedPlatform = 18
                }
//                let currentPlatform = UserDefaults.standard.integer(forKey:"lastFetchedPlatform")
//                print("user defaults current platform ", lastFetchedPlatform)
                self.network.lastRequestedPlatformID = lastFetchedPlatform as! Int
                
                self.network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: self.network.lastRequestedPlatformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: self.network.currentOffset, resultsPerPage: 500, completed: { error in
                
//                print("error is", error)
                
                if error == nil {
                    
                    if self.network.initialFetchComplete == true {
                        
//                        print("all data downloaded")
                        self.network.currentOffset += 500
//                        self.network.currentOffset = self.network.gameArray.count
                        self.removeSpinner()
                        self.spinview.isHidden = true
                        self.tabBarController?.view.isUserInteractionEnabled = true
                    }
                
                }
                        
                    else {
                        self.network.genreFetchDidFail = false
                        self.network.platformFetchDidFail = false
                        self.network.gameFetchDidFail = true
                    self.label.isHidden = false
                    self.spotlightCollectionView.isHidden = true
                        self.refreshButton.isHidden = false

                    self.removeSpinner()
                    self.spinview.isHidden = true
                    self.tabBarController?.view.isUserInteractionEnabled = true
                }
                
    

                })
            } else {
                self.network.genreFetchDidFail = false
                self.network.platformFetchDidFail = true
                self.network.gameFetchDidFail = true
                self.label.isHidden = false
                self.spotlightCollectionView.isHidden = true
                    self.refreshButton.isHidden = false

                self.removeSpinner()
                self.spinview.isHidden = true
                self.tabBarController?.view.isUserInteractionEnabled = true
                
                
            }
        }
        
            } else {
                
//                print("error is", error)
                self.network.genreFetchDidFail = true
                self.network.platformFetchDidFail = true
                self.network.gameFetchDidFail = true
                self.label.isHidden = false
                self.spotlightCollectionView.isHidden = true
                    self.refreshButton.isHidden = false

                self.removeSpinner()
                self.spinview.isHidden = true
                self.tabBarController?.view.isUserInteractionEnabled = true
                
                
            }
            
        }
        
        
    }
    
    func fetchPlatformName(platformID: Int) -> String {
        switch platformID {
        
        case 167:
            return "PlayStation 5"
        
        case 48:
            return "PlayStation 4"
        case 49:
            return "XBox One"
        case 169:
            return "XBox Series X|S"
        case 130:
            return "Nintendo Switch"
        default:
            return ""
        }
        
    }
    
    func fetchPlatformID(platformName: String) -> Int {
        switch platformName {
        case "PlayStation 5":
            return 167
        case "PlayStation 4":
            
            return 48
        case "XBox One":
            return 49
            
        case "XBox Series X|S":
            return 169
            
        case "Nintendo Switch":
            return 130
            
        default:
            return 0
        }
        
        
    }
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let spotlightSections = SpotlightSection.allCases[sectionIndex]
            
            switch spotlightSections {
            
            case .comingSoon:
                return self.createComingSoonGamesSection()
            case .recentlyReleased:
                return self.createRecentlyReleasedSection()
            case .top20:
                return self.createTop20Section()
            
            }
        }

       return layout
    }
    
    fileprivate func createComingSoonGamesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
        var groupSize : NSCollectionLayoutSize?
        let frame = self.view.safeAreaLayoutGuide.layoutFrame
        if self.view.frame.width > 429 {
            groupSize = NSCollectionLayoutSize(widthDimension: .absolute(frame.width / 3), heightDimension: .absolute(250))
        } else {
            
            groupSize = NSCollectionLayoutSize(widthDimension: .absolute(frame.width / 2), heightDimension: .absolute(250))
            
        }
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize!, subitem: item, count: 1)
       group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
       
       let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
       heightDimension: .estimated(44))
       let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SpotlightVC.sectionHeaderElementKind, alignment: .top)
       
       let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
       section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
       return section
    }
    
    
    fileprivate func createRecentlyReleasedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
        var groupSize : NSCollectionLayoutSize?
        if self.view.frame.width > 429 {
            let frame = self.view.safeAreaLayoutGuide.layoutFrame
            groupSize = NSCollectionLayoutSize(widthDimension: .absolute(frame.width / 2), heightDimension: .absolute(250))
        } else {
            groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(250))
        }
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize!, subitem: item, count: 1)
       group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
       
       let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
       heightDimension: .estimated(44))
       let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SpotlightVC.sectionHeaderElementKind, alignment: .top)
       
       let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
       section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
       return section
    }
    
    fileprivate func createTop20Section() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(100))
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
       group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
       
       let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
       heightDimension: .estimated(44))
       let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SpotlightVC.sectionHeaderElementKind, alignment: .top)
       
       let section = NSCollectionLayoutSection(group: group)
       section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
       return section
    }
    
    
    func registerVC() {
        
        if let detailViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "paging") as? PagingDetailVC {
            detailVC = detailViewController
        } else {
            print("Can't load VC. Check name")
        }
        
    }
    
    @objc func refreshButtonPressed() {

        print("refresh pressed")
        prepareData()
    }
    
    
    func setupLabel() {
       
        let darkBlue = UIColorFromRGB(0x2ECAD5)
        let blue = UIColorFromRGB(0x2B95CE)
//        let colors = [blue.cgColor, darkBlue.cgColor]
        view.addSubview(label)
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
//        refreshButton.layer.masksToBounds = true
        refreshButton.clipsToBounds = true
        refreshButton.gradientStartColor = darkBlue
        refreshButton.gradientEndColor = blue
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.layer.cornerRadius = 10
//        refreshButton.backgroundColor = .red

//        refreshButton.applyGradientRounded(layoutIfNeeded: false, colors: colors )
//        refreshButton.applyGradient(colors: [blue.cgColor, darkBlue.cgColor])
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
//        gradientLayer.frame = refreshButton.bounds
//        refreshButton.layer.insertSublayer(gradientLayer, at: 0)
//        refreshButton.layer.insertSublayer(gradientLayer, above: refreshButton.imageView?.layer)
        refreshButton.isHidden = true
        refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        
                spotlightCollectionView.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OH Dang....Something went wrong."
        label.textColor = .label
//        label.backgroundColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        
        NSLayoutConstraint.activate(
        [
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            label.topAnchor.constraint(equalTo: view.topAnchor),
//            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            refreshButton.topAnchor.constraint(equalTo: label.bottomAnchor),
            refreshButton.widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 0.5),
            refreshButton.heightAnchor.constraint(equalToConstant: 50),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
            
        )
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
        
        let firstSection = IndexPath(row: 0, section: 0)
        let secondSection = IndexPath(row: 0, section: 1)
        let thirdSection = IndexPath(row: 0, section: 2)
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            spotlightCollectionView.backgroundColor = lightGray
            self.view.backgroundColor = lightGray
            navigationController?.view.backgroundColor = .white
            if let comingSoonHeader = spotlightCollectionView.supplementaryView(forElementKind: SpotlightVC.sectionHeaderElementKind, at: firstSection) as? SpotlightHeaderView {
                comingSoonHeader.backgroundColor = lightGray
            }
            
            if let newReleasesHeader = spotlightCollectionView.supplementaryView(forElementKind: SpotlightVC.sectionHeaderElementKind, at: secondSection) as? SpotlightHeaderView {
                newReleasesHeader.backgroundColor = lightGray
            }
            
            if let top20Header = spotlightCollectionView.supplementaryView(forElementKind: SpotlightVC.sectionHeaderElementKind, at: thirdSection) as? SpotlightHeaderView {
                top20Header.backgroundColor = lightGray
            }
//            navigationController?.navigationBar.backgroundColor = .white
            

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            spotlightCollectionView.backgroundColor = darkGray
            self.view.backgroundColor = darkGray
            navigationController?.view.backgroundColor = .black
            
            if let comingSoonHeader = spotlightCollectionView.supplementaryView(forElementKind: SpotlightVC.sectionHeaderElementKind, at: firstSection) as? SpotlightHeaderView {
                comingSoonHeader.backgroundColor = darkGray
            }
            
            if let newReleasesHeader = spotlightCollectionView.supplementaryView(forElementKind: SpotlightVC.sectionHeaderElementKind, at: secondSection) as? SpotlightHeaderView {
                newReleasesHeader.backgroundColor = darkGray
            }
            
            if let top20Header = spotlightCollectionView.supplementaryView(forElementKind: SpotlightVC.sectionHeaderElementKind, at: thirdSection) as? SpotlightHeaderView {
                top20Header.backgroundColor = darkGray
            }
//            navigationController?.navigationBar.backgroundColor = .black
            
        }
    }
    
    
}

extension SpotlightVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.detailVC else {
            print("something wrong")
            return
        }
        
        let spotlightSections = SpotlightSection.allCases[indexPath.section]
        
        print("sections", indexPath.section)
        
        switch spotlightSections {
        case .comingSoon:
            let cell = collectionView.cellForItem(at: indexPath) as? ComingSoonCell
            viewController.game = comingSoonGames[indexPath.item]
            viewController.boxartImage = cell?.imageView.image
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)

            }
        case .recentlyReleased:
            let cell = collectionView.cellForItem(at: indexPath) as? NewReleasesCell

            viewController.game = recentlyReleasedGames[indexPath.item]
            viewController.boxartImage = cell?.boxartImageView.image
            print("gameitem", viewController.game)
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)

            }

        case .top20:
            let cell = collectionView.cellForItem(at: indexPath) as? TopTwentyCell
            viewController.game = topTwentyGames[indexPath.item]
            viewController.boxartImage = cell?.imageView.image
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)

            }

        }
        
        
    }
    
    
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
           ofKind: kind,
           withReuseIdentifier: SpotlightHeaderView.reuseIdentifier,
           for: indexPath) as? SpotlightHeaderView else { fatalError("Cannot create header view") }
        var platform = ""
        let spotlightSections = SpotlightSection.allCases[indexPath.section]
        switch spotlightSections {
        case .comingSoon:
            platform = fetchPlatformName(platformID: comingSoonPlatformID)
            
            for comingSoonPlatform in comingSoonPlatforms {
                if comingSoonPlatform.platformName! == platform{
                    comingSoonPlatform.isSelected = true
                } else {
                    comingSoonPlatform.isSelected = false
                }
                
                    
                supplementaryView.button.menu = comingSoonMenu
                supplementaryView.button.showsMenuAsPrimaryAction = true
                
            }
            
        case .recentlyReleased:
            platform = fetchPlatformName(platformID: recentlyReleasedPlatformID)
            print("platform is", platform)
            for recentlyReleasePlatform in recentlyReleasedPlatforms {
                if recentlyReleasePlatform.platformName! == platform {
                    recentlyReleasePlatform.isSelected = true
                } else {
                    recentlyReleasePlatform.isSelected = false
                }
                
                print("button width",supplementaryView.button.frame.width)
                print("button height",supplementaryView.button.frame.height)
                
                    
                supplementaryView.button.menu = recentlyReleasedMenu
                supplementaryView.button.showsMenuAsPrimaryAction = true
                
            }
        case .top20:
            platform = fetchPlatformName(platformID: top20PlatformID)
            
            for top20Platform in top20Platforms {
                if top20Platform.platformName! == platform {
                    top20Platform.isSelected = true
                } else {
                    top20Platform.isSelected = false
                }
            }
            
                
            supplementaryView.button.menu = top20Menu
            supplementaryView.button.showsMenuAsPrimaryAction = true
            
            
        }
         
        

        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            supplementaryView.backgroundColor = lightGray

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            supplementaryView.backgroundColor = darkGray


        }
//        if #available(iOS 14.0, *) {
//
//        supplementaryView.button.menu = comingSoonMenu
//            supplementaryView.button.showsMenuAsPrimaryAction = true
//        }
        print("sections", indexPath.section)
         supplementaryView.label.text = SpotlightSection.allCases[indexPath.section].rawValue
        supplementaryView.platformLabel.text = platform
        supplementaryView.button.setTitle("Platform", for: .normal)
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let darkBlue = UIColorFromRGB(0x2ECAD5)
        
        supplementaryView.button.applyGradientRounded(layoutIfNeeded: false, colors: [darkBlue.cgColor, lightBlue.cgColor])
         return supplementaryView

      }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let spotlightSections = SpotlightSection.allCases[section]
        
        switch spotlightSections {
        case .comingSoon:
            return comingSoonGames.count

        case .recentlyReleased:
            print("recentlyReleased", recentlyReleasedGames.count)
            return recentlyReleasedGames.count
        case .top20:
           return topTwentyGames.count
        }
      
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let spotlightSections = SpotlightSection.allCases[indexPath.section]
        
        switch spotlightSections {
        case .comingSoon:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingSoonCell.cellIdentifier, for: indexPath) as? ComingSoonCell else {
                return ComingSoonCell()
            }
            cell.game = comingSoonGames[indexPath.item]
//            print("cell.boxartimage", cell.boxartImage)
            boxartImage = cell.boxartImage
            return cell

        case .recentlyReleased:
            print("recently released cell")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleasesCell.cellIdentifier, for: indexPath) as? NewReleasesCell else {
                return NewReleasesCell()
            }
            cell.game = recentlyReleasedGames[indexPath.item]
            
            return cell
            
        case .top20:
            print("recently released cell")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTwentyCell.cellIdentifier, for: indexPath) as? TopTwentyCell else {
                return TopTwentyCell()
            }
            cell.game = topTwentyGames[indexPath.item]
            
            return cell
            
            
        }
        
        

        
    }
    
    
    
    
}
