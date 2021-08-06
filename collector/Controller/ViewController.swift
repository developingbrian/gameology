//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import DropDown




class ViewController: UIViewController, ViewControllerTableViewCellDelegate, NetworkingDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var platformPicker: UIPickerView!
    @IBOutlet weak var tableviewPlatformImage: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var dropDownView: UIButton!

    let network = Networking.shared
    var wishList : [WishList] = [WishList]()

    var savedGames: [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGenres: [GameGenre] = [GameGenre]()
    let persistenceManager = PersistenceManager.shared
    static var savedGameIndex: IndexPath = [0,0]
    static var savedGame = GameObject()
    static var selectedGameIndex : IndexPath = IndexPath(row: 0, section: 0)
    var gameArray : [GameObject]?
    var segueObject : GameObject?
    var boxartImage : UIImage?
    let dropDown = DropDown()
    var platformsToFilter : [Int] = []
    var currentPlatformID = 18
    var currentPlatformName = ""
    let search = UISearchController(searchResultsController: nil)
    let platforms = ["3DO Interactive Multiplayer", "Amiga CD32", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", "Atari Lynx", "ColecoVision", "Fairchild Channel F", "Intellivision", "Magnavox Odyssey", "Microsoft Xbox", "Microsoft Xbox 360", "Microsoft Xbox One", "Microsoft Xbox Series S|X", "Neo Geo AES", "Neo Geo CD", "Neo Geo Pocket", "Neo Geo Pocket Color", "Nintendo Game & Watch", "Nintendo Entertainment System (NES)", "Super Nintendo Entertainment System (SNES)", "Nintendo Virtual Boy", "Nintendo 64", "Nintendo GameCube", "Nintendo Wii", "Nintendo Wii U", "Nintendo Switch", "Nintendo Game Boy", "Nintendo Game Boy Advance", "Nintendo DS", "Nintendo DSi", "Nintendo 3DS", "New Nintendo 3DS", "Nintendo Pokémon Mini", "Nokia N-Gage", "Nuon", "TurboGrafx-16/PC Engine", "PC Engine SuperGrafx","Philips CD-i", "Sega SG-1000", "Sega Master System", "Sega Genesis/Mega Drive", "Sega CD", "Sega 32X", "Sega Saturn", "Sega Dreamcast", "Sega Game Gear", "Sega Pico", "Sony PlayStation", "Sony PlayStation 2", "Sony PlayStation 3", "Sony PlayStation 4", "Sony PlayStation 5", "Sony PlayStation Portable (PSP)", "Sony PlayStation Vita", "Vectrex", "WonderSwan", "WonderSwan Color", "Zeebo"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dropDown.reloadAllComponents()
        
        if gameArray == nil {
            if network.gameArray.count != 0 {
            gameArray = network.gameArray
//            print("gamearray counting", gameArray?.count)
            self.tableView.reloadData()

            }
        }
        if let games = gameArray {
        if games.count > 0  {
            if let platformID = gameArray?[0].platformID {
            currentPlatformID = platformID
            }
            currentPlatformName = convertPlatformIDToName(PlatformID: currentPlatformID)
            print("current platform is", currentPlatformName)
            search.searchBar.placeholder = "Search within \(currentPlatformName)"
            
            
        }
        }

        self.tableView.reloadData()
        updateWithOwnedGames()
        setAppearance()


        search.definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        dropDown.width = dropDownView.frame.width
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        print("app started")
        
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
                self.tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "loadingCellID")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.autoresizingMask = .flexibleWidth
        network.delegate = self

        setAppearance()
        prepareData()
        configureDropDownMenu()
        configureSearchBar()
        createAppIcon()


        
    }
    
    
    
    
    
    func createAppIcon() {
        
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }
    
    
    func configureSearchBar() {
        
        search.searchResultsUpdater = self
//        search.delegate = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.showsBookmarkButton = false
        search.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .bookmark, state: .normal)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
        
    }
    
    
    func prepareData() {
        
        if network.gameArray.count != 0 {
            
            self.gameArray = self.network.gameArray
            let platformImage = self.setPlatformIcon(platformID: self.gameArray?[0].platformID, mode: self.traitCollection.userInterfaceStyle)
            self.tableviewPlatformImage.image = UIImage(named: platformImage)
            self.tableView.reloadData()
            


        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepare for segue")
        
        if let destination = segue.destination as? PagingDetailVC {
            destination.game = segueObject!
//            if let image = boxartImage {
//                print("seguing image")
//                destination.boxartImage = image
//            }
            print("destination.game \(destination.game)")
        }
    
    }

    
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height


        if offsetY > (contentHeight - scrollView.frame.size.height * 4) {

            if network.fetchingMore == false {
                print("end of results")
                
                if network.endOfResults == false {
                    beginBatchFetch()
                }
            }
        }
    }
    
    
    
    func beginBatchFetch() {
        network.fetchingMore = true
        print("fetching data")
        print("fetching more \(network.fetchingMore)")
//        print(currentOffset)
        DispatchQueue.global(qos: .userInitiated).async{
            
            print("offset before fetch \(self.network.currentOffset)")
            let platformID = self.network.gameArray[0].platformID
            
            if self.network.searchIsActive == false {
                //search is not active
            self.network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: platformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: self.network.currentOffset, resultsPerPage: 20) {
  
            
            if self.network.currentOffset < self.network.gameArray.count {
            self.gameArray = self.network.gameArray
            self.network.currentOffset = self.network.gameArray.count
                print("offset after fetch = \(self.network.currentOffset)")
                self.network.fetchingMore = false
                print("fetching more \(self.network.fetchingMore)")
                self.tableView.reloadData()
            }
        }
            } else {
                //search is active
                if self.platformsToFilter.count > 0 {
                    
                    
                    self.network.fetchIGDBGamesData(filterBy: self.network.searchFilter, platformID: nil, searchByName: self.network.searchText, sortByField: nil, sortAscending: nil, offset: self.network.currentOffset, resultsPerPage: 20) {
                        if self.network.currentOffset < self.network.gameArray.count {
                        self.gameArray = self.network.gameArray
                        self.network.currentOffset = self.network.gameArray.count
                            print("offset after fetch = \(self.network.currentOffset)")
                            self.network.fetchingMore = false
                            print("fetching more \(self.network.fetchingMore)")
                            self.tableView.reloadData()
                        }
                        
                        
                    }
                    
                } else {
                    
                    
                    self.network.fetchIGDBGamesData(filterBy: nil, platformID: nil, searchByName: self.network.searchText, sortByField: nil, sortAscending: nil, offset: self.network.currentOffset, resultsPerPage: 20) {
                        if self.network.currentOffset < self.network.gameArray.count {
                        self.gameArray = self.network.gameArray
                        self.network.currentOffset = self.network.gameArray.count
                            print("offset after fetch = \(self.network.currentOffset)")
                            self.network.fetchingMore = false
                            print("fetching more \(self.network.fetchingMore)")
                            self.tableView.reloadData()
                        }
                        
                        
                    }
                    
                }
                
                
                
            }
            
            
        }
        

        
    }
    
    func updateWithOwnedGames() {
        let title = ViewController.savedGame.title
        let id = ViewController.savedGame.id
        let owned = ViewController.savedGame.owned
        
        guard let array = gameArray else { return }
        for i in 0...array.count - 1 {
            if gameArray?[i].title == title && gameArray?[i].id == id {
                gameArray?[i].owned = owned
            }
        }
        tableView.reloadData()
    }
    
    func addGameToLibraryPressed(_ sender: ViewControllerTableViewCell) {
        print("owned button pressed")
        let indexPath = tableView.indexPath(for: sender)
        ViewController.savedGameIndex = indexPath!
        
        if let cell = tableView.cellForRow(at: indexPath!) as? ViewControllerTableViewCell {
            let platform = fetchPlatformObject(platformID: (cell.game?.platformID)!)
            let unownedImage = fetchSaveToLibraryBtnImg(platformID: cell.platformID!, owned: false)
            
            guard let title = cell.game?.title else { return }
            guard let gameID = cell.game?.id else { return }
            guard let platformID = cell.game?.platformID else { return }
            
            
            if checkForGameInLibrary(name: title, id: gameID, platformID: platformID) {

                    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { (action) in
                        
                    
                    
                    cell.addToLibraryButton.setImage(UIImage(named: unownedImage), for: UIControl.State.normal)
                    cell.game?.owned = false
                        self.gameArray?[(indexPath?.row)!].owned = false

                        
                        print(self.checkForPlatformInLibrary(name: (cell.platformName!), id: Int((cell.platformID!))))
                        if self.checkForPlatformInLibrary(name: cell.platformName!, id: Int((cell.platformID!))) {
                        
                            self.deleteGameFromCoreData()

                        
                            let savedPlatforms = self.persistenceManager.fetch(Platform.self)
                        print("saved platforms count = \(savedPlatforms.count)")
                       
                            let existingPlatforms = self.fetchCoreDataPlatformObject(id: cell.platformID!)
//                        print("existingPlatforms count = \(existingPlatforms.games?.count)")
                            
                            
                        if existingPlatforms.games!.count < 1 {
                            
                            self.deletePlatformFromCoreData()
                            
                        }

                       
                    }
                    
                    
                    }
                    
                    let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved pictures and stats will not be able to be restored.", preferredStyle: .alert)
                    alert.addAction(deleteConfirmation)
                    alert.addAction(cancel)
                    self.present(alert, animated: true) {
                        
                    }
                    
            
            } else {
                print("not owned")
//                print(cell.platformName)
//                print(cell.platformID)
                guard let title = cell.game?.title, let id = cell.game?.id, let image = cell.tableViewCoverImage.image, let platformName = cell.platformName, let platformID = cell.platformID else {
                    print("One of the following may be nil:")
//                    print("cell.game.title", cell.game?.title)
//                    print("cell.game.id", cell.game?.id)
//                    print("cell.tableviewcoverimage.image", cell.tableViewCoverImage.image)
//                    print("cell.platformname", cell.platformName)
//                    print("cell.platformid", cell.platformID)
                    print("Bailing Out")
                    return }
                
                print(platformName)
                print(platformID)
            let imageData = image.jpegData(compressionQuality: 1)
                
            
            ViewController.savedGame.title = title
            ViewController.savedGame.id = id
            ViewController.savedGame.index = indexPath?.row ?? 0
                if checkForGameInWishList(name: title, id: id) {
                    
                    deleteGameFromWishList(title: title, id: id)
                    
                }
            saveGameToCoreData(title, id, imageData!, platform)
            let platformButtonImg = self.fetchSaveToLibraryBtnImg(platformID: platformID, owned: true)
                cell.addToLibraryButton.setImage(UIImage(named: platformButtonImg), for: .normal)
                
                cell.game?.owned = true
//                print("cell.game.owned = \(cell.game?.owned)")
                gameArray?[(indexPath?.row)!].owned = true
                
                
                
                

                let savedGames = persistenceManager.fetch(SavedGames.self)
                
                for currentGame in savedGames {
                    if currentGame.title == cell.game?.title && currentGame.gameID == (cell.game?.id)! {
                     
                        
                        
                        if let genres = currentGame.genres {
//                            let savedGenres = persistenceManager.fetch(GameGenre.self)
                            
                                
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
                        
                        
                        
                        
                        
                        print("platform CORE DATA \(platform)")
                        let savedPlatform = persistenceManager.fetch(Platform.self)

                        if savedPlatform.count >= 1 {

                        if checkForPlatformInLibrary(name: platformName, id: platformID) {
                            print("Platform already exists--retreiving and adding game to platform")
                            let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
                           
                            existingPlatform.addToGames(currentGame)
                            persistenceManager.save()
//                            print("existing platform is \(existingPlatform.games)")
                        }
                        else {
                            print("Platform doesnt exist--creating platform then adding game to platform")
                           savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            
//                            print("new platform is \(newPlatform.games)")
                        }
                            
                        } else {
                            print("Platform doesnt exist--creating platform then adding game to platform")
                           savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
//                            print("new platform is \(newPlatform.games)")

                        }


                    }
                }



            
            }
            
            }
        
        
        
        
        getSavedGames()
        getSavedPlatforms()
        
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
    
    
    func convertPlatformNameToID(platformName: String) -> Int {
        print("platformName is", platformName)
        let allPlatforms = network.platforms
        var platformID = 0
        for platform in allPlatforms {
            
            if platform.name == platformName {
                platformID = platform.id
            }
            
        }
        print("platformID is", platformID)
      return platformID
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
            dropDownView.layer.shadowColor = UIColor.darkGray.cgColor



        } else {
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark
            dropDownView.layer.shadowColor = UIColor.gray.cgColor


        }
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            
            tableView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            platformLabel.backgroundColor = lightGray
            platformPicker.backgroundColor = lightGray
            dropDown.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            dropDown.textColor = .black
            dropDown.shadowColor = .black
            dropDown.shadowOffset = CGSize(width: 3.0, height: 3.0)
            

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
           tableView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            platformLabel.backgroundColor = darkGray
            platformPicker.backgroundColor = darkGray
            dropDown.backgroundColor = UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1)
            dropDown.textColor = .white
            dropDown.shadowOffset = CGSize(width: 3.0, height: 3.0)
            dropDown.shadowColor = .white

        }
        
        
        if let platformID = gameArray?[0].platformID {
            let platformLogos = self.setPlatformIcon(platformID: platformID, mode: self.traitCollection.userInterfaceStyle)
            
            self.tableviewPlatformImage.image = UIImage(named: platformLogos)
        }
        
    }

    
    
    @IBAction func platformMenuTouched(_ sender: Any) {

        dropDown.show()

    }
    
