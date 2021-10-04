//
//  OwnedGamesViewController.swift
//  collector
//
//  Created by Brian on 10/11/20.
//  Copyright © 2020 Brian. All rights reserved.
//
import Foundation
import UIKit
import CoreData


protocol ModalDelegate {
    func changeValue(value: [String], platformID: Int?)
    
}

protocol AgeRangeDelegate {
    func changeDateRange(dateRange: [Int], platformID: Int?)
}

protocol SearchFilterDelegate {
    func updatePlatformsFilter(platformSelections: [String])
}

class OwnedGamesViewController: UIViewController, OwnedGameDelegate, ModalDelegate, AgeRangeDelegate, SearchFilterDelegate {

    

    
    @IBOutlet weak var filteredGameCountLbl: UILabel!
    @IBOutlet weak var totalGameCountLbl: UILabel!
    
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var platformFilterImg: UIImageView!
    @IBOutlet weak var genreFilterImg: UIImageView!
    @IBOutlet weak var releaseDateFilterImg: UIImageView!
    @IBOutlet weak var sortDirectionLbl: UILabel!
    @IBOutlet weak var sortingByLbl: UILabel!
    @IBOutlet weak var noGamesInLibraryView: UIView!
    @IBOutlet weak var gameLibraryImage: UIImageView!
    
    
    var numericGames : [SavedGames] = []
    var aGames : [SavedGames] = []
    var bGames : [SavedGames] = []
    var cGames : [SavedGames] = []
    var dGames : [SavedGames] = []
    var eGames : [SavedGames] = []
    var fGames : [SavedGames] = []
    var gGames : [SavedGames] = []
    var hGames : [SavedGames] = []
    var iGames : [SavedGames] = []
    var jGames : [SavedGames] = []
    var kGames : [SavedGames] = []
    var lGames : [SavedGames] = []
    var mGames : [SavedGames] = []
    var nGames : [SavedGames] = []
    var oGames : [SavedGames] = []
    var pGames : [SavedGames] = []
    var qGames : [SavedGames] = []
    var rGames : [SavedGames] = []
    var sGames : [SavedGames] = []
    var tGames : [SavedGames] = []
    var uGames : [SavedGames] = []
    var vGames : [SavedGames] = []
    var wGames : [SavedGames] = []
    var xGames : [SavedGames] = []
    var yGames : [SavedGames] = []
    var zGames : [SavedGames] = []
    let persistenceManager = PersistenceManager.shared
    var ownedGames: [SavedGames] = [] {
        didSet {
            numericGames = ownedGames.filter { $0.title?.first.flatMap { Int(String($0)) } != nil }
            aGames = ownedGames.filter { ($0.title?.hasPrefix("A"))! || ($0.title?.hasPrefix("a"))!  }
            bGames = ownedGames.filter { ($0.title?.hasPrefix("B"))! || ($0.title?.hasPrefix("b"))!  }
            cGames = ownedGames.filter { ($0.title?.hasPrefix("C"))! || ($0.title?.hasPrefix("c"))!  }
            dGames = ownedGames.filter { ($0.title?.hasPrefix("D"))! || ($0.title?.hasPrefix("d"))!  }
            eGames = ownedGames.filter { ($0.title?.hasPrefix("E"))! || ($0.title?.hasPrefix("e"))!  }
            fGames = ownedGames.filter { ($0.title?.hasPrefix("F"))! || ($0.title?.hasPrefix("f"))!  }
            gGames = ownedGames.filter { ($0.title?.hasPrefix("G"))! || ($0.title?.hasPrefix("g"))!  }
            hGames = ownedGames.filter { ($0.title?.hasPrefix("H"))! || ($0.title?.hasPrefix("h"))!  }
            iGames = ownedGames.filter { ($0.title?.hasPrefix("I"))! || ($0.title?.hasPrefix("i"))!  }
            jGames = ownedGames.filter { ($0.title?.hasPrefix("J"))! || ($0.title?.hasPrefix("j"))!  }
            kGames = ownedGames.filter { ($0.title?.hasPrefix("K"))! || ($0.title?.hasPrefix("k"))!  }
            lGames = ownedGames.filter { ($0.title?.hasPrefix("L"))! || ($0.title?.hasPrefix("l"))!  }
            mGames = ownedGames.filter { ($0.title?.hasPrefix("M"))! || ($0.title?.hasPrefix("m"))!  }
            nGames = ownedGames.filter { ($0.title?.hasPrefix("N"))! || ($0.title?.hasPrefix("n"))!  }
            oGames = ownedGames.filter { ($0.title?.hasPrefix("O"))! || ($0.title?.hasPrefix("o"))!  }
            pGames = ownedGames.filter { ($0.title?.hasPrefix("P"))! || ($0.title?.hasPrefix("p"))!  }
            qGames = ownedGames.filter { ($0.title?.hasPrefix("Q"))! || ($0.title?.hasPrefix("q"))!  }
            rGames = ownedGames.filter { ($0.title?.hasPrefix("R"))! || ($0.title?.hasPrefix("r"))!  }
            sGames = ownedGames.filter { ($0.title?.hasPrefix("S"))! || ($0.title?.hasPrefix("s"))!  }
            tGames = ownedGames.filter { ($0.title?.hasPrefix("T"))! || ($0.title?.hasPrefix("t"))!  }
            uGames = ownedGames.filter { ($0.title?.hasPrefix("U"))! || ($0.title?.hasPrefix("u"))!  }
            vGames = ownedGames.filter { ($0.title?.hasPrefix("V"))! || ($0.title?.hasPrefix("v"))!  }
            wGames = ownedGames.filter { ($0.title?.hasPrefix("W"))! || ($0.title?.hasPrefix("w"))!  }
            xGames = ownedGames.filter { ($0.title?.hasPrefix("X"))! || ($0.title?.hasPrefix("x"))!  }
            yGames = ownedGames.filter { ($0.title?.hasPrefix("Y"))! || ($0.title?.hasPrefix("y"))!  }
            zGames = ownedGames.filter { ($0.title?.hasPrefix("Z"))! || ($0.title?.hasPrefix("z"))!  }
        }
        
        
    }

