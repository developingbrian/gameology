//
//  WishlistVC.swift
//  collector
//
//  Created by Brian on 1/27/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import SPAlert
import CoreData
import SwiftUI

protocol WishlistDelegate {
    func didPressManageButton(_ sender: WishlistCollectionViewCell)
}

class WishlistVC: UIViewController {
    
    
    @IBOutlet weak var clickHereButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var clickHerePlusButton: UIButton!
    @IBOutlet weak var noGamesInWishlistView: UIView!
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
    let persistenceManager = PersistenceManager.shared
    var wishlist : [WishList] = []
    var network = Networking.shared
    var items : [String] = []
    var images : [UIImage?] = []
    var platforms : [String] = []
    var platform : [WishList] = []
    var savedGenres : [GameGenre] = []
    var sectionArray : [SectionData] = []
    
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    private var itemsPerRow = 3
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let entityName = String(describing: WishList.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true)
        ]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistenceManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        //        items = wishlist[0].platformName
        //        wishlistCollectionView.dataSource = self
        //        wishlistCollectionView.delegate = self
        setupCollectionView()
        reloadData()
        
        //        loadImages()
        
        //        wishlistCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        setAppearance()
        reloadData()
        
        self.collectionView.reloadData()
        
        toggleNoGamesView()
        
    }
    
    
    func reloadData() {
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            fatalError("Error fetching Wishlist objects")
        }
        wishlist = fetchedResultsController.fetchedObjects as! [WishList]
        
        items = wishlist.map({$0.platformName!})
        
        platforms = wishlist.map( {$0.platformName!} )
        
        platforms.removeDuplicates()
        platforms.sort {
            
            $0 < $1
        }
        createSectionData()
        
        self.collectionView.reloadData()
    }
    
    
    func getPlatformImage(platformName: String, mode: UIUserInterfaceStyle) -> UIImage {
        
        let platformID = changePlatformNameToID(platformName: platformName)
        
        let platformIcon = setPlatformIcon(platformID: platformID, mode: mode)
        
        guard let platformImage = UIImage(named: platformIcon) else { fatalError("no platform icon was found") }
        
        return platformImage
    }
    
    
    @IBAction func clickHereAction(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 1
        
    }
    
    
}


extension WishlistVC : NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        reloadData()
    }
}

extension WishlistVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var noOfCellsInRow = 0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            //           iPad
            noOfCellsInRow = 5
            
        }else{
            //           not iPad
            noOfCellsInRow = 3
        }
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: Int(Double(size) * 1.75) )
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PagingDetailVC {
            
            guard let cell = sender as? WishlistCollectionViewCell else {
                return // or fatalError() or whatever
            }
            
            
            if let selectedGame = cell.game {
                let game = fetchGameObject(wishlistObject: selectedGame)
                
                destination.game = game
            }
            
            
        }
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if sectionArray[section].isOpen {
            
            return sectionArray[section].game.count
            
        } else {
            
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "WishlistHeader",
                for: indexPath) as? WishlistHeaderView
        else {
            fatalError("Invalid view type")
        }
        
        headerView.indexPath = indexPath
        
        headerView.platformName = platforms[indexPath.section]
        
        headerView.sectionHeaderDelegate = self
        
        
        headerView.section = sectionArray[indexPath.section]
        
        
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wishlistCell", for: indexPath) as! WishlistCollectionViewCell
        
        cell.wishlistDelegate = self
        
        if sectionArray.count > 0 {
            
            cell.game = sectionArray[indexPath.section].game[indexPath.item]
        }
        
        cell.layoutIfNeeded()
        
        return cell
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return platforms.count
        
    }
    
}

extension WishlistVC: SectionHeaderDelegate {
    
    
    func didPressButton(isOpen: Bool, section: Int) {
        
        let open = sectionArray[section].isOpen
        sectionArray[section].isOpen = !open
        
        let indexSet = IndexSet(integer: section)
        self.collectionView.reloadSections(indexSet)
        
    }
    
}

extension WishlistVC {
    
    func loadImages() {
        let boxarturls = wishlist.map( {$0.boxartImageURL})
        
        
        var imageArray : [UIImage] = []
        
        for url in boxarturls {
            let imageURL = URL(string: ImageURL.medium.rawValue + url!)
            
            SDWebImageManager.shared.loadImage(with: imageURL, options: SDWebImageOptions.highPriority, progress: nil) { (image, data, error, cacheType, downloading, downloadURL) in
                
                if let error = error {
                    print("error", error)
                } else {
                    imageArray.append(image!)
                    self.images.append(contentsOf: imageArray)
                }
            }
        }
        self.collectionView.reloadData()
        
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let lightGray = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
        collectionView.backgroundColor = lightGray
        
        self.title = "Wishlist"
        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }
    
