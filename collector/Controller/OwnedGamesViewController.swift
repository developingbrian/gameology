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
import SDWebImage
import SwiftUI


protocol ModalDelegate {
    func changeValue(value: [String], platformID: Int?)
    
}

protocol AgeRangeDelegate {
    func changeDateRange(dateRange: [Int], platformID: Int?)
}

protocol SearchFilterDelegate {
    func updatePlatformsFilter(platformSelections: [String])
}

class OwnedGamesViewController: UIViewController, ModalDelegate, AgeRangeDelegate, SearchFilterDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var filteredGameCountLbl: UILabel!
    @IBOutlet weak var totalGameCountLbl: UILabel!
    @IBOutlet weak var platformFilterImg: UIImageView!
    @IBOutlet weak var genreFilterImg: UIImageView!
    @IBOutlet weak var releaseDateFilterImg: UIImageView!
    @IBOutlet weak var sortDirectionLbl: UILabel!
    @IBOutlet weak var sortingByLbl: UILabel!
    @IBOutlet weak var noGamesInLibraryView: UIView!
    @IBOutlet weak var gameLibraryImage: UIImageView!
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
   
    var altLayout = true
    var sortDirection : ComparisonResult = .orderedAscending
    var sortBtn = UIButton()
    var segueObject : GameObject?
    let layoutButton = UIButton(type: .system)
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
            
            numericGames.removeAll()
            aGames.removeAll()
            bGames.removeAll()
            cGames.removeAll()
            dGames.removeAll()
            eGames.removeAll()
            fGames.removeAll()
            gGames.removeAll()
            hGames.removeAll()
            iGames.removeAll()
            jGames.removeAll()
            kGames.removeAll()
            lGames.removeAll()
            mGames.removeAll()
            nGames.removeAll()
            oGames.removeAll()
            pGames.removeAll()
            qGames.removeAll()
            rGames.removeAll()
            sGames.removeAll()
            tGames.removeAll()
            uGames.removeAll()
            vGames.removeAll()
            wGames.removeAll()
            xGames.removeAll()
            yGames.removeAll()
            zGames.removeAll()
            
            
            for game in ownedGames {
                
                let titleCleaned = removeLeadingArticle(fromString: game.title!)
                
                if titleCleaned.first.flatMap({ Int(String($0)) }) != nil {
                    numericGames.append(game)
                }
                
                
                if titleCleaned.hasPrefix("A") || titleCleaned.hasPrefix("a") {
                    aGames.append(game)
                }
                
                if titleCleaned.hasPrefix("B") || titleCleaned.hasPrefix("b") {
                    bGames.append(game)
                }
                
                if titleCleaned.hasPrefix("C") || titleCleaned.hasPrefix("c") {
                    cGames.append(game)
                }
                
                if titleCleaned.hasPrefix("D") || titleCleaned.hasPrefix("d") {
                    dGames.append(game)
                }
                
                if titleCleaned.hasPrefix("E") || titleCleaned.hasPrefix("e") {
                    eGames.append(game)
                }
                
                if titleCleaned.hasPrefix("F") || titleCleaned.hasPrefix("f") {
                    fGames.append(game)
                }
                
                if titleCleaned.hasPrefix("G") || titleCleaned.hasPrefix("g") {
                    gGames.append(game)
                }
                
                if titleCleaned.hasPrefix("H") || titleCleaned.hasPrefix("h") {
                    hGames.append(game)
                }
                
                if titleCleaned.hasPrefix("I") || titleCleaned.hasPrefix("i") {
                    iGames.append(game)
                }
                
                if titleCleaned.hasPrefix("J") || titleCleaned.hasPrefix("j") {
                    jGames.append(game)
                }
                
                if titleCleaned.hasPrefix("K") || titleCleaned.hasPrefix("k") {
                    kGames.append(game)
                }
                
                if titleCleaned.hasPrefix("L") || titleCleaned.hasPrefix("l") {
                    lGames.append(game)
                }
                
                if titleCleaned.hasPrefix("M") || titleCleaned.hasPrefix("m") {
                    mGames.append(game)
                }
                
                if titleCleaned.hasPrefix("N") || titleCleaned.hasPrefix("n") {
                    nGames.append(game)
                }
                
                if titleCleaned.hasPrefix("O") || titleCleaned.hasPrefix("o") {
                    oGames.append(game)
                }
                
                if titleCleaned.hasPrefix("P") || titleCleaned.hasPrefix("p") {
                    pGames.append(game)
                }
                
                if titleCleaned.hasPrefix("Q") || titleCleaned.hasPrefix("q") {
                    qGames.append(game)
                }
                
                if titleCleaned.hasPrefix("R") || titleCleaned.hasPrefix("r") {
                    rGames.append(game)
                }
                
                if titleCleaned.hasPrefix("S") || titleCleaned.hasPrefix("s") {
                    sGames.append(game)
                }
                
                if titleCleaned.hasPrefix("T") || titleCleaned.hasPrefix("t") {
                    tGames.append(game)
                }
                
                if titleCleaned.hasPrefix("U") || titleCleaned.hasPrefix("u") {
                    uGames.append(game)
                }
                
                if titleCleaned.hasPrefix("V") || titleCleaned.hasPrefix("v") {
                    vGames.append(game)
                }
                
                if titleCleaned.hasPrefix("W") || titleCleaned.hasPrefix("w") {
                    wGames.append(game)
                }
                
                if titleCleaned.hasPrefix("X") || titleCleaned.hasPrefix("x") {
                    xGames.append(game)
                }
                
                if titleCleaned.hasPrefix("Y") || titleCleaned.hasPrefix("y") {
                    yGames.append(game)
                }
                
                if titleCleaned.hasPrefix("Z") || titleCleaned.hasPrefix("z") {
                    zGames.append(game)
                }
                
            }
            
            sortGameArrays()
            
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
        
        allGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil)
        return allGames.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        altLayout = UserDefaults.standard.bool(forKey: "ownedAltLayout")

        setAppearance()
        setNavigationLogoImage()
        configureNavigationController()
        createSearchController()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        collectionView.register(VCHeaderView.self, forSupplementaryViewOfKind: ViewController.sectionHeaderElementKind, withReuseIdentifier: VCHeaderView.reuseIdentifier)
        collectionView.register(ViewControllerCVTableCell.self  , forCellWithReuseIdentifier: ViewControllerCVTableCell.cellIdentifier)
        collectionView.register(ViewControllerCVCell.self, forCellWithReuseIdentifier: ViewControllerCVCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        
        
        if totalGameCount < 1 {
            
            noGamesInLibraryView.isHidden = false
            noGamesInLibraryView.backgroundColor = .red
            toggleNavigationControllerItems(isGameLibraryEmpty: true)
            
        } else {
            toggleNavigationControllerItems(isGameLibraryEmpty: false)
            
            noGamesInLibraryView.isHidden = true
        }
        
        let entityName = String(describing: SavedGames.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true)
        ]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistenceManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let searchText = search.searchBar.text
        
        if searchText == "" {
            reloadData(byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        } else {
            reloadData(byGameTitle: searchText, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
            
        }
        self.collectionView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAppearance()
        let searchText = search.searchBar.text
        
        if searchText == "" {
            reloadData(byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        } else {
            reloadData(byGameTitle: searchText, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
            
        }
        
        if totalGameCount < 1 {
            
            noGamesInLibraryView.isHidden = false
            
            toggleNavigationControllerItems(isGameLibraryEmpty: true)
            
        } else {
            toggleNavigationControllerItems(isGameLibraryEmpty: false)
            
            noGamesInLibraryView.isHidden = true
            
        }
        
        setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"
        totalGameCountLbl.text = "\(totalGameCount)"
        self.collectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    func reloadData(byGameTitle: String?, platformID: Int?, selectedGenres: [String]?, selectedPlatforms: [Int]?, selectedDateRange: [Int]?) {
        var filterPredicate : NSPredicate?
        var platforms : [Int] = []
        var genres : [String] = []
        var dates : [Int] = []
        var title = ""
        var startYear = 0
        var endYear = 0
        
        if let platform = selectedPlatforms{
            platforms = platform
        }
        if let genre = selectedGenres {
            genres = genre
        }
        
        if let date = selectedDateRange {
            dates = date
            
        }
        if dates.count > 0 {
            startYear = dates.first!
            endYear = dates.last!
        }
        
        if let gameTitle = byGameTitle {
            title = gameTitle
        }
        
        
        
        switch (dates.isEmpty, platforms.isEmpty, genres.isEmpty, byGameTitle == nil) {
            
        case (true, true, true, true):
            // all arrays are empty so we don't filter anything and return all SavedGame objects

            filterPredicate = NSPredicate(value: true)
            
        case (true ,true, false, true):
            // only filter genres

            
            filterPredicate = NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
            
        case (true, false, true, true):
            // only filter platforms

            
            filterPredicate = NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
            
        case (true, false, false, true):
            // filter both genres and platforms

            
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                NSPredicate(format: "%K IN %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
            ])
            
            
        case (true, true, true, false):
            //Filtering by name only
            filterPredicate = NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
            
            
        case (true, true, false, false):
            //filtering by name and genre
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title]),
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
            ])
            
        case (true, false, true, false):
            //filtering by name and platform
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title]),
                NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
            ])
            
        case (true, false, false, false):
            //filtering by name, genre, and platform
            
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title]),
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                NSPredicate(format: "%K IN %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
                
            ])
        case (false, true, true, true):
            //filtering only by date range
            filterPredicate = NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear)
        case (false, false, true, true):
            //filtering by date range and platforms
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
            ])
            
        case (false, false, false, true):
            //filtering by date range, platforms, and genres
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms]),
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
            ])
        case (false, false, false, false):
            //filtering by date range, platforms, genres, and name
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms]),
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
            ])
        case (false, true, false, false):
            //filtering by date range, genres, and name
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
            ])
            
        case (false, true, false, true):
            //filtering by date range and genres
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
            ])
        case (false, true, true, false):
            //filtering by date range and name
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
            ])
        case (false, false, true, false):
            //filtering by date range, platforms, and name
            filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms]),
                NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
            ])
            
            
        }
        
        
        fetchedResultsController.fetchRequest.predicate = filterPredicate
        
        do {
            try fetchedResultsController.performFetch()        }
        
        catch {
            
            fatalError("Error fetching Saved Game objects")
        }
        
        
        ownedGames = fetchedResultsController.fetchedObjects as! [SavedGames]
        collectionView.reloadData()
    }
    
    
    