    var persistedGame : SavedGames?
    var indexPath: IndexPath?
    var selectedGameID: String?
    let network = Networking.shared
    var savedPlatforms: [Platform] = [Platform]()
    var savedGameIndex: IndexPath = [0,0]
    var gameName: String?
    var platformID = 0
    var filterVC: FilterVC?
    var genreSelections : [String] = []
    var dateSelections : [Int] = []
    var playerSelections : [Int] = []
    var sortSelection: String = SortSection.title.rawValue
    var asecending = true
    var ageRangeVC : AgeRangeVC?
    var platformsToFilter : [Int] = []
    var platformSelections: [String] = []
    var ascendingLabel = "Descending"
    let search = UISearchController(searchResultsController: nil)
    let sectionTitles = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".map(String.init)
    var allGames : [SavedGames] = []
    
    

    var totalGameCount : Int {
        
        allGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil)
        return allGames.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("platformID \(platformID)")
        
        
        setAppearance()
        fetchData()
        setNavigationLogoImage()
        configureNavigationController()
        createSearchController()

        if totalGameCount < 1 {
            
            noGamesInLibraryView.isHidden = false
            toggleNavigationControllerItems(isGameLibraryEmpty: true)

        } else {
            toggleNavigationControllerItems(isGameLibraryEmpty: false)

            noGamesInLibraryView.isHidden = true
        }

        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        let lightBlue = UIColorFromRGB(0x2B95CE)
        tableView.sectionIndexColor = lightBlue
        self.tableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("filterSelects \(genreSelections)")
        setAppearance()
        
        fetchData()
        if totalGameCount < 1 {

            noGamesInLibraryView.isHidden = false

            toggleNavigationControllerItems(isGameLibraryEmpty: true)

        } else {
            toggleNavigationControllerItems(isGameLibraryEmpty: false)

            noGamesInLibraryView.isHidden = true
          
        }
        print(platformID)
        print(traitCollection.userInterfaceStyle.rawValue)
        
        setFilterIndicators()
        setSortLabels()
        filteredGameCountLbl.text = "\(ownedGames.count)"
        totalGameCountLbl.text = "\(totalGameCount)"

