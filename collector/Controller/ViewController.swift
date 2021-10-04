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
    @IBOutlet weak var progressIndicator: UIProgressView!
    @IBOutlet weak var totalGamesDisplayedLbl: UILabel!
    @IBOutlet weak var progressCompleteLbl: UILabel!
    @IBOutlet weak var gameArrayCountLabel: UILabel!
    
    let network = Networking.shared
    var wishList : [WishList] = [WishList]()
    var failureReason : failures?

    let failLabel = UILabel()
    let failRefreshBtn = UIButton()
    
    var savedGames: [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGenres: [GameGenre] = [GameGenre]()
    let persistenceManager = PersistenceManager.shared
    static var savedGameIndex: IndexPath = [0,0]
    static var savedGame = GameObject()
    static var selectedGameIndex : IndexPath = IndexPath(row: 0, section: 0)

    var numericGames : [GameObject] = []
    var aGames : [GameObject] = []
    var bGames : [GameObject] = []
    var cGames : [GameObject] = []
    var dGames : [GameObject] = []
    var eGames : [GameObject] = []
    var fGames : [GameObject] = []
    var gGames : [GameObject] = []
    var hGames : [GameObject] = []
    var iGames : [GameObject] = []
    var jGames : [GameObject] = []
    var kGames : [GameObject] = []
    var lGames : [GameObject] = []
    var mGames : [GameObject] = []
    var nGames : [GameObject] = []
    var oGames : [GameObject] = []
    var pGames : [GameObject] = []
    var qGames : [GameObject] = []
    var rGames : [GameObject] = []
    var sGames : [GameObject] = []
    var tGames : [GameObject] = []
    var uGames : [GameObject] = []
    var vGames : [GameObject] = []
    var wGames : [GameObject] = []
    var xGames : [GameObject] = []
    var yGames : [GameObject] = []
    var zGames : [GameObject] = []

    
    
    var gameArray : [GameObject] = [] {
        didSet {
              numericGames = gameArray.filter { $0.title?.first.flatMap { Int(String($0)) } != nil }
              aGames = gameArray.filter { ($0.title?.hasPrefix("A"))! || ($0.title?.hasPrefix("a"))!  }
              bGames = gameArray.filter { ($0.title?.hasPrefix("B"))! || ($0.title?.hasPrefix("b"))!  }
              cGames = gameArray.filter { ($0.title?.hasPrefix("C"))! || ($0.title?.hasPrefix("c"))!  }
              dGames = gameArray.filter { ($0.title?.hasPrefix("D"))! || ($0.title?.hasPrefix("d"))!  }
              eGames = gameArray.filter { ($0.title?.hasPrefix("E"))! || ($0.title?.hasPrefix("e"))!  }
              fGames = gameArray.filter { ($0.title?.hasPrefix("F"))! || ($0.title?.hasPrefix("f"))!  }
              gGames = gameArray.filter { ($0.title?.hasPrefix("G"))! || ($0.title?.hasPrefix("g"))!  }
              hGames = gameArray.filter { ($0.title?.hasPrefix("H"))! || ($0.title?.hasPrefix("h"))!  }
              iGames = gameArray.filter { ($0.title?.hasPrefix("I"))! || ($0.title?.hasPrefix("i"))!  }
              jGames = gameArray.filter { ($0.title?.hasPrefix("J"))! || ($0.title?.hasPrefix("j"))!  }
              kGames = gameArray.filter { ($0.title?.hasPrefix("K"))! || ($0.title?.hasPrefix("k"))!  }
              lGames = gameArray.filter { ($0.title?.hasPrefix("L"))! || ($0.title?.hasPrefix("l"))!  }
              mGames = gameArray.filter { ($0.title?.hasPrefix("M"))! || ($0.title?.hasPrefix("m"))!  }
              nGames = gameArray.filter { ($0.title?.hasPrefix("N"))! || ($0.title?.hasPrefix("n"))!  }
              oGames = gameArray.filter { ($0.title?.hasPrefix("O"))! || ($0.title?.hasPrefix("o"))!  }
              pGames = gameArray.filter { ($0.title?.hasPrefix("P"))! || ($0.title?.hasPrefix("p"))!  }
              qGames = gameArray.filter { ($0.title?.hasPrefix("Q"))! || ($0.title?.hasPrefix("q"))!  }
              rGames = gameArray.filter { ($0.title?.hasPrefix("R"))! || ($0.title?.hasPrefix("r"))!  }
              sGames = gameArray.filter { ($0.title?.hasPrefix("S"))! || ($0.title?.hasPrefix("s"))!  }
              tGames = gameArray.filter { ($0.title?.hasPrefix("T"))! || ($0.title?.hasPrefix("t"))!  }
              uGames = gameArray.filter { ($0.title?.hasPrefix("U"))! || ($0.title?.hasPrefix("u"))!  }
              vGames = gameArray.filter { ($0.title?.hasPrefix("V"))! || ($0.title?.hasPrefix("v"))!  }
              wGames = gameArray.filter { ($0.title?.hasPrefix("W"))! || ($0.title?.hasPrefix("w"))!  }
              xGames = gameArray.filter { ($0.title?.hasPrefix("X"))! || ($0.title?.hasPrefix("x"))!  }
              yGames = gameArray.filter { ($0.title?.hasPrefix("Y"))! || ($0.title?.hasPrefix("y"))!  }
              zGames = gameArray.filter { ($0.title?.hasPrefix("Z"))! || ($0.title?.hasPrefix("z"))!  }
            
      
            
            gameArrayCountLabel.text = String(gameArray.count)
            print("did set in game array test")
            if network.endOfResults == true {
                if gameArray.count > 0 {
                let currentCount = Float(self.gameArray.count)
                let totalCount = Float(self.gameArray.count)
                let progress = currentCount / totalCount
                let progressPercent = progress * 100
                let progressInteger = Int(progressPercent)
//                let progressDecimal = String(format: "%.2f", progress)
                let progressString = String(progressInteger) + "%"
                
                progressCompleteLbl.text = progressString
                progressIndicator.progress = progress
            }
                
                
                UIView.animate(withDuration: 2) {
                    self.search.searchBar.alpha = 1
                } completion: { complete in
                    self.search.searchBar.isUserInteractionEnabled = true
                }

            } else {
                
                let currentCount = Float(self.gameArray.count)
                let totalCount = Float(self.network.totalRequestCount)
                let progress = currentCount / totalCount
                let progressDecimal = String(format: "%.2f", progress)
                let progressPercent = String(Int((Double(progressDecimal)! * 100))) + "%"
                
                progressCompleteLbl.text = progressPercent
                progressIndicator.progress = progress

                
                UIView.animate(withDuration: 2) {
                    self.search.searchBar.alpha = 0.2

                } completion: { complete in
                    self.search.searchBar.isUserInteractionEnabled = false

                }

            }
        }
    }
    var segueObject : GameObject?
    var boxartImage : UIImage?
    let dropDown = DropDown()
    var platformsToFilter : [Int] = []
    var currentPlatformID = 18
    var currentPlatformName = ""
    let search = UISearchController(searchResultsController: nil)
    let platforms = ["3DO Interactive Multiplayer", "Amiga CD32", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", "Atari Lynx", "ColecoVision", "Fairchild Channel F", "Intellivision", "Magnavox Odyssey", "Microsoft Xbox", "Microsoft Xbox 360", "Microsoft Xbox One", "Microsoft Xbox Series S|X", "Neo Geo AES", "Neo Geo CD", "Neo Geo Pocket", "Neo Geo Pocket Color", "Nintendo Game & Watch", "Nintendo Entertainment System (NES)", "Super Nintendo Entertainment System (SNES)", "Nintendo Virtual Boy", "Nintendo 64", "Nintendo GameCube", "Nintendo Wii", "Nintendo Wii U", "Nintendo Switch", "Nintendo Game Boy", "Nintendo Game Boy Color", "Nintendo Game Boy Advance", "Nintendo DS", "Nintendo DSi", "Nintendo 3DS", "New Nintendo 3DS", "Nintendo Pokémon Mini", "Nokia N-Gage", "Nuon", "TurboGrafx-16/PC Engine", "PC Engine SuperGrafx","Philips CD-i", "Sega SG-1000", "Sega Master System", "Sega Genesis/Mega Drive", "Sega CD", "Sega 32X", "Sega Saturn", "Sega Dreamcast", "Sega Game Gear", "Sega Pico", "Sony PlayStation", "Sony PlayStation 2", "Sony PlayStation 3", "Sony PlayStation 4", "Sony PlayStation 5", "Sony PlayStation Portable (PSP)", "Sony PlayStation Vita", "Vectrex", "WonderSwan", "WonderSwan Color", "Zeebo"]
    
    let sectionTitles = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".map(String.init)
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dropDown.reloadAllComponents()
        
            if network.gameArray.count != 0 {
            gameArray = network.gameArray
            print("gamearray counting", gameArray.count)
            self.tableView.reloadData()

            
        }
        if gameArray.count > 0  {
            if let platformID = gameArray[0].platformID {
            currentPlatformID = platformID
            }
            currentPlatformName = convertPlatformIDToName(PlatformID: currentPlatformID)
            print("current platform is", currentPlatformName)
            search.searchBar.placeholder = "Search within \(currentPlatformName)"
            
            
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
        let currentCount = Float(gameArray.count)
        let totalCount = Float(network.totalRequestCount)
        let progress = currentCount / totalCount
        self.progressIndicator.progress = progress
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
                self.tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "loadingCellID")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.autoresizingMask = .flexibleWidth
        let lightBlue = UIColorFromRGB(0x2B95CE)
        tableView.sectionIndexColor = lightBlue
        network.delegate = self
        prepareData()

        setAppearance()
        configureDropDownMenu()
        configureSearchBar()
        createAppIcon()
        createFailViews()
        
        let scanButton = UIButton(type: .system)
        scanButton.setImage(UIImage(systemName: "barcode"), for: .normal)
        scanButton.setTitle("Scan", for: .normal)
//        scanButton.contentHorizontalAlignment = .left
        scanButton.contentVerticalAlignment = .bottom
//        scanButton.semanticContentAttribute = .forceRightToLeft
        scanButton.sizeToFit()
        scanButton.addTarget(self, action: #selector(scanButtonPressed), for: .touchUpInside)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: scanButton)
        
        
        requestMoreGames()
        
        
        
        
        
        
        
    }
    
    func requestMoreGames() {
        
        let platformID = network.lastRequestedPlatformID
        if network.endOfResults != true {
        
        self.network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: platformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: self.network.currentOffset, resultsPerPage: 500) { error in

            
            
            
            if error != nil {
//                        let indexPath = IndexPath(item: 0, section: 1)
//                        if let cell = self.tableView.cellForRow(at: indexPath) as? LoadingCell {
//
//                        }
                self.tableView.reloadData()
            } else {
    
//            if self.network.currentOffset < self.network.gameArray.count {
    self.gameArray = self.network.gameArray
        self.network.currentOffset += 500
                var currentCount = Float(self.gameArray.count)
                print("current count", currentCount)
                var totalCount = Float(self.network.totalRequestCount)
                print("total count", totalCount)
                var progress = currentCount / totalCount
                print("progress is ", progress)
                let progressFloat = Float(progress)
                print("progress float is", progressFloat)
//                self.progressIndicator.progress = progressFloat
//            self.network.currentOffset = self.network.gameArray.count
        print("offset after fetch = \(self.network.currentOffset)")
        self.network.fetchingMore = false
        print("fetching more =", self.network.fetchingMore)
        self.tableView.reloadData()
                
                print("dropdown endofresults", self.network.endOfResults)
                if self.network.endOfResults == true {
                    self.gameArrayCountLabel.text = String(self.gameArray.count)

                    currentCount = Float(self.gameArray.count)
                    totalCount = Float(self.gameArray.count)
                    progress = currentCount / totalCount
//                    self.progressIndicator.progress = progress
                    UIView.animate(withDuration: 3) {
                        self.progressIndicator.alpha = 0
                        self.progressCompleteLbl.alpha = 0
                    } completion: { complete in
                        UIView.animate(withDuration: 3) {
                            
                            self.gameArrayCountLabel.alpha = 1
                            self.totalGamesDisplayedLbl.alpha = 1

                        } completion: { complete in
                            
                        }

                        
                      
                    }

                
                    
                    print("******************************")
                    print("*      END OF RESULTS        *")
                    print("*Fetched Games: \(self.network.currentDataCount)         *")
                    print("*Displayed Games:\(self.gameArray.count)        *")
                    print("******************************")

                } else {
                    self.requestMoreGames()
                }
                
                
    }
}
        }
    }
    
    @objc func scanButtonPressed() {
        
        let sboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sboard.instantiateViewController(identifier: "barcode")
        navigationController?.pushViewController(viewController, animated: true)
//        present(viewController, animated: true, completion: nil)
        
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
        search.searchBar.alpha = 0.2
        search.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .bookmark, state: .normal)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
        
    }
    
    
    func prepareData() {
        
        if network.gameArray.count != 0 {
            print("network gamearray count is", network.gameArray.count)
            self.gameArray = self.network.gameArray
            for game in gameArray {
//                print(game)
                print(game.title)
                print(game.platformID)
            }
            print("game array count is", gameArray.count)
//            print(gameArray)
            let platformImage = self.setPlatformIcon(platformID: self.gameArray[0].platformID!, mode: self.traitCollection.userInterfaceStyle)
            self.tableviewPlatformImage.image = UIImage(named: platformImage)
            self.tableView.reloadData()
            


        }
        
    }
    
    func createFailViews() {
        view.addSubview(failLabel)
        view.addSubview(failRefreshBtn)
        
        failLabel.text = "Network failure..."
        failLabel.textAlignment = .center
        failLabel.isHidden = true
        failLabel.translatesAutoresizingMaskIntoConstraints = false
        
        failRefreshBtn.setTitle("Refresh", for: .normal)
        failRefreshBtn.backgroundColor = .red
        failRefreshBtn.tintColor = .white
        failRefreshBtn.isHidden = true
        failRefreshBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            failLabel.heightAnchor.constraint(equalToConstant: 50),
            failLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            failLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            failLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            failRefreshBtn.heightAnchor.constraint(equalToConstant: 50),
            failRefreshBtn.widthAnchor.constraint(equalTo: failLabel.widthAnchor, multiplier: 0.5),
            failRefreshBtn.topAnchor.constraint(equalTo: failLabel.bottomAnchor),
            failRefreshBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        
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

    
    

//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//
////        if network.gameFetchDidFail == true {
////
////            if offsetY + scrollView.frame.height == contentHeight {
////                beginBatchFetch()
////
////            }
////
////        }
//
//        if offsetY > (contentHeight - scrollView.frame.size.height * 4) {
//
//            if network.fetchingMore == false {
//                print("Not currently fetching")
//
//                if network.endOfResults == false {
//                    print("not at the end of results")
//
//                    beginBatchFetch()
//                }
//
//            }
//
//        }
//    }
    
    
    
//    func beginBatchFetch() {
//        network.fetchingMore = true
//        print("fetching data")
//        print("fetching more =", network.fetchingMore)
////        print(currentOffset)
//        DispatchQueue.global(qos: .userInitiated).async{
//
//            print("offset before fetch \(self.network.currentOffset)")
//            var platformID = 0
//            if self.network.gameArray.count > 0 {
//                if let platform = self.network.gameArray[0].platformID {
//                    platformID = platform
//                }
//            } else {
//                platformID = self.network.lastRequestedPlatformID
//            }
//
////            let platformID = self.network.gameArray[0].platformID
//
//            if self.network.searchIsActive == false {
//
//                //search is not active
//                self.network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: platformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: self.network.currentOffset, resultsPerPage: 500) { error in
//
//                    if error != nil {
////                        let indexPath = IndexPath(item: 0, section: 1)
////                        if let cell = self.tableView.cellForRow(at: indexPath) as? LoadingCell {
////
////                        }
//                        self.tableView.reloadData()
//                    } else {
//
////            if self.network.currentOffset < self.network.gameArray.count {
//            self.gameArray = self.network.gameArray
//                self.network.currentOffset += 500
//
////            self.network.currentOffset = self.network.gameArray.count
//                print("offset after fetch = \(self.network.currentOffset)")
//                self.network.fetchingMore = false
//                print("fetching more =", self.network.fetchingMore)
//                self.tableView.reloadData()
//            }
////                    }
//        }
//
//
//
//            } else {
//                //search is active
//
//                if self.platformsToFilter.count > 0 {
//
//
//                    self.network.fetchIGDBGamesData(filterBy: self.network.searchFilter, platformID: nil, searchByName: self.network.searchText, sortByField: nil, sortAscending: nil, offset: self.network.currentOffset, resultsPerPage: 20) {_ in
////                        if self.network.currentOffset < self.network.gameArray.count {
//                        self.gameArray = self.network.gameArray
////                        self.network.currentOffset = self.network.gameArray.count
//                            self.network.currentOffset += 20
//                            print("offset after fetch = \(self.network.currentOffset)")
//                            self.network.fetchingMore = false
//                            print("fetching more \(self.network.fetchingMore)")
//                            self.tableView.reloadData()
////                        }
//
//
//                    }
//
//                } else {
//
//
//                    self.network.fetchIGDBGamesData(filterBy: nil, platformID: nil, searchByName: self.network.searchText, sortByField: nil, sortAscending: nil, offset: self.network.currentOffset, resultsPerPage: 20) {_ in
////                        if self.network.currentOffset < self.network.gameArray.count {
//                        self.gameArray = self.network.gameArray
////                        self.network.currentOffset = self.network.gameArray.count
//                            self.network.currentOffset += 20
//                            print("offset after fetch = \(self.network.currentOffset)")
//                            self.network.fetchingMore = false
//                            print("fetching more \(self.network.fetchingMore)")
//                            self.tableView.reloadData()
////                        }
//
//
//                    }
//
//                }
//
//
//
//            }
//
//
//        }
//
//
//
//    }
    
    func updateWithOwnedGames() {
        let title = ViewController.savedGame.title
        let id = ViewController.savedGame.id
        let owned = ViewController.savedGame.owned
        
        for i in 0...gameArray.count - 1 {
            if gameArray[i].title == title && gameArray[i].id == id {
                gameArray[i].owned = owned
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
//            let unownedImage = fetchSaveToLibraryBtnImg(platformID: cell.platformID!, owned: false)
            let unownedImage = fetchAddToButtonIcon(platformID: cell.platformID!, owned: false)
            
            guard let title = cell.game?.title else { return }
            guard let gameID = cell.game?.id else { return }
            guard let platformID = cell.game?.platformID else { return }
            
            
            if checkForGameInLibrary(name: title, id: gameID, platformID: platformID) {

                    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { (action) in
                        
                    
                    print("unownedImage is", unownedImage)
                    cell.addToLibraryButton.setImage(UIImage(named: unownedImage), for: UIControl.State.normal)
                    cell.game?.owned = false
                        self.gameArray[(indexPath?.row)!].owned = false

                        
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
//            let platformButtonImg = self.fetchSaveToLibraryBtnImg(platformID: platformID, owned: true)
                let platformButtonImg = self.fetchAddToButtonIcon(platformID: platformID, owned: true)
                cell.addToLibraryButton.setImage(UIImage(named: platformButtonImg), for: .normal)
                
                cell.game?.owned = true
//                print("cell.game.owned = \(cell.game?.owned)")
                gameArray[(indexPath?.row)!].owned = true
                
                
                
                

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
            print("platform.name", platform.name, "platform.id", platform.id)
            if platform.name == platformName {
                platformID = platform.id
            }
            
        }
        print("platformID is", platformID)
      return platformID
    }


    
//    func fetchSaveToLibraryBtnImg(platformID: Int, owned: Bool) -> String {
//        switch platformID {
//        case 7:
//            if owned {
//                return "nes-minus-inversed"
//            } else {
//               return "nes-plus-inversed"
//            }
//        case 6:
//            if owned {
//                return "snes-minus-inversed"
//            } else {
//                return "snes-plus-inversed"
//            }
//        case 3:
//            if owned {
//                return "n64-minus-inversed"
//            } else {
//                return "n64-plus-inversed"
//            }
//        case 4:
//            if owned {
//                return "gb-minus-inversed"
//            } else {
//                return "gb-plus-inversed"
//            }
//        case 2:
//            if owned {
//                //gamecube
//                return "gc-minus-inversed"
//            } else {
//                return "gc-plus-inversed"
//            }
//        case 5:
//            if owned {
//                return "gba-minus-inversed"
//            } else {
//                return "gba-plus-inversed"
//            }
//        case 18:
//            if owned {
//                return "genesis-minus-inversed"
//            } else {
//                return "genesis-plus-inversed"
//            }
//        case 21:
//            if owned {
//                //Sega CD
//                return "cd-minus-inversed"
//            } else {
//                return "cd-plus-inversed"
//            }
//        default:
//            if owned {
//                return "folder_placeholder_owned_black"
//            } else {
//                return "folder_placeholder_unowned"
//            }
//        }
//
//    }
    

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
        
        
        if let platformID = gameArray[0].platformID {
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
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        if traitCollection.userInterfaceStyle == .light {
            header.contentView.backgroundColor = lightGray
        } else {
            header.contentView.backgroundColor = darkGray

        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
            case 0   :     if numericGames.count > 0 { return "0-9"}
            case 1   :     if aGames.count > 0 { return sectionTitles[section] }
            case 2   :     if bGames.count > 0 { return sectionTitles[section] }
            case 3   :     if cGames.count > 0 { return sectionTitles[section] }
            case 4   :     if dGames.count > 0 { return sectionTitles[section] }
            case 5   :     if eGames.count > 0 { return sectionTitles[section] }
            case 6   :     if fGames.count > 0 { return sectionTitles[section] }
            case 7   :     if gGames.count > 0 { return sectionTitles[section] }
            case 8   :     if hGames.count > 0 { return sectionTitles[section] }
            case 9   :     if iGames.count > 0 { return sectionTitles[section] }
            case 10  :     if jGames.count > 0 { return sectionTitles[section] }
            case 11  :     if kGames.count > 0 { return sectionTitles[section] }
            case 12  :     if lGames.count > 0 { return sectionTitles[section] }
            case 13  :     if mGames.count > 0 { return sectionTitles[section] }
            case 14  :     if nGames.count > 0 { return sectionTitles[section] }
            case 15  :     if oGames.count > 0 { return sectionTitles[section] }
            case 16  :     if pGames.count > 0 { return sectionTitles[section] }
            case 17  :     if qGames.count > 0 { return sectionTitles[section] }
            case 18  :     if rGames.count > 0 { return sectionTitles[section] }
            case 19  :     if sGames.count > 0 { return sectionTitles[section] }
            case 20  :     if tGames.count > 0 { return sectionTitles[section] }
            case 21  :     if uGames.count > 0 { return sectionTitles[section] }
            case 22  :     if vGames.count > 0 { return sectionTitles[section] }
            case 23  :     if wGames.count > 0 { return sectionTitles[section] }
            case 24  :     if xGames.count > 0 { return sectionTitles[section] }
            case 25  :     if yGames.count > 0 { return sectionTitles[section] }
            case 26  :     if zGames.count > 0 { return sectionTitles[section] }

            default  :     return nil
        }
        
        return nil
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {




        switch section {
            case 0   :     return numericGames.count
            case 1   :     return aGames.count
            case 2   :     return bGames.count
            case 3   :     return cGames.count
            case 4   :     return dGames.count
            case 5   :     return eGames.count
            case 6   :     return fGames.count
            case 7   :     return gGames.count
            case 8   :     return hGames.count
            case 9   :     return iGames.count
            case 10  :     return jGames.count
            case 11  :     return kGames.count
            case 12  :     return lGames.count
            case 13  :     return mGames.count
            case 14  :     return nGames.count
            case 15  :     return oGames.count
            case 16  :     return pGames.count
            case 17  :     return qGames.count
            case 18  :     return rGames.count
            case 19  :     return sGames.count
            case 20  :     return tGames.count
            case 21  :     return uGames.count
            case 22  :     return vGames.count
            case 23  :     return wGames.count
            case 24  :     return xGames.count
            case 25  :     return yGames.count
            case 26  :     return zGames.count

            default  :     return 0
        }

        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gameDatabaseCell", for: indexPath) as! ViewControllerTableViewCell
            
        cell.delegate = self


        switch indexPath.section {
            case 0   :     cell.game = numericGames[indexPath.row]
            case 1   :     cell.game = aGames[indexPath.row]
            case 2   :     cell.game = bGames[indexPath.row]
            case 3   :     cell.game = cGames[indexPath.row]
            case 4   :     cell.game = dGames[indexPath.row]
            case 5   :     cell.game = eGames[indexPath.row]
            case 6   :     cell.game = fGames[indexPath.row]
            case 7   :     cell.game = gGames[indexPath.row]
            case 8   :     cell.game = hGames[indexPath.row]
            case 9   :     cell.game = iGames[indexPath.row]
            case 10  :     cell.game = jGames[indexPath.row]
            case 11  :     cell.game = kGames[indexPath.row]
            case 12  :     cell.game = lGames[indexPath.row]
            case 13  :     cell.game = mGames[indexPath.row]
            case 14  :     cell.game = nGames[indexPath.row]
            case 15  :     cell.game = oGames[indexPath.row]
            case 16  :     cell.game = pGames[indexPath.row]
            case 17  :     cell.game = qGames[indexPath.row]
            case 18  :     cell.game = rGames[indexPath.row]
            case 19  :     cell.game = sGames[indexPath.row]
            case 20  :     cell.game = tGames[indexPath.row]
            case 21  :     cell.game = uGames[indexPath.row]
            case 22  :     cell.game = vGames[indexPath.row]
            case 23  :     cell.game = wGames[indexPath.row]
            case 24  :     cell.game = xGames[indexPath.row]
            case 25  :     cell.game = yGames[indexPath.row]
            case 26  :     cell.game = zGames[indexPath.row]

            default  :     cell.game = gameArray[indexPath.row]
        }

        cell.indexPath = indexPath
            
            return cell
            


        
        
    }
    

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        print("****DIDSELECTROW in main VC called****")
        let cell = tableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
//        print("test \(cell.frontImageName)")
        
        
        switch indexPath.section {
            case 0   :    segueObject = numericGames[indexPath.row]
            case 1   :    segueObject = aGames[indexPath.row]
            case 2   :    segueObject = bGames[indexPath.row]
            case 3   :    segueObject = cGames[indexPath.row]
            case 4   :    segueObject = dGames[indexPath.row]
            case 5   :    segueObject = eGames[indexPath.row]
            case 6   :    segueObject = fGames[indexPath.row]
            case 7   :    segueObject = gGames[indexPath.row]
            case 8   :    segueObject = hGames[indexPath.row]
            case 9   :    segueObject = iGames[indexPath.row]
            case 10  :    segueObject = jGames[indexPath.row]
            case 11  :    segueObject = kGames[indexPath.row]
            case 12  :    segueObject = lGames[indexPath.row]
            case 13  :    segueObject = mGames[indexPath.row]
            case 14  :    segueObject = nGames[indexPath.row]
            case 15  :    segueObject = oGames[indexPath.row]
            case 16  :    segueObject = pGames[indexPath.row]
            case 17  :    segueObject = qGames[indexPath.row]
            case 18  :    segueObject = rGames[indexPath.row]
            case 19  :    segueObject = sGames[indexPath.row]
            case 20  :    segueObject = tGames[indexPath.row]
            case 21  :    segueObject = uGames[indexPath.row]
            case 22  :    segueObject = vGames[indexPath.row]
            case 23  :    segueObject = wGames[indexPath.row]
            case 24  :    segueObject = xGames[indexPath.row]
            case 25  :    segueObject = yGames[indexPath.row]
            case 26  :    segueObject = zGames[indexPath.row]

            default  :    segueObject = gameArray[indexPath.row]
        }
        
//        segueObject = gameArray[indexPath.row]
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
    

    
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            tableView.cellForRow(at: indexPath)?.layoutIfNeeded()
        }
    }
    
}





extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //instant search, will process after each keypress
        
        guard let text = searchController.searchBar.text else { return }

        var searchResults : [GameObject] = []
        let searchBarText = text

        if searchBarText != "" {
            let currentPlatformID = network.lastRequestedPlatformID

                network.searchFilter = " platforms = "
                
                    print("search text ", searchBarText)
                network.searchText = searchBarText
                    
                
            
            for game in network.gameArray {
                    let contained = game.title?.lowercased().contains(searchBarText.lowercased())
                    if contained == true {
                        searchResults.append(game)
                    }
                
            }
            
            self.gameArray = searchResults
            
            tableView.reloadData()
        } else {
            self.gameArray = network.gameArray
            tableView.reloadData()
        }

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
        self.gameArray = network.gameArray
        tableView.reloadData()

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search.searchBar.endEditing(true)

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
            self.progressCompleteLbl.text = "0%"
            self.progressIndicator.progress = 0
            self.gameArrayCountLabel.alpha = 0
            self.totalGamesDisplayedLbl.alpha = 0
            self.progressIndicator.progress = 0
            self.progressCompleteLbl.alpha = 1
            self.progressIndicator.alpha = 1
            
            print("Selected item: \(item) at index: \(index)")
            let selectedPlatformID = formatPrettyPlatformNameToID(platformName: item)
            let igdbPlatformName = formatPrettyTitleToIGDB(platformName: item)
            network.lastRequestedPlatformID = selectedPlatformID
            print("igdb name is", igdbPlatformName)
//            let selectedPlatformID = convertPlatformNameToID(platformName: igdbPlatformName)
            dropDownView.setTitle(item, for: .normal)
            print("selected platform = ", selectedPlatformID)
            self.network.gameArray.removeAll()
            
            print("selectedPlatformID is", selectedPlatformID)
            network.currentTask?.cancel()
            self.network.previousDataCount = 0
            self.network.currentDataCount = 0
            self.network.currentOffset = 0
            
            self.search.searchBar.placeholder = "Search within \(item)"
                let platformLogos = self.setPlatformIcon(platformID: selectedPlatformID, mode: self.traitCollection.userInterfaceStyle)
                UIView.transition(with: self.tableviewPlatformImage, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.tableviewPlatformImage.image = UIImage(named: platformLogos)

                }, completion: nil)
            
            network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: selectedPlatformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: 0, resultsPerPage: 500) { error in
                
                if error == nil {
                    network.currentOffset = 0
                    self.gameArray = network.gameArray
                    dropDownFetchSuccess(item: item, selectedPlatformID: selectedPlatformID)
                    print("current offset drop down", network.currentOffset)
                } else {
                    print("drop down error is", error)
                }
          
     
                
            
            }
                
            
            
            
            
          }
        
        
    }
    
    
    func refetchData() {
        
       failureReason = .dropdown
       
       switch failureReason {
       
       case .dropdown :
           print("")
       case .pagination:
           print("")
       default:
       print("invalid failure reason")
           
       
       }
    }

    
    enum failures : String {
        
        case dropdown = "dropdown"
        case pagination = "pagination"
        
    }
    
    
    func dropDownFetchSuccess(item: String, selectedPlatformID: Int) {
        
        print("network game array count", network.gameArray.count)
        


        if let platformID = gameArray[0].platformID {
        currentPlatformID = platformID
        }
        
        currentPlatformName = convertPlatformIDToName(PlatformID: currentPlatformID)
        


//                print(self.gameArray)

        print("tableview should reload")
        
        var section = 0
        if numericGames.count > 0 {
            section = 0
        } else if aGames.count > 0 {
            section = 1
        } else if bGames.count > 0 {
            section = 2
        } else if cGames.count > 0 {
            section = 3
        } else if dGames.count > 0 {
            section = 4
        } else if eGames.count > 0 {
            section = 5
        } else if fGames.count > 0 {
            section = 6
        } else if gGames.count > 0 {
            section = 7
        } else if hGames.count > 0 {
            section = 8
        } else if iGames.count > 0 {
            section = 9
        } else if jGames.count > 0 {
            section = 10
        } else if kGames.count > 0 {
            section = 11
        } else if lGames.count > 0 {
            section = 12
        } else if mGames.count > 0 {
            section = 13
        } else if nGames.count > 0 {
            section = 14
        } else if oGames.count > 0 {
            section = 15
        } else if pGames.count > 0 {
            section = 16
        } else if qGames.count > 0 {
            section = 17
        } else if rGames.count > 0 {
            section = 18
        } else if sGames.count > 0 {
            section = 19
        } else if tGames.count > 0 {
            section = 20
        } else if uGames.count > 0 {
            section = 21
        } else if vGames.count > 0 {
            section = 22
        } else if wGames.count > 0 {
            section = 23
        } else if xGames.count > 0 {
            section = 24
        } else if yGames.count > 0 {
            section = 25
        } else if zGames.count > 0 {
            section = 26
        }
        

        
        
        
        self.network.currentOffset += 500

        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: UITableView.ScrollPosition.top, animated: true)

        
        print("dropdown fetch complete, offset is now", network.currentOffset)
       
        
        if network.endOfResults != true {
            
            requestMoreGames()
            
        } else {
            
            self.gameArray = self.network.gameArray
            let currentCount = Float(self.gameArray.count)
            let totalCount = Float(self.network.totalRequestCount)
            let progress = currentCount / totalCount
//            self.progressIndicator.progress = progress
            
            self.gameArrayCountLabel.text = String(self.gameArray.count)
            
            UIView.animate(withDuration: 1.5) {
                self.progressIndicator.alpha = 0
                self.progressCompleteLbl.alpha = 0
            } completion: { complete in
                UIView.animate(withDuration: 1.5) {
                    self.gameArrayCountLabel.alpha = 1
                    self.totalGamesDisplayedLbl.alpha = 1
                  

                } completion: { complete in
            
                    
                }

            }
        print(" game array count", gameArray.count)



        }
        
    }
    
    
}