//    func removeFromLibrary(index: IndexPath) {
//
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { (action) in
//
//
//            self.deleteGameFromCoreData(index: index)
//            self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: self.genreSelections, selectedPlatforms: self.platformsToFilter, selectedDateRange: self.dateSelections))
//
//            if self.ownedGames.count < 1 {
//                self.toggleNavigationControllerItems(isGameLibraryEmpty: true)
//
//                self.noGamesInLibraryView.isHidden = false
//
//            } else {
//                self.toggleNavigationControllerItems(isGameLibraryEmpty: false)
//                self.noGamesInLibraryView.isHidden = true
//            }
//            self.filteredGameCountLbl.text = "\(self.ownedGames.count)"
//            self.totalGameCountLbl.text = "\(self.totalGameCount)"
//            self.collectionView.reloadData()
//        }
//
//        let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved pictures and stats will not be able to be restored.", preferredStyle: .alert)
//
//
//        alert.addAction(deleteConfirmation)
//        alert.addAction(cancel)
//        self.present(alert, animated: true) {
//
//        }
//
//
//    }
    
    
    
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
    
    
    @objc func setLayout() {
        if altLayout == false {
            UserDefaults.standard.set(true, forKey: "ownedAltLayout")
        } else {
            UserDefaults.standard.set(false, forKey: "ownedAltLayout")
        }
        
        
        altLayout = UserDefaults.standard.bool(forKey: "ownedAltLayout")
        
        layoutButton.setImage(altLayout == true ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(setupCollectionViewLayout(), animated: false)
    }
    
    func makeSortButton() -> UIButton {
        let lightBlue = UIColor(red: 43/255, green: 149/255, blue: 206/255, alpha: 1)
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "atoz3")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit), for: .normal)
        backButton.tintColor = lightBlue
        backButton.setTitle("Sort", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        backButton.setTitleColor(lightBlue, for: .normal)
        backButton.addTarget(self, action: #selector(self.sortButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc func sortButtonPressed() {
        
        if sortDirection == .orderedAscending {
            sortDirection = .orderedDescending
            self.sortBtn.setImage(UIImage(named:"ztoa3")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit), for: .normal)
            
        } else {
            
            sortDirection = .orderedAscending
            self.sortBtn.setImage(UIImage(named:"atoz3")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit), for: .normal)
            
        }
        let temp = self.ownedGames
        self.ownedGames.removeAll()
        self.ownedGames = temp
        collectionView.reloadData()
    }
    
    @objc func tap() {
        search.searchBar.endEditing(true)
    }
    
    @objc func backButtonPressed() -> Void {
        
        self.navigationController?.popViewController(animated: false)
        
    }
    
    
    func changeDateRange(dateRange: [Int], platformID: Int?) {
        
        self.dateSelections = dateRange
        self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateRange)
        self.ownedGames = persistenceManager.fetchFilteredByReleaseDate(SavedGames.self, platformID: nil, dateRange: dateRange)
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"
        
        collectionView.reloadData()
        
    }
    
    func changeValue(value: [String], platformID: Int?){
        self.genreSelections = value
        
        let searchText = search.searchBar.text
        if searchText == "" {
            self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        }
        else {
            
            self.ownedGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
            
        }
        
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"
        
        collectionView.reloadData()
        
    }
    
    
    func fetchData() {
        
        let searchText = search.searchBar.text
        if searchText == "" {
            self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections))
        } else {
            self.ownedGames = (self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections))
            
        }
        filteredGameCountLbl.text = "\(ownedGames.count)"
        
        self.collectionView.reloadData()
    }
    
    
    func createGameObjectFromCoreData(persistedObject: SavedGames) -> GameObject {
        
        var screenshots : [ImageInfo] = []
        
        if let persistedScreenshots = persistedObject.screenshotImageIDs {
            for screenshot in persistedScreenshots {
                let imageInfo = ImageInfo(id: nil, alphaChannel: nil, animated: nil, game: nil, height: nil, imageID: screenshot, url: nil, width: nil, checksum: nil)
                
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
        
        if searchText == "" {
            
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        } else {
            
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        }
        self.setFilterIndicators()
        filteredGameCountLbl.text = "\(ownedGames.count)"
        
        collectionView.reloadData()

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
        
        let allPlatforms = network.platforms
        var platformID = 0
        for platform in allPlatforms {
            
            if platform.name == platformName {
                platformID = platform.id
            }
            
        }
        
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
            collectionView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            noGamesInLibraryView.backgroundColor = lightGray
            gameLibraryImage.image = UIImage(named: "gamelibrarynew")
            
            navigationController?.view.backgroundColor = .white
            
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            collectionView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            noGamesInLibraryView.backgroundColor = darkGray
            gameLibraryImage.image = UIImage(named: "gamelibraryinversenew")
            navigationController?.view.backgroundColor = .black
            
            
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
        search.searchBar.placeholder = "Enter game name to search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }
    
    func setNavigationLogoImage() {
        let logo = UIImage(named: "gameologylogo44")
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
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil))!
            } else {
                self?.ownedGames = (self?.persistenceManager.fetchGame(SavedGames.self, byGameTitle: searchText, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil))!
                
            }
            self?.setFilterIndicators()
            self?.filteredGameCountLbl.text = "\(self!.ownedGames.count)"
            
            self?.collectionView.reloadData()
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
            self.network.sourceTag = 5
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
        
        
        let filterMenu = UIMenu(title:"Filter By", image: UIImage(systemName: "ellipsis"), children: [secondAction,thirdAction,fourthAction])
        
        let mainMenu = UIMenu(title: "", children: [firstAction, filterMenu])
        
        var filterButton : UIBarButtonItem?
        
        filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), menu: mainMenu)
        guard let filter = filterButton else { return }