        self.tableView.reloadData()
        print("tableview reloaded")
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
//        tableView.reloadData()
    }
    

    
    func removeFromLibrary(index: IndexPath) {
        print("remove from library")
        
        
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { (action) in
                
         
                self.deleteGameFromCoreData(index: index)
                self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self.sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: self.genreSelections, selectedPlatforms: self.platformsToFilter, selectedDateRange: self.dateSelections))
                
                if self.ownedGames.count < 1 {
                    self.toggleNavigationControllerItems(isGameLibraryEmpty: true)

                    self.noGamesInLibraryView.isHidden = false

                } else {
                    self.toggleNavigationControllerItems(isGameLibraryEmpty: false)
                    self.noGamesInLibraryView.isHidden = true
                }
                self.filteredGameCountLbl.text = "\(self.ownedGames.count)"
                self.totalGameCountLbl.text = "\(self.totalGameCount)"
                print("owned games count",self.ownedGames.count)
                self.tableView.reloadData()
            }
            
            let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved pictures and stats will not be able to be restored.", preferredStyle: .alert)
            
    
            alert.addAction(deleteConfirmation)
            alert.addAction(cancel)
            self.present(alert, animated: true) {
                
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
    
    func makeBackButton() -> UIButton {
        let lightBlue = UIColor(red: 43/255, green: 149/255, blue: 206/255, alpha: 1)
        let backButton = UIButton(type: .custom)
        backButton.tintColor = lightBlue
        backButton.setTitle("  Back", for: .normal)
        backButton.setTitleColor(lightBlue, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc func backButtonPressed() -> Void {
        print("back button pressed")

        self.navigationController?.popViewController(animated: false)

    }
    
    @objc func selectSort() -> Void {
        print("sort button pressed")
        switch sortSelection {
        
        case SortSection.title.rawValue:
            if asecending {
                ownedGames.sort(by: {$0.title! > $1.title!} )
                self.asecending = false
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()
                tableView.reloadData()
                }
             else {
                
        ownedGames.sort(by: {$0.title! < $1.title!} )
                self.asecending = true
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
            }
            
        case SortSection.platformName.rawValue:
            if asecending {
                ownedGames.sort(by: {$0.platformName! > $1.platformName!} )
                self.asecending = false
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
                }
             else {
                
        ownedGames.sort(by: {$0.platformName! < $1.platformName!} )
                self.asecending = true
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
            }
            
        case SortSection.releaseDate.rawValue:
            if asecending {
                ownedGames.sort(by: {$0.releaseYear > $1.releaseYear} )
                self.asecending = false
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
                }
             else {
                
        ownedGames.sort(by: {$0.releaseYear < $1.releaseYear} )
                self.asecending = true
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
            }
            
        case SortSection.genre.rawValue:
            if asecending {
                ownedGames.sort(by: {$0.genre! > $1.genre!} )
                self.asecending = false
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
                }
             else {
                
        ownedGames.sort(by: {$0.genre! < $1.genre!} )
                self.asecending = true
                print("Sorting is asecending = \(self.asecending)")
                setSortLabels()

                tableView.reloadData()
            }
        default:
            print("invalid selection")
                
        }
        
        configureNavigationController()

        
    }
    

    

    
    
    func changeDateRange(dateRange: [Int], platformID: Int?) {
        print("changeDateRange called")
        self.dateSelections = dateRange
        self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateRange)
            self.ownedGames = persistenceManager.fetchFilteredByReleaseDate(SavedGames.self, platformID: nil, sortBy: sortSelection, dateRange: dateRange)
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"

        tableView.reloadData()
        print("changeDateRange called")

    }
    
    func changeValue(value: [String], platformID: Int?){
        self.genreSelections = value
        
        print("genreSelections", genreSelections)
        print("platformsToFilter", platformsToFilter)
        print("changeValue called through protocal")


        let searchText = search.searchBar.text
        if searchText == "" {
        self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        }
        else {
            
            self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)

        }
 
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"

        tableView.reloadData()

        print("modal delegate filter selections \(self.genreSelections)")
    }
    
    
    func fetchData() {
        
        let searchText = search.searchBar.text
        if searchText == "" {
        self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self.sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections))
        } else {
            self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self.sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections))

        }
        filteredGameCountLbl.text = "\(ownedGames.count)"

        
        self.tableView.reloadData()