    func createSectionData() {
        let openSections = sectionArray.filter { $0.isOpen == true }
        
        sectionArray.removeAll()
        for platform in platforms {
            let gamesByPlatform = wishlist.filter( {$0.platformName == "\(platform)" } )
            var gameSection = SectionData(isOpen: false, game: gamesByPlatform, platformName: platform)
            if sectionArray.contains(where: { $0.game == gamesByPlatform }) {
                
                
            } else {
                
                if openSections.contains(where: {$0.platformName == platform}) {
                    
                    gameSection = SectionData(isOpen: true, game: gamesByPlatform, platformName: platform)
                    
                }
                
                
                sectionArray.append(gameSection)
                
            }
            
        }
        
    }
    
    
    
    
}


extension WishlistVC : WishlistDelegate{
    
    func didPressManageButton(_ sender: WishlistCollectionViewCell) {
        let wishlistAction = UIAlertAction(title: "Remove from Wishlist", style: .default) { (action) in
            
            let indexPath = self.collectionView.indexPath(for: sender)!
            
            guard let title = self.sectionArray[indexPath.section].game[indexPath.item].title else { return }
            let gameID = self.sectionArray[indexPath.section].game[indexPath.item].gameID
            let id = Int(gameID)
            
            if self.checkForGameInWishList(name: title, id: id) {
                
                self.deleteGameFromWishList(title: title, id: id)
                self.wishlist = self.persistenceManager.fetch(WishList.self)
                
                self.platforms = self.wishlist.map( {$0.platformName!} )
                
                self.platforms.removeDuplicates()
                self.platforms.sort {
                    
                    $0 < $1
                }
                self.createSectionData()
                
            }
            
            let image = UIImage(systemName: "trash.circle")!
            let alertView = SPAlertView(title: "Game successfully removed from wishlist.", preset: .custom(image))
            alertView.present(haptic: .success) {
                
            }

            
            self.toggleNoGamesView()
            
            self.collectionView.reloadData()
            
            
        }
        
        let libraryAction = UIAlertAction(title: "Add to Library", style: .default) { (alert) in
            //Respond to selection
            let indexPath = self.collectionView.indexPath(for: sender)!
            let game = self.sectionArray[indexPath.section].game[indexPath.item]
            guard let name = game.title else { return }
            let id = Int(game.gameID)
            let platform = self.fetchPlatformObject(platformID: Int(game.platformID))
            let platformName = platform.name
            let platformID = platform.id
            
            self.saveGameToCoreData(game: game)
            
            let savedGames = self.persistenceManager.fetch(SavedGames.self)
            
            for currentGame in savedGames {
                
                if currentGame.title == name && currentGame.gameID == Int32(id) {
                    
                    if let genres = currentGame.genres {
                        
                        for genre in genres {
                            
                            if self.checkForGenreInLibrary(name: genre) {
                                //genre exists-retrieving and adding to game
                                let existingGenre = self.fetchCoreDataGenreObject(name: genre)
                                currentGame.addToGenreType(existingGenre)
                                self.persistenceManager.save()
                                
                            } else {
                                //genre doesnt exist, creating and then adding to game
                                self.saveGenreToCoreData(genreName: genre)
                                
                                let newGenre = self.fetchCoreDataGenreObject(name: genre)
                                currentGame.addToGenreType(newGenre)
                                self.persistenceManager.save()
                            }
                            
                            
                        }
                        
                    }
                    
                    let savedPlatform = self.persistenceManager.fetch(Platform.self)
                    
                    if savedPlatform.count >= 1 {
                        
                        if self.checkForPlatformInLibrary(name: platformName, id: platformID) {
                            
                            let existingPlatform = self.fetchCoreDataPlatformObject(id: platformID)
                            existingPlatform.addToGames(currentGame)
                            self.persistenceManager.save()
                            
                        } else {
                            
                            self.savePlatformToCoreData(platformID)
                            let newPlatform = self.fetchCoreDataPlatformObject(id: platformID)
                            newPlatform.addToGames(currentGame)
                            self.persistenceManager.save()
                            
                        }
                    }
                    else {
                        self.savePlatformToCoreData(platformID)
                        let newPlatform = self.fetchCoreDataPlatformObject(id: platformID)
                        newPlatform.addToGames(currentGame)
                        self.persistenceManager.save()
                        
                    }
                    
                    
                }
            }
            
            if self.checkForGameInWishList(name: name, id: id) {
                
                self.deleteGameFromWishList(title: name, id: id)
                self.wishlist = self.persistenceManager.fetch(WishList.self)
                
                self.platforms = self.wishlist.map( {$0.platformName!} )
                
                self.platforms.removeDuplicates()
                self.platforms.sort {
                    
                    $0 < $1
                }
                self.createSectionData()
                
            }
            
            let alertView = SPAlertView(title: "Success!!\nGame has been added to your library.\nIt will now be removed from your wishlist.", preset: .done)
//            alertView.present(duration: 3)
            alertView.present(haptic: .success) {
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.75) {
                self.toggleNoGamesView()
                
                self.collectionView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            
        }
        
        let alertController = UIAlertController(title: "Wishlist Management", message: "Please make a selection.\n Note:\n  Adding a game to your library will remove it from your wishlist.", preferredStyle: .alert)
        alertController.addAction(libraryAction)
        
        alertController.addAction(wishlistAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            
        }
    }
    
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
        
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
            if savedGame.title == name && savedGame.gameID == id {
                
                return true
            }
            
            
        }
        