//        sortBtn = makeSortButton()
        
        layoutButton.setImage(altLayout == true ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        layoutButton.addTarget(self, action: #selector(setLayout), for: .touchUpInside)
        let layout = UIBarButtonItem(customView: layoutButton)
        
        
        let sortButton = UIBarButtonItem(customView: sortBtn)
        self.navigationItem.rightBarButtonItems = [filter, layout]
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
    
    
    
    func removeLeadingArticle(fromString: String) -> String{
        let articles = ["a ", "an ", "the ", "The ", "A ", "An "]
        
        for article in articles {
            if fromString.lowercased().hasPrefix(article.lowercased()) {
                
                let articleLength = article.count

                let returnString = String(fromString[fromString.index(fromString.startIndex, offsetBy: articleLength)...])

                return returnString
                
            }
            
        }
        
        return fromString
        
        
    }
    
    
    func sortGameArrays() {
        self.numericGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.aGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.bGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.cGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.dGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.eGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.fGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.gGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.hGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.iGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.jGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        
        self.kGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        
        self.lGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.mGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.nGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.oGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.pGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.qGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.rGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.sGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.tGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        
        self.uGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.vGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.wGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        self.xGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.yGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.zGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
    }
    
    
    @IBAction func pressHereButtonAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
        
    }
    
    
}