//        gamesInPlatformLbl.text = "Total Owned Games"
    }
    
    
    func createGameObjectFromCoreData(persistedObject: SavedGames) -> GameObject {
        print("persisted object \(persistedObject)")
        var screenshots : [ImageInfo] = []
        
        if let persistedScreenshots = persistedObject.screenshotImageIDs {
        for screenshot in persistedScreenshots {
            let imageInfo = ImageInfo(id: nil, alphaChannel: nil, animated: nil, game: nil, height: nil, imageID: screenshot, url: nil, width: nil, checksum: nil)

            print("should be adding imageinfo")
            print(imageInfo)
            screenshots.append(imageInfo)
        }
        }
        
        
        let game = GameObject(
            title: persistedObject.title,
            id: Int(persistedObject.gameID),
            overview: persistedObject.overview,
            boxartFrontImage: persistedObject.boxartImageURL,
            boxartHeight: Int(persistedObject.boxartHeight),
            boxartWidth: Int(persistedObject.boxartWidth),
            boxartRearImage: nil,
            fanartImage: nil,
            rating: persistedObject.rating,
            releaseDate: persistedObject.releaseDate,
            owned: true,
            index: nil,
            screenshots: screenshots,
            developerIDs: nil,
            genreIDs: nil,
            pusblisherIDs: nil,
            youtubePath: persistedObject.youtubeURL,
            platformID: Int(persistedObject.platformID),
            maxPlayers: persistedObject.maxPlayers,
            genreDescriptions: persistedObject.genre,
            genres: persistedObject.genres,
            developer: persistedObject.developerName,
            gamePhotos: nil,
            manualPhotos: nil,
            boxPhotos: nil,
            totalRating: Int(persistedObject.totalRating),
            userRating: Int(persistedObject.userRating)
            )
        
        return game
        
    }
    
    
    func updatePlatformsFilter(platformSelections: [String]) {
        platformsToFilter.removeAll()
        self.platformSelections = platformSelections
        var platformArray: [Int] = []
        for platform in platformSelections {
            let igdbName = formatPrettyTitleToIGDB(platformName: platform)
            let platformID = convertPlatformNameToID(platformName: igdbName)
            platformArray.append(platformID)
        }
        let searchText = search.searchBar.text
        platformsToFilter = platformArray
        print("filtering platforms", platformsToFilter)
        if searchText == "" {
            print("genreSelections", genreSelections)
            print("platformsToFilter", platformsToFilter)
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        } else {
            print("genreSelections", genreSelections)
            print("platformsToFilter", platformsToFilter)
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        }
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"

        tableView.reloadData()
        
        
    }

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
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            tableView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            noGamesInLibraryView.backgroundColor = lightGray
            gameLibraryImage.image = UIImage(named: "gamelibrarynew")
            
            

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            tableView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            noGamesInLibraryView.backgroundColor = darkGray
            gameLibraryImage.image = UIImage(named: "gamelibraryinversenew")


        }
    }
    
    
    func toggleNavigationControllerItems(isGameLibraryEmpty: Bool) {
        
        
        if isGameLibraryEmpty == true {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
            navigationItem.searchController = nil
        } else {
            
            navigationItem.searchController = search
            configureNavigationController()
            
            
        }
        
    }
    
    func createSearchController() {
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }
    
    func setNavigationLogoImage() {
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
    }
    
    
    func configureNavigationController() {
        
 
        if let filterViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as? FilterVC {
            filterVC = filterViewController
        } else {
            print("Can't load VC. Check name")
        }
        
        if let ageRangeViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "AgeRange") as? AgeRangeVC {
            ageRangeVC = ageRangeViewController
        } else {
            print("Can't load VC. Check name")
        }
        

        
  
        
        let firstAction = UIAction(
            title: "Remove All Filters",
            image: UIImage(systemName: "slider.horizontal.3")
        ) { [weak self ] action in
            
            self?.sortSelection = SortSection.title.rawValue
            self?.platformsToFilter.removeAll()
            self?.genreSelections.removeAll()
            self?.platformSelections.removeAll()
            self?.dateSelections.removeAll()
            let searchText = self?.search.searchBar.text
            if searchText == "" {
            self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil))!
            } else {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil))!

            }
            self?.setFilterIndicators()
            self?.filteredGameCountLbl.text = "\(self!.ownedGames.count)"

            self?.tableView.reloadData()
        }
        
        
        let secondAction = UIAction(
            title: "Filter by Genre",
            image: UIImage(systemName: "book")
        ) { [weak self] action in
            
            guard let viewController = self?.filterVC else {
            print("something wrong")
            return }
            viewController.id = self?.platformID
            viewController.delegate = self
            viewController.selectedGenres = self!.genreSelections
            self?.present(viewController, animated: true, completion: nil)
            self?.network.sourceTag = 0

        }
        
        
        let thirdAction = UIAction(
            title: "Filter by Release Date",
            image: UIImage(systemName: "calendar")
        ) { action in
            guard let viewController = self.ageRangeVC else {
                print("something wrong")
                return }
            viewController.id = self.platformID
            viewController.delegate = self
            
            self.present(viewController, animated: true, completion: nil)
            
            
            
        }
        
        let fourthAction = UIAction(
            title: "Filter by Platform",
            image: UIImage(systemName: "gamecontroller")
        ) { [weak self] action in
            
            guard let viewController = self?.filterVC else {
            print("something wrong")
            return }
            viewController.id = self?.platformID
            viewController.platformFilterDelegate = self
            viewController.gameArray = self!.ownedGames
            viewController.selectedPlatforms = self!.platformSelections
            self?.present(viewController, animated: true, completion: nil)
            self?.network.sourceTag = 1

        }

        let sortByTitle = UIAction(title: "Sort by Title", image: UIImage(systemName: "character.book.closed")) { [weak self] action in
            
            
            let searchText = self?.search.searchBar.text
            
            self?.sortSelection = SortSection.title.rawValue

                if searchText == "" {
                    self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter, selectedDateRange: self?.dateSelections))!}
                else {
                    self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter, selectedDateRange: self?.dateSelections))!}

            self?.setSortLabels()

            self?.tableView.reloadData()

            
        }
        
        let sortByReleaseDate = UIAction(title: "Sort by Release Date", image: UIImage(systemName: "calendar")) { [weak self] action in
            
            self?.sortSelection = SortSection.releaseDate.rawValue
            let searchText = self?.search.searchBar.text

            if searchText == "" {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter, selectedDateRange: self?.dateSelections))! }
            else {
                
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter, selectedDateRange: self?.dateSelections))!

            }

         
            self?.setSortLabels()

            self?.tableView.reloadData()

            
        }
        
        let sortByPlatform = UIAction(title: "Sort by Platform", image: UIImage(systemName: "gamecontroller")) { [weak self] action in
            
            self?.sortSelection = SortSection.platformName.rawValue
            let searchText = self?.search.searchBar.text

            if searchText == "" {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter, selectedDateRange: self?.dateSelections))! }
            else {
                
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter, selectedDateRange: self?.dateSelections))!

                
            }

            
            self?.setSortLabels()
            self?.tableView.reloadData()
            
        }
            
     
            
        

        let sortAscending = UIAction(title: "Sort \(ascendingLabel)", image: UIImage(systemName: "arrow.left.arrow.right")) { [weak self] action in
            
            if let ascend = self?.asecending {
            if !ascend {
                self?.ascendingLabel = "Descending"

            } else {
                self?.ascendingLabel = "Ascending"
            }
            }
            
            self?.selectSort()

        }
      

        let filterMenu = UIMenu(title:"Filter By", image: UIImage(systemName: "ellipsis"), children: [secondAction,thirdAction,fourthAction])
        let sortMenuTwo =  UIMenu(title: "Sort By", image: UIImage(systemName: "ellipsis"), children: [sortByTitle, sortByPlatform, sortByReleaseDate])

        let mainMenu = UIMenu(title: "", children: [firstAction, filterMenu])
        let sortMenu = UIMenu(title: "", children: [sortAscending, sortMenuTwo])

        var filterButton : UIBarButtonItem?
        
              filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), menu: mainMenu)
            
     
        var sortButton : UIBarButtonItem?
             sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), menu: sortMenu)
      
        self.navigationItem.rightBarButtonItem = filterButton
        self.navigationItem.leftBarButtonItem = sortButton
        
        
    }

    
    func setFilterIndicators() {
        let lightBlue = UIColorFromRGB(0x2B95CE)
        
        switch (platformsToFilter.isEmpty, genreSelections.isEmpty, dateSelections.isEmpty) {
        case (false, false, false):
            //all filters active
            
            
            platformFilterImg.tintColor = lightBlue
            genreFilterImg.tintColor = lightBlue
            releaseDateFilterImg.tintColor = lightBlue
            
            platformFilterImg.image = UIImage(systemName: "circle.fill")
            genreFilterImg.image = UIImage(systemName: "circle.fill")
            releaseDateFilterImg.image = UIImage(systemName: "circle.fill")

        
        case (true, true, true):
            //no filters active
            
            platformFilterImg.tintColor = .systemGray
            genreFilterImg.tintColor = .systemGray
            releaseDateFilterImg.tintColor = .systemGray
            
            platformFilterImg.image = UIImage(systemName: "circle")
            genreFilterImg.image = UIImage(systemName: "circle")
            releaseDateFilterImg.image = UIImage(systemName: "circle")

        
        case (false, true, true):
            //platform filter only is active

            platformFilterImg.tintColor = lightBlue
            genreFilterImg.tintColor = .systemGray
            releaseDateFilterImg.tintColor = .systemGray
            
            platformFilterImg.image = UIImage(systemName: "circle.fill")
            genreFilterImg.image = UIImage(systemName: "circle")
            releaseDateFilterImg.image = UIImage(systemName: "circle")
            
        case (false, false, true):
            //platform and genre filters active
            
            platformFilterImg.tintColor = lightBlue
            genreFilterImg.tintColor = lightBlue
            releaseDateFilterImg.tintColor = .systemGray
            
            platformFilterImg.image = UIImage(systemName: "circle.fill")
            genreFilterImg.image = UIImage(systemName: "circle.fill")
            releaseDateFilterImg.image = UIImage(systemName: "circle")
        
        case (false, true, false):
            //platform and release date filters active)
            platformFilterImg.tintColor = lightBlue
            genreFilterImg.tintColor = .systemGray
            releaseDateFilterImg.tintColor = lightBlue
            
            platformFilterImg.image = UIImage(systemName: "circle.fill")
            genreFilterImg.image = UIImage(systemName: "circle")
            releaseDateFilterImg.image = UIImage(systemName: "circle.fill")
        
        case (true, false, false):
            //genre and release date filters active
            platformFilterImg.tintColor = .systemGray
            genreFilterImg.tintColor = lightBlue
            releaseDateFilterImg.tintColor = lightBlue
            
            platformFilterImg.image = UIImage(systemName: "circle")
            genreFilterImg.image = UIImage(systemName: "circle.fill")
            releaseDateFilterImg.image = UIImage(systemName: "circle.fill")
        
        case (true, true, false):
            //release date filter only is active
            platformFilterImg.tintColor = .systemGray
            genreFilterImg.tintColor = .systemGray
            releaseDateFilterImg.tintColor = lightBlue
            
            platformFilterImg.image = UIImage(systemName: "circle")
            genreFilterImg.image = UIImage(systemName: "circle")
            releaseDateFilterImg.image = UIImage(systemName: "circle.fill")
        
        case (true, false, true):
            //genre filter only is active
            platformFilterImg.tintColor = .systemGray
            genreFilterImg.tintColor = lightBlue
            releaseDateFilterImg.tintColor = .systemGray
            
            platformFilterImg.image = UIImage(systemName: "circle")
            genreFilterImg.image = UIImage(systemName: "circle.fill")
            releaseDateFilterImg.image = UIImage(systemName: "circle")
        
        
       
        }
        
    }
    
    
    
    func setSortLabels() {
        switch asecending {
        case true:
            sortDirectionLbl.text = "Asecending"
        case false:
            sortDirectionLbl.text = "Descending"
        }
        
        
        switch sortSelection {
        
        case SortSection.title.rawValue:
            sortingByLbl.text = "Title"
        
        case SortSection.platformName.rawValue:
            sortingByLbl.text = "Platform"

        case SortSection.releaseDate.rawValue:
            sortingByLbl.text = "Release Date"

        case SortSection.genre.rawValue:
            sortingByLbl.text = "Genre"

        default:
            print("Invalid Sort Selection")
        
        }
    }
    
    
    @IBAction func pressHereButtonAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
        
    }
    
    