        return false
        
    }
    
    
    func deleteGameFromWishList(title: String, id: Int) {
        
        let savedGames = persistenceManager.fetch(WishList.self)
        for currentGame in savedGames {
            
            if currentGame.title == title && currentGame.gameID == id {
                
                persistenceManager.delete(currentGame)
                persistenceManager.save()
            }
        }
        
    }
    
    
    func saveGameToCoreData(game: WishList) {
        let persistedGame = SavedGames(context: persistenceManager.context)
        
        persistedGame.title = game.title
        persistedGame.gameID = game.gameID
        persistedGame.overview = game.overview
        persistedGame.boxartImage = game.boxartImage
        persistedGame.owned = true
        persistedGame.releaseDate = game.releaseDate
        persistedGame.releaseYear = game.releaseYear
        persistedGame.rating = game.rating
        persistedGame.boxartImageURL = game.boxartImageURL
        persistedGame.screenshotImageIDs = game.screenshotImageIDs
        persistedGame.developerName = game.developerName
        persistedGame.platformName = game.platformName
        persistedGame.platformID = game.platformID
        persistedGame.maxPlayers = game.maxPlayers
        persistedGame.genre = game.genre
        persistedGame.genres = game.genres
        persistedGame.totalRating = game.totalRating
        persistedGame.userRating = game.userRating
        persistedGame.youtubeURL = game.youtubeURL
        
        persistenceManager.save()
        
        
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
    
    func fetchGameObject(wishlistObject: WishList) -> GameObject {
        
        var screenshots : [ImageInfo] = []
        
        if let screenshotImages = wishlistObject.screenshotImageIDs {
            for screenshot in screenshotImages {
                let screenshot = ImageInfo(id: nil, alphaChannel: nil, animated: nil, game: nil, height: nil, imageID: screenshot, url: nil, width: nil, checksum: nil)
                screenshots.append(screenshot)
            }
        }
        
        let game = GameObject(
            title: wishlistObject.title,
            id: Int(wishlistObject.gameID),
            overview: wishlistObject.overview,
            boxartFrontImage: wishlistObject.boxartImageURL,
            boxartHeight: Int(wishlistObject.boxartHeight),
            boxartWidth: Int(wishlistObject.boxartWidth),
            boxartRearImage: nil,
            fanartImage: nil,
            rating: wishlistObject.rating,
            releaseDate: wishlistObject.releaseDate ,
            owned: false,
            index: nil,
            screenshots: screenshots,
            developerIDs: nil,
            genreIDs: nil,
            pusblisherIDs: nil,
            youtubePath: wishlistObject.youtubeURL,
            platformID: Int(wishlistObject.platformID),
            maxPlayers: wishlistObject.maxPlayers,
            genreDescriptions: wishlistObject.genre,
            genres: wishlistObject.genres,
            developer: wishlistObject.developerName,
            gamePhotos: nil,
            manualPhotos: nil,
            boxPhotos: nil,
            totalRating: Int(wishlistObject.totalRating),
            userRating: Int(wishlistObject.userRating))
        
        
        return game
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
            noGamesInWishlistView.backgroundColor = lightGray
            navigationController?.view.backgroundColor = .white
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            collectionView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            noGamesInWishlistView.backgroundColor = darkGray
            navigationController?.view.backgroundColor = .black
            
        }
        
    }
    
    func toggleNoGamesView() {
        
        if wishlist.count < 1 {
            
            noGamesInWishlistView.isHidden = false
        } else {
            noGamesInWishlistView.isHidden = true
        }
    }
    
    
}