extension OwnedGamesViewController : NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let searchText = search.searchBar.text
        
        if searchText == "" {
            reloadData(byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        } else {
            reloadData(byGameTitle: searchText, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
            
        }
        
        let allGames = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil)
        filteredGameCountLbl.text = "\(ownedGames.count)"
        totalGameCountLbl.text = "\(allGames.count)"
        
    }
    
}


extension OwnedGamesViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text == "" {
            
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
            
        } else {
            
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: text, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter,selectedDateRange: dateSelections)
        }
        self.filteredGameCountLbl.text = "\(self.ownedGames.count)"
        
        collectionView.reloadData()
    }
    
    
    
}

extension OwnedGamesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, byGameTitle: text, platformID: nil, selectedGenres: genreSelections, selectedPlatforms: platformsToFilter, selectedDateRange: dateSelections)
        
        self.filteredGameCountLbl.text = "\(self.ownedGames.count)"
        
        collectionView.reloadData()
        
        search.searchBar.endEditing(true)
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        search.searchBar.endEditing(true)
        
    }
    
    
    
    
    
    
}


extension OwnedGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {

        switch title {
            
        case "0-9":
            return IndexPath(item: 0, section: index)
       
        case "A":
            return IndexPath(item: 0, section: index)
        case "B":
        
            return IndexPath(item: 0, section: index)
        case "C":
            return IndexPath(item: 0, section: index)

        case "D":
            return IndexPath(item: 0, section: index)

        case "E":
            return IndexPath(item: 0, section: index)

        case "F":
            return IndexPath(item: 0, section: index)

        case "G":
            return IndexPath(item: 0, section: index)

        case "H":
            return IndexPath(item: 0, section: index)

        case "I":
            return IndexPath(item: 0, section: index)

        case "J":
            return IndexPath(item: 0, section: index)

        case "K":
            return IndexPath(item: 0, section: index)

        case "L":
            return IndexPath(item: 0, section: index)

        case "M":
            return IndexPath(item: 0, section: index)

        case "N":
            return IndexPath(item: 0, section: index)
        case "O":
            return IndexPath(item: 0, section: index)
        case "P":
            return IndexPath(item: 0, section: index)
        case "Q":
            return IndexPath(item: 0, section: index)
        case "R":
            return IndexPath(item: 0, section: index)
        case "S":
            return IndexPath(item: 0, section: index)
        case "T":
            return IndexPath(item: 0, section: index)
        case "U":
            return IndexPath(item: 0, section: index)
        case "V":
            return IndexPath(item: 0, section: index)
        case "W":
            return IndexPath(item: 0, section: index)
        case "X":
            return IndexPath(item: 0, section: index)
        case "Y":
            return IndexPath(item: 0, section: index)
        case "Z":
            return IndexPath(item: 0, section: index)
        default:
            return IndexPath(item: 0, section: index)
            
        }

    }
    
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        var title = createSectionTitles()
        if let numericIndex = title.firstIndex(where: {$0 == "0-9"}) {
            title[numericIndex] = "0"
        }
        return title
        

    }
    
    
    func createSectionTitles()-> [String]
    {
        var sectionTitles : [String] = []

        if numericGames.count > 0 {
            
            sectionTitles.append("0-9")
        }
        if aGames.count > 0 {
            
            sectionTitles.append("A")
        }
        if bGames.count > 0 {
            
            sectionTitles.append("B")
        }
        if cGames.count > 0 {
            
            sectionTitles.append("C")
        }
        if dGames.count > 0 {
            
            sectionTitles.append("D")
        }
        if eGames.count > 0 {
            
            sectionTitles.append("E")
        }
        if fGames.count > 0 {
            
            sectionTitles.append("F")
        }
        if gGames.count > 0 {
            
            sectionTitles.append("G")
        }
        if hGames.count > 0 {
            
            sectionTitles.append("H")
        }
        if iGames.count > 0 {
            
            sectionTitles.append("I")
        }
        if jGames.count > 0 {
            
            sectionTitles.append("J")
        }
        if kGames.count > 0 {
            
            sectionTitles.append("K")
        }
        if lGames.count > 0 {
            
            sectionTitles.append("L")
        }
        if mGames.count > 0 {
            
            sectionTitles.append("M")
        }
        if nGames.count > 0 {
            
            sectionTitles.append("N")
        }
        if oGames.count > 0 {
            
            sectionTitles.append("O")
        }
        if pGames.count > 0 {
            
            sectionTitles.append("P")
        }
        if qGames.count > 0 {
            
            sectionTitles.append("Q")
        }
        if rGames.count > 0 {
            
            sectionTitles.append("R")
        }
        if sGames.count > 0 {
            
            sectionTitles.append("S")
        }
        if tGames.count > 0 {
            
            sectionTitles.append("T")
        }
        if uGames.count > 0 {
            
            sectionTitles.append("U")
        }
        if vGames.count > 0 {
            
            sectionTitles.append("V")
        }
        if wGames.count > 0 {
            
            sectionTitles.append("W")
        }
        if xGames.count > 0 {
            
            sectionTitles.append("X")
        }
        if yGames.count > 0 {
            
            sectionTitles.append("Y")
        }
        if zGames.count > 0 {
            
            sectionTitles.append("Z")
        }
        
        return sectionTitles
//        return sectionTitles.map(String.init)
    
}

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return gameArray.count
        
        
        let titles = createSectionTitles()
        
        
           
                
                switch titles[section] {
                    
                case "0-9":
                    
                    return numericGames.count
                case "A":
                    return  aGames.count
                case "B":
                    return  bGames.count
                case "C":
                    return  cGames.count
                case "D":
                    return  dGames.count
                case "E":
                    return  eGames.count
                case "F":
                    return  fGames.count
                case "G":
                    return  gGames.count
                case "H":
                    return  hGames.count
                case "I":
                    return  iGames.count
                case "J":
                    return  jGames.count
                case "K":
                    return  kGames.count
                case "L":
                    return  lGames.count
                case "M":
                    return  mGames.count
                case "N":
                    return  nGames.count
                case "O":
                    return  oGames.count
                case "P":
                    return  pGames.count
                case "Q":
                    return  qGames.count
                case "R":
                    return  rGames.count
                case "S":
                    return  sGames.count
                case "T":
                    return  tGames.count
                case "U":
                    return  uGames.count
                case "V":
                    return  vGames.count
                case "W":
                    return  wGames.count
                case "X":
                    return  xGames.count
                case "Y":
                    return  yGames.count
                case "Z":
                    return  zGames.count
                default:
                    return 0
                }
        