//    func updatePlatformsFilter(platformSelections: [String]) {
//        platformsToFilter.removeAll()
//        var platformArray: [Int] = []
//        for platform in platformSelections {
//            let platformID = convertPlatformNameToID(platformName: platform)
//            platformArray.append(platformID)
//        }
//        platformsToFilter = platformArray
//        print("filtering platforms", platformsToFilter)
//        
//    }
    
    func convertPlatformIDToName(PlatformID: Int) -> String {
        let platforms = network.platforms
        var platformName = ""
        for platform in platforms {
            
            if platform.id == PlatformID {
                platformName = platform.name
            }
        }
        
        return platformName
    }
    
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
        print("Checking for game in wishlist")
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
             if savedGame.title == name && savedGame.gameID == id {
                print("Game is in wishlist")
                return true
        }
          

    }
        
        print("Game is not in wishlist")
        return false
    
    }
    
    
  

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            
        if gameArray != nil {
            return gameArray!.count
        }
            
        }
        
        if section == 1 {
            
            return 1
            
        }
        
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gameDatabaseCell", for: indexPath) as! ViewControllerTableViewCell
            
        cell.delegate = self

        cell.game = gameArray?[indexPath.row]
        cell.indexPath = indexPath
            
            return cell
            
        
        } else {
            let animateCell = tableView.dequeueReusableCell(withIdentifier: "loadingCellID", for: indexPath) as! LoadingCell
            
            animateCell.activityIndicator.startAnimating()
            
            return animateCell
            
        }

        
        
    }
    

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        print("****DIDSELECTROW in main VC called****")
        let cell = tableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