//    func setTotalGameCount() {
//
//
//            let allGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil)
//            totalGameCount = allGames.count
//
//    }

    
}





extension OwnedGamesViewController: UITableViewDelegate, UITableViewDataSource {
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
//        return ownedGames.count
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownedGamesCell", for: indexPath) as? OwnedGamesVCTableViewCell
        print("filterSelections")
        print(genreSelections)
        
        cell?.index = indexPath
//        cell?.game = ownedGames[indexPath.row]
        cell?.delegate = self
        
        switch indexPath.section {
            case 0   :     cell?.game = numericGames[indexPath.row]
            case 1   :     cell?.game = aGames[indexPath.row]
            case 2   :     cell?.game = bGames[indexPath.row]
            case 3   :     cell?.game = cGames[indexPath.row]
            case 4   :     cell?.game = dGames[indexPath.row]
            case 5   :     cell?.game = eGames[indexPath.row]
            case 6   :     cell?.game = fGames[indexPath.row]
            case 7   :     cell?.game = gGames[indexPath.row]
            case 8   :     cell?.game = hGames[indexPath.row]
            case 9   :     cell?.game = iGames[indexPath.row]
            case 10  :     cell?.game = jGames[indexPath.row]
            case 11  :     cell?.game = kGames[indexPath.row]
            case 12  :     cell?.game = lGames[indexPath.row]
            case 13  :     cell?.game = mGames[indexPath.row]
            case 14  :     cell?.game = nGames[indexPath.row]
            case 15  :     cell?.game = oGames[indexPath.row]
            case 16  :     cell?.game = pGames[indexPath.row]
            case 17  :     cell?.game = qGames[indexPath.row]
            case 18  :     cell?.game = rGames[indexPath.row]
            case 19  :     cell?.game = sGames[indexPath.row]
            case 20  :     cell?.game = tGames[indexPath.row]
            case 21  :     cell?.game = uGames[indexPath.row]
            case 22  :     cell?.game = vGames[indexPath.row]
            case 23  :     cell?.game = wGames[indexPath.row]
            case 24  :     cell?.game = xGames[indexPath.row]
            case 25  :     cell?.game = yGames[indexPath.row]
            case 26  :     cell?.game = zGames[indexPath.row]

            default  :     cell?.game = ownedGames[indexPath.row]
        }

        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("outside destination")
        if let destination = segue.destination as? PagingDetailVC {
            print("destination")
            print(destination)
            let index = (tableView.indexPathForSelectedRow?.row)!
            var selectedGame = ownedGames[index]
            
//            let selectedGame : SavedGames?
            if let indexPath = indexPath {
            switch indexPath.section {
            case 0   :    selectedGame = numericGames[indexPath.row]
                case 1   :    selectedGame = aGames[indexPath.row]
                case 2   :    selectedGame = bGames[indexPath.row]
                case 3   :    selectedGame = cGames[indexPath.row]
                case 4   :    selectedGame = dGames[indexPath.row]
                case 5   :    selectedGame = eGames[indexPath.row]
                case 6   :    selectedGame = fGames[indexPath.row]
                case 7   :    selectedGame = gGames[indexPath.row]
                case 8   :    selectedGame = hGames[indexPath.row]
                case 9   :    selectedGame = iGames[indexPath.row]
                case 10  :    selectedGame = jGames[indexPath.row]
                case 11  :    selectedGame = kGames[indexPath.row]
                case 12  :    selectedGame = lGames[indexPath.row]
                case 13  :    selectedGame = mGames[indexPath.row]
                case 14  :    selectedGame = nGames[indexPath.row]
                case 15  :    selectedGame = oGames[indexPath.row]
                case 16  :    selectedGame = pGames[indexPath.row]
                case 17  :    selectedGame = qGames[indexPath.row]
                case 18  :    selectedGame = rGames[indexPath.row]
                case 19  :    selectedGame = sGames[indexPath.row]
                case 20  :    selectedGame = tGames[indexPath.row]
                case 21  :    selectedGame = uGames[indexPath.row]
                case 22  :    selectedGame = vGames[indexPath.row]
                case 23  :    selectedGame = wGames[indexPath.row]
                case 24  :    selectedGame = xGames[indexPath.row]
                case 25  :    selectedGame = yGames[indexPath.row]
                case 26  :    selectedGame = zGames[indexPath.row]

                default  :    selectedGame = ownedGames[indexPath.row]
            }
            }
            let game = createGameObjectFromCoreData(persistedObject: selectedGame)
            
            print("prepare persistedGame = \(game)")
            
            
            destination.game = game
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
        self.performSegue(withIdentifier: "pageVC", sender: self)
        

    }
    
    
    
}

extension OwnedGamesViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)

            
        
            if text == "" {

                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)

            } else {

                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: text, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter,selectedDateRange: dateSelections)
            }
        self.filteredGameCountLbl.text = "\(self.ownedGames.count)"

       
        print(self.ownedGames)
        tableView.reloadData()
    }
    
    
    
}

extension OwnedGamesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: text, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
            
      
        print("search bar search button clicked")
        self.filteredGameCountLbl.text = "\(self.ownedGames.count)"

        tableView.reloadData()
        
        search.dismiss(animated: true) {
            print("search clicked")
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        search.dismiss(animated: true) {
            print("cancel clicked")
        }
        
        
    }
    
    
}