//        if sortDirection == .orderedAscending {
//            switch section {
//            case 0   :
//                return numericGames.count
//            case 1   :
//                return aGames.count
//            case 2   :
//                return bGames.count
//            case 3   :
//                return cGames.count
//            case 4   :
//                return dGames.count
//            case 5   :
//                return eGames.count
//            case 6   :
//                return fGames.count
//            case 7   :
//                return gGames.count
//            case 8   :
//                return hGames.count
//            case 9   :
//                return iGames.count
//            case 10  :
//                return jGames.count
//            case 11  :
//                return kGames.count
//            case 12  :
//                return lGames.count
//            case 13  :
//                return mGames.count
//            case 14  :
//                return nGames.count
//            case 15  :
//                return oGames.count
//            case 16  :
//                return pGames.count
//            case 17  :
//                return qGames.count
//            case 18  :
//                return rGames.count
//            case 19  :
//                return sGames.count
//            case 20  :
//                return tGames.count
//            case 21  :
//                return uGames.count
//            case 22  :
//                return vGames.count
//            case 23  :
//                return wGames.count
//            case 24  :
//                return xGames.count
//            case 25  :
//                return yGames.count
//            case 26  :
//                return zGames.count
//
//            default  :     return 0
//            }
//        } else {
//            switch section {
//            case 0   :
//                return zGames.count
//            case 1   :
//                return yGames.count
//            case 2   :
//                return xGames.count
//            case 3   :
//                return wGames.count
//            case 4   :
//                return vGames.count
//            case 5   :
//                return uGames.count
//            case 6   :
//
//                return tGames.count
//            case 7   :
//                return sGames.count
//            case 8   :
//                return rGames.count
//            case 9   :
//                return qGames.count
//            case 10  :
//                return pGames.count
//            case 11  :
//                return oGames.count
//            case 12  :
//                return nGames.count
//            case 13  :
//                return mGames.count
//            case 14  :
//                return lGames.count
//            case 15  :
//                return kGames.count
//            case 16  :
//                return jGames.count
//            case 17  :
//                return iGames.count
//            case 18  :
//                return hGames.count
//            case 19  :
//                return gGames.count
//            case 20  :
//                return fGames.count
//            case 21  :
//                return eGames.count
//            case 22  :
//                return dGames.count
//            case 23  :
//                return cGames.count
//            case 24  :
//                return bGames.count
//            case 25  :
//                return aGames.count
//            case 26  :
//                return numericGames.count
//
//            default  :     return 0
//            }
//        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return sectionTitles.count
        
        let sections = createSectionTitles()
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VCHeaderView.reuseIdentifier, for: indexPath) as? VCHeaderView else {
            fatalError("Cannot create header view") }
        
        let titles = createSectionTitles()
        
        switch titles[indexPath.section] {
        case "0-9":
            supplementaryView.indexSection = "0-9"

        case "A":
            supplementaryView.indexSection = "A"
        case "B":
            supplementaryView.indexSection = "B"
        case "C":
            supplementaryView.indexSection = "C"
        case "D":
            supplementaryView.indexSection = "D"
        case "E":
            supplementaryView.indexSection = "E"
        case "F":
            supplementaryView.indexSection = "F"
        case "G":
            supplementaryView.indexSection = "G"
        case "H":
            supplementaryView.indexSection = "H"
        case "I":
            supplementaryView.indexSection = "I"
        case "J":
            supplementaryView.indexSection = "J"
        case "K":
            supplementaryView.indexSection = "K"
        case "L":
            supplementaryView.indexSection = "L"
        case "M":
            supplementaryView.indexSection = "M"
        case "N":
            supplementaryView.indexSection = "N"
        case "O":
            supplementaryView.indexSection = "O"
        case "P":
            supplementaryView.indexSection = "P"
        case "Q":
            supplementaryView.indexSection = "Q"
        case "R":
            supplementaryView.indexSection = "R"
        case "S":
            supplementaryView.indexSection = "S"
        case "T":
            supplementaryView.indexSection = "T"
        case "U":
            supplementaryView.indexSection = "U"
        case "V":
            supplementaryView.indexSection = "V"
        case "W":
            supplementaryView.indexSection = "W"
        case "X":
            supplementaryView.indexSection = "X"
        case "Y":
            supplementaryView.indexSection = "Y"
        case "Z":
            supplementaryView.indexSection = "Z"
        default:
            supplementaryView.indexSection = "-"

        }
        
        