//        print("test \(cell.frontImageName)")

        segueObject = gameArray?[indexPath.row]
        if let image = cell.tableViewCoverImage.image {
            print("setting boxartimage")
            segueObject?.boxartImage = image
        }
//        print(segueObject)

        self.performSegue(withIdentifier: "pagingVC", sender: self)

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell
        
        var title = ""
        
        if let gameName = cell?.game?.title {
            if let gameID = cell?.game?.id {
        if checkForGameInWishList(name: gameName, id: gameID) {
            title = "Remove from Wishlist"
        } else {
            title = "Add to Wishlist"

        }
            }
        }
        
        let wishListAction = UIContextualAction(style: .normal, title: title) { action, view, completion in
//            view.backgroundColor = .clear
    
            guard let gameTitle = cell?.game?.title else { return }
            guard let id = cell?.game?.id else { return }
            if self.checkForGameInWishList(name: gameTitle, id: id) {
                
                self.deleteGameFromWishList(title: gameTitle, id: id)

                self.getWishlist()
            } else {
                
                self.saveGameToWishList(gameTitle, id, game: (cell?.game)!)


                self.getWishlist()
                
                
                
            }
            
            print("Wishlist pressed")
            completion(true)

        }
        let lightBlue = UIColorFromRGB(0x2B95CE)
        if let gameName = cell?.game?.title {
            if let gameID = cell?.game?.id {
        if checkForGameInWishList(name: gameName, id: gameID) {
            wishListAction.image = UIImage(systemName: "star.fill")?.withTintColor(.white).addBackgroundCircle(lightBlue)
        } else {
            wishListAction.image = UIImage(systemName: "star")?.withTintColor(.white).addBackgroundCircle(lightBlue)

        }
            }
        }
        
