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
    
    let persistenceManager = PersistenceManager.shared
    var ownedGames: [SavedGames] = [SavedGames]()
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

    var totalGameCount : Int {
        
        let allGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil)
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
                self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self.sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: self.genreSelections, selectedPlatforms: self.platformsToFilter))
                
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
        self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)
        }
        else {
            
            self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)

        }
 
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"

        tableView.reloadData()

        print("modal delegate filter selections \(self.genreSelections)")
    }
    
    
    func fetchData() {
        
        let searchText = search.searchBar.text
        if searchText == "" {
        self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self.sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter))
        } else {
            self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self.sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter))

        }
        filteredGameCountLbl.text = "\(ownedGames.count)"

        
        self.tableView.reloadData()
//        gamesInPlatformLbl.text = "Total Owned Games"
    }
    
    
    func createGameObjectFromCoreData(persistedObject: SavedGames) -> GameObject {
        print("persisted object \(persistedObject)")
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
            boxPhotos: nil)
        
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
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)
        } else {
            print("genreSelections", genreSelections)
            print("platformsToFilter", platformsToFilter)
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)
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
            let searchText = self?.search.searchBar.text
            if searchText == "" {
            self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil))!
            } else {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil))!

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
                    self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter))!}
                else {
                    self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter))!}

            self?.setSortLabels()

            self?.tableView.reloadData()

            
        }
        
        let sortByReleaseDate = UIAction(title: "Sort by Release Date", image: UIImage(systemName: "calendar")) { [weak self] action in
            
            self?.sortSelection = SortSection.releaseDate.rawValue
            let searchText = self?.search.searchBar.text

            if searchText == "" {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter))! }
            else {
                
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter))!

            }

         
            self?.setSortLabels()

            self?.tableView.reloadData()

            
        }
        
        let sortByPlatform = UIAction(title: "Sort by Platform", image: UIImage(systemName: "gamecontroller")) { [weak self] action in
            
            self?.sortSelection = SortSection.platformName.rawValue
            let searchText = self?.search.searchBar.text

            if searchText == "" {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter))! }
            else {
                
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, sortBy: self?.sortSelection, sortByAscending: self!.asecending, platformID: nil, selectedGenres: self?.genreSelections, selectedPlatforms: self?.platformsToFilter))!

                
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
        
        if #available(iOS 14.0, *) {
             filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), menu: mainMenu)
            
        } else {
            // Fallback on earlier versions
        }
        var sortButton : UIBarButtonItem?
        if #available(iOS 14.0, *) {
             sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), menu: sortMenu)
        } else {
            // Fallback on earlier versions
        }
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
    
    
//    func setTotalGameCount() {
//
//
//            let allGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: asecending, platformID: nil, selectedGenres: nil, selectedPlatforms: nil)
//            totalGameCount = allGames.count
//
//    }

    
}





extension OwnedGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownedGamesCell", for: indexPath) as? OwnedGamesVCTableViewCell
        print("filterSelections")
        print(genreSelections)
        
        cell?.index = indexPath
        cell?.game = ownedGames[indexPath.row]
        cell?.delegate = self


        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("outside destination")
        if let destination = segue.destination as? PagingDetailVC {
            print("destination")
            print(destination)
            let index = (tableView.indexPathForSelectedRow?.row)!
            let selectedGame = ownedGames[index]
         
            let game = createGameObjectFromCoreData(persistedObject: selectedGame)
            
            print("prepare persistedGame = \(game)")
            
            
            destination.game = game
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        

    }
    
    
    
}

extension OwnedGamesViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        
            if text == "" {

                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)

            } else {

                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: text, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)
            }
        self.filteredGameCountLbl.text = "\(self.ownedGames.count)"

       
        print(self.ownedGames)
        tableView.reloadData()
    }
    
    
    
}

extension OwnedGamesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: text, sortBy: sortSelection, sortByAscending: self.asecending, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter)
            
      
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