//        switch indexPath.section {
//
//        case 0:
//            supplementaryView.indexSection = "0-9"
//        case 1:
//            supplementaryView.indexSection = "A"
//        case 2:
//            supplementaryView.indexSection = "B"
//        case 3:
//            supplementaryView.indexSection = "C"
//        case 4:
//            supplementaryView.indexSection = "D"
//        case 5:
//            supplementaryView.indexSection = "E"
//        case 6:
//            supplementaryView.indexSection = "F"
//        case 7:
//            supplementaryView.indexSection = "G"
//        case 8:
//            supplementaryView.indexSection = "H"
//        case 9:
//            supplementaryView.indexSection = "I"
//        case 10:
//            supplementaryView.indexSection = "J"
//        case 11:
//            supplementaryView.indexSection = "K"
//        case 12:
//            supplementaryView.indexSection = "L"
//        case 13:
//            supplementaryView.indexSection = "M"
//        case 14:
//            supplementaryView.indexSection = "N"
//        case 15:
//            supplementaryView.indexSection = "O"
//        case 16:
//            supplementaryView.indexSection = "P"
//        case 17:
//            supplementaryView.indexSection = "Q"
//        case 18:
//            supplementaryView.indexSection = "R"
//        case 19:
//            supplementaryView.indexSection = "S"
//        case 20:
//            supplementaryView.indexSection = "T"
//        case 21:
//            supplementaryView.indexSection = "U"
//        case 22:
//            supplementaryView.indexSection = "V"
//        case 23:
//            supplementaryView.indexSection = "W"
//        case 24:
//            supplementaryView.indexSection = "X"
//        case 25:
//            supplementaryView.indexSection = "Y"
//        case 26:
//            supplementaryView.indexSection = "Z"
//        default:
//            supplementaryView.indexSection = ""
//
//        }
        
        
        return supplementaryView
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? PagingDetailVC {
            guard let game = segueObject else { return }
            destination.game = game
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if altLayout {
            let cell = collectionView.cellForItem(at: indexPath) as! ViewControllerCVCell
            segueObject = cell.game
            self.performSegue(withIdentifier: "pageVC", sender: self)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ViewControllerCVTableCell
            segueObject = cell.game
            self.performSegue(withIdentifier: "pageVC", sender: self)
        }

    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let titles = createSectionTitles()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! ViewControllerCVCell
        
        if altLayout {
            
            cell.showPlatformFlag = true

            switch titles[indexPath.section] {
                
            case "0-9":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: numericGames[indexPath.item])
                cell.game = savedGame
            case "A":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: aGames[indexPath.item])
                cell.game = savedGame
            case "B":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: bGames[indexPath.item])
                cell.game = savedGame
            case "C":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: cGames[indexPath.item])
                cell.game = savedGame
            case "D":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: dGames[indexPath.item])
                cell.game = savedGame
            case "E":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: eGames[indexPath.item])
                cell.game = savedGame
            case "F":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: fGames[indexPath.item])
                cell.game = savedGame
            case "G":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: gGames[indexPath.item])
                cell.game = savedGame
            case "H":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: hGames[indexPath.item])
                cell.game = savedGame
            case "I":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: iGames[indexPath.item])
                cell.game = savedGame
            case "J":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: jGames[indexPath.item])
                cell.game = savedGame
            case "K":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: kGames[indexPath.item])
                cell.game = savedGame
            case "L":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: lGames[indexPath.item])
                cell.game = savedGame
            case "M":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: mGames[indexPath.item])
                cell.game = savedGame
            case "N":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: nGames[indexPath.item])
                cell.game = savedGame
            case "O":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: oGames[indexPath.item])
                cell.game = savedGame
            case "P":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: pGames[indexPath.item])
                cell.game = savedGame
            case "Q":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: qGames[indexPath.item])
                cell.game = savedGame
            case "R":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: rGames[indexPath.item])
                cell.game = savedGame
            case "S":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: sGames[indexPath.item])
                cell.game = savedGame
            case "T":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: tGames[indexPath.item])
                cell.game = savedGame
            case "U":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: uGames[indexPath.item])
                cell.game = savedGame
            case "V":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: vGames[indexPath.item])
                cell.game = savedGame
            case "W":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: wGames[indexPath.item])
                cell.game = savedGame
            case "X":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: xGames[indexPath.item])
                cell.game = savedGame
            case "Y":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: yGames[indexPath.item])
                cell.game = savedGame
            case "Z":
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: zGames[indexPath.item])
                cell.game = savedGame
            default:
                let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: aGames[indexPath.item])
                cell.game = savedGame
            }

            return cell

                
            } else {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell", for: indexPath) as! ViewControllerCVTableCell
            cell.showPlatformFlag = true

                
                switch titles[indexPath.section] {
                    
                case "0-9":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: numericGames[indexPath.row])
                    cell.game = savedGame
                case "A":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: aGames[indexPath.row])
                    cell.game = savedGame
                case "B":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: bGames[indexPath.row])
                    cell.game = savedGame
                case "C":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: cGames[indexPath.row])
                    cell.game = savedGame
                case "D":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: dGames[indexPath.row])
                    cell.game = savedGame
                case "E":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: eGames[indexPath.row])
                    cell.game = savedGame
                case "F":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: fGames[indexPath.row])
                    cell.game = savedGame
                case "G":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: gGames[indexPath.row])
                    cell.game = savedGame
                case "H":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: hGames[indexPath.row])
                    cell.game = savedGame
                case "I":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: iGames[indexPath.row])
                    cell.game = savedGame
                case "J":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: jGames[indexPath.row])
                    cell.game = savedGame
                case "K":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: kGames[indexPath.row])
                    cell.game = savedGame
                case "L":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: lGames[indexPath.row])
                    cell.game = savedGame
                case "M":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: mGames[indexPath.row])
                    cell.game = savedGame
                case "N":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: nGames[indexPath.row])
                    cell.game = savedGame
                case "O":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: oGames[indexPath.row])
                    cell.game = savedGame
                case "P":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: pGames[indexPath.row])
                    cell.game = savedGame
                case "Q":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: qGames[indexPath.row])
                    cell.game = savedGame
                case "R":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: rGames[indexPath.row])
                    cell.game = savedGame
                case "S":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: sGames[indexPath.row])
                    cell.game = savedGame
                case "T":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: tGames[indexPath.row])
                    cell.game = savedGame
                case "U":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: uGames[indexPath.row])
                    cell.game = savedGame
                case "V":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: vGames[indexPath.row])
                    cell.game = savedGame
                case "W":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: wGames[indexPath.row])
                    cell.game = savedGame
                case "X":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: xGames[indexPath.row])
                    cell.game = savedGame
                case "Y":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: yGames[indexPath.row])
                    cell.game = savedGame
                case "Z":
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: zGames[indexPath.row])
                    cell.game = savedGame
                default:
                    let savedGame = persistenceManager.convertSavedGameToGameObject(savedGame: aGames[indexPath.row])
                    cell.game = savedGame
                }

                return cell

            }
            
         
    }
  
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
           
            if self.altLayout {
                return self.setupAltLayout()
            } else {
                return self.setupTableviewLayoutSection()
            }
            
        }
        
        return layout
    }
    
    
    fileprivate func setupAltLayout() -> NSCollectionLayoutSection {
        var itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(163), heightDimension: .fractionalHeight(1.0))
        
        itemSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - 22.5), heightDimension: .absolute(325))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(0)
        group.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ViewController.sectionHeaderElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    
    fileprivate func setupTableviewLayoutSection() -> NSCollectionLayoutSection {
        var itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        if self.view.frame.width > 429 {
             itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))

        }
                
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - 27.5), heightDimension: .absolute(223))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ViewController.sectionHeaderElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    
    
    
}