//        wishListAction.backgroundColor = .clear
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            
            wishListAction.backgroundColor = lightGray

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            
            wishListAction.backgroundColor = darkGray
        }
        
        let config = UISwipeActionsConfiguration(actions: [wishListAction])
        if let gameName = cell?.game?.title {
            if let gameID = cell?.game?.id {
                if let platformID = cell?.game?.platformID {
                    if checkForGameInLibrary(name: gameName, id: gameID, platformID: platformID) {
                        return nil
                    } else {
                        return config
                        
                    }
            }
        }
       
        }
        return nil
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//
//
//    }
    
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            tableView.cellForRow(at: indexPath)?.layoutIfNeeded()
        }
    }
    
}





extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }


    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        search.searchBar.showsCancelButton = true

    }
    


    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.search.searchBar.showsCancelButton = true
        self.search.searchBar.endEditing(true)

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBarText = searchBar.text
        if searchBarText == "" {
            self.search.searchBar.endEditing(true)
        } else if searchBarText == nil {
            self.search.searchBar.endEditing(true)
        } else {



            self.search.searchBar.endEditing(true)
        self.network.gameArray.removeAll()

            let currentPlatformID = gameArray?[0].platformID
//            print("Current Platform ID is", currentPlatformID)
            if platformsToFilter.count > 0 {
//                let stringFilter = platformsToFilter.map { String($0) }
//                let filter = stringFilter.joined(separator: ",")
                network.searchFilter = " platforms = "
                
                if let searchText = searchBarText {
                    print("search text ", searchText)
                network.searchText = searchText
                }
                network.fetchIGDBGamesData(filterBy: network.searchFilter, platformID: currentPlatformID!, searchByName: searchBarText, sortByField: nil, sortAscending: nil, offset: 0, resultsPerPage: 20) {
                    self.network.searchIsActive = true

            self.gameArray = self.network.gameArray
            self.tableView.reloadData()
        }
            } else {
                
                if let searchText = searchBarText {
                    print("search text ", searchText)
                network.searchText = searchText
                }
                let currentPlatformID = gameArray?[0].platformID!
                network.searchFilter = " platforms = "
                
                network.fetchIGDBGamesData(filterBy: network.searchFilter, platformID: currentPlatformID!, searchByName: searchBarText, sortByField: nil, sortAscending: nil, offset: 0, resultsPerPage: 20) {
                    self.network.searchIsActive = true

            self.gameArray = self.network.gameArray
//                    print("gamearray count is", self.gameArray?.count)
            self.tableView.reloadData()
        }
            }
    }
    }
    
}


extension ViewController: DropdownPickerViewDelegate {
    
    func configureDropDownMenu() {
        dropDown.anchorView = dropDownView
        dropDownView.layer.cornerRadius = 12
        dropDownView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        dropDownView.layer.shadowOpacity = 0.7
        dropDownView.layer.shadowRadius = 2
        dropDownView.layer.masksToBounds = false
        dropDownView.titleLabel?.adjustsFontSizeToFitWidth = true
        dropDown.backgroundColor = .white
        dropDown.dataSource = platforms
        dropDown.direction = .bottom
        dropDown.width = dropDownView.frame.size.width
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.network.searchIsActive = false
            print("Selected item: \(item) at index: \(index)")
            
            let igdbPlatformName = formatPrettyTitleToIGDB(platformName: item)
            
            let selectedPlatformID = convertPlatformNameToID(platformName: igdbPlatformName)
            dropDownView.setTitle(item, for: .normal)
            print("selected platform = ", selectedPlatformID)
            self.network.gameArray.removeAll()
            network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: selectedPlatformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: 0, resultsPerPage: 20) {
                
                self.network.currentOffset = 0
                self.gameArray = self.network.gameArray
                if let platformID = gameArray?[0].platformID {
                currentPlatformID = platformID
                }
                currentPlatformName = convertPlatformIDToName(PlatformID: currentPlatformID)
                
                self.search.searchBar.placeholder = "Search within \(item)"
                

//                print(self.gameArray)
                let platformLogos = self.setPlatformIcon(platformID: selectedPlatformID, mode: self.traitCollection.userInterfaceStyle)
                self.tableviewPlatformImage.image = UIImage(named: platformLogos)
                print("tableview should reload")
                self.tableView.reloadData()
                
                
                
            }
            
            
            
            
          }
    }
    
    
}
