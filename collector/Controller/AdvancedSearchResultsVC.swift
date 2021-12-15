//
//  AdvancedSearchResultsVC.swift
//  collector
//
//  Created by Brian on 10/29/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

protocol AdvancedSearchBtnDelegate {
    
    func addRemoveBtnPressed(_ sender: AdvancedSearchResultsCell)
}

class AdvancedSearchResultsVC: UIViewController, AdvancedSearchBtnDelegate {
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
        
            for game in gameArray {
                
                
                let titleCleaned = removeLeadingArticle(fromString: game.title!)
            
                print("titleCleaned is", titleCleaned)
                
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
    var name = ""
    var platforms : [String] = []
    var genres : [String] = []
    var years : [Int] = []
    let sectionTitles = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".map(String.init)
    var persistenceManager = PersistenceManager.shared
    var wishList : [WishList] = [WishList]()
    var savedGames: [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGenres: [GameGenre] = [GameGenre]()
    
    
    
    
    @IBOutlet weak var searchResultsLbl: UILabel!
    @IBOutlet weak var searchResultsCount: UILabel!
    
    
    @IBOutlet weak var spinView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.dataSource = self
        tableView.delegate = self
        prepareData()

        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
   setAppearance()
        self.tableView.reloadData()
    }
    
    
    func addRemoveBtnPressed(_ sender: AdvancedSearchResultsCell) {
        
        print("im a button press in the controller")
        
        let indexPath = tableView.indexPath(for: sender)
        
        if let cell = tableView.cellForRow(at: indexPath!) as? AdvancedSearchResultsCell {
            
            guard let title = cell.game?.title else {return}
            guard let gameID = cell.game?.id else {return}
            guard let platformID = cell.game?.platformID else {return}
            
            let platform = fetchPlatformObject(platformID: platformID)
            let unownedImage = fetchAddToButtonIcon(platformID: platformID, owned: false)
            
            if checkForGameInLibrary(name: title, id: gameID, platformID: platformID) {
                //game is in library.  confirm  request then delete
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { action in
                    
                    cell.addRemoveBtn.setImage(UIImage(named: unownedImage), for: .normal)
                    
                    cell.game?.owned = false
                    
                    if self.checkForPlatformInLibrary(name: cell.platformName, id: platformID) {
                        
                        self.deleteGameFromCoreData()
                        
//                        let savedPlatforms = self.persistenceManager.fetch(Platform.self)
                        
                        let existingPlatforms = self.fetchCoreDataPlatformObject(id: platformID)
                        
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
                //game is not owned, save game
                
                
                guard let title = cell.game?.title, let image = cell.portraitImage.image, let platformID = cell.game?.platformID else { return }
                
                
                let platformName = cell.platformName
                
                let imageData = image.jpegData(compressionQuality: 1)!
                
                guard let game = cell.game else {print("game is nil,"); return}
                
                if checkForGameInWishList(name: name, id: gameID) {

                    deleteGameFromWishList(title: name, id: gameID)
                }
                saveGameToCoreData(title, gameID, imageData, platform, game)
                
                let platformButtonImg = self.fetchAddToButtonIcon(platformID: platformID, owned: true)
                cell.addRemoveBtn.setImage(UIImage(named: platformButtonImg), for: .normal)
                cell.game?.owned = true
                
                let savedGames = persistenceManager.fetch(SavedGames.self)
                
                
                for currentGame in savedGames {
                    
                    if currentGame.title == cell.game?.title && currentGame.gameID == (cell.game?.id)! {
                        
                        
                        if let genres = currentGame.genres {
                            
                            
                            for genre in genres {
                                
                                
                                if checkForGenreInLibrary(name: genre) {
                                    
                                    
                                    
                                    let existingGenre = fetchCoreDataGenreObject(name: genre)
                                    currentGame.addToGenreType(existingGenre)
                                    persistenceManager.save()
                                    
                                    
                                    
                                } else {
                                    
                                    saveGenreToCoreData(genreName: genre)
                                    let newGenre = fetchCoreDataGenreObject(name: genre)
                                    currentGame.addToGenreType(newGenre)
                                    persistenceManager.save()
                                    
                                    
                                    
                                    
                                }
                                
  
                            }
                            

                            
                        }
                        
                        
                        
                        let savedPlatform = persistenceManager.fetch(Platform.self)
                        
                        if savedPlatform.count >= 1 {
                        if checkForPlatformInLibrary(name: platformName, id: platformID) {
                            print("Platform already exists--retreiving and adding game to platform")
                            let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
                           
                            existingPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            
                            
                        } else {
                            
                            
                            print("Platform doesnt exist--creating platform then adding game to platform")
                           savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            
                        }
                        
                        
                        
                        } else {
                            
                            print("Platform doesnt exist--creating platform then adding game to platform")
                           savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            
                        }
                    
                        
                        
                    }
                    
                    
                }
                
 
            }
            
            
        }
        

        
        getSavedGames()
        getSavedPlatforms()
        
    
    }
    
    
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
//        print("Checking for game in wishlist")
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
             if savedGame.title == name && savedGame.gameID == id {
//                print("Game is in wishlist")
                return true
        }
          

    }
        
//        print("Game is not in wishlist")
        return false
    
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
    
    func removeLeadingArticle(fromString: String) -> String{
        let articles = ["a ", "an ", "the ", "The ", "A ", "An "]
//        var returnString : String?
        
        for article in articles {
            if fromString.lowercased().hasPrefix(article.lowercased()) {
//                return string.substring(from: string.index(string.startIndex, offsetBy: article.characters.count))
                let articleLength = article.count
                print("articleLength", articleLength)
                let returnString = String(fromString[fromString.index(fromString.startIndex, offsetBy: articleLength)...])
                print("correctedString", returnString)
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
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.aGames.sort() {
            firstGame, secondGame in
        
        
                let title1 = removeLeadingArticle(fromString: firstGame.title!)
                let title2 = removeLeadingArticle(fromString: secondGame.title!)
                return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
        
            }
        
        self.bGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.cGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.dGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.eGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.fGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.gGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.hGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.iGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.jGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        
        self.kGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        
        self.lGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.mGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.nGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.oGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.pGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.qGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.rGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.sGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.tGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        
        self.uGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.vGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.wGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        self.xGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.yGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

            }
        
        self.zGames.sort() {
            firstGame, secondGame in


            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending

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
          


        } else {
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark


        }
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            
            tableView.backgroundColor = lightGray
//            tableView.tableHeaderView?.backgroundColor = lightGray
            view.backgroundColor = lightGray
            navigationController?.view.backgroundColor = .white

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
           tableView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            navigationController?.view.backgroundColor = .black

//            tableView.tableHeaderView?.backgroundColor = darkGray
        }
        
        
    
        
    }
    
    

    func prepareData() {
//        print("title", name)
//        print("platforms", platforms)
//        print("genres", genres)
//        print("years", years)
//        print("preparing data")
        
        var selectedPlatformIDs : [Int] = []
        var selectedGenreIDs : [Int] = []
        
        if platforms.count > 0 {
            for platform in platforms {
                let platformID = formatPrettyPlatformNameToID(platformName: platform)
                selectedPlatformIDs.append(platformID)
                
                
            }
        }
        
            if genres.count > 0 {
                for genre in network.genres {
                    
                    let genreName = genre.name
                    for selectedGenre in genres {
                        
                        if selectedGenre == genreName {
                            if let genreID = genre.id {
                            selectedGenreIDs.append(genreID)
                            } else {
                                print("no valid genre id")
                            }
                        }
                    }
                }
            }
        spinView.isHidden = false
        self.showSpinner(onView: spinView, userInterfaceStyle: traitCollection.userInterfaceStyle)
            
//            var titleIsEmpty = false
//            if title == nil {
//                titleIsEmpty = true
////            }
//            print("title", name)
//            print("platforms", selectedPlatformIDs)
//            print("genres", selectedGenreIDs)
//            print("years", years)
            
            network.fetchAdvancedSearchData(title: name, platforms: selectedPlatformIDs, genres: selectedGenreIDs, yearRange: years) {
                
                self.gameArray = network.searchResultsData
                self.tableView.reloadData()
                self.removeSpinner()
                self.searchResultsCount.text = String(self.gameArray.count)
                self.spinView.isHidden = true
                
                UIView.animate(withDuration: 3) {
                    self.searchResultsLbl.alpha = 1
                    self.searchResultsCount.alpha = 1
                } completion: { complete in
                    
                }

//                print("advanced search data downloaded")
//                print(self.gameArray.count)
//                for game in self.gameArray {
//                    print(game.title)
//                    print(game.platformID)
//
//                }
            }
        }
    }






extension AdvancedSearchResultsVC : UITableViewDelegate, UITableViewDataSource {
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
               }
        else {
            header.contentView.backgroundColor = darkGray
     

        }
        
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "advancedResultsCell", for: indexPath) as! AdvancedSearchResultsCell
        cell.delegate = self
//        print("Gamearray", gameArray[indexPath.row])
//        cell.game = gameArray[indexPath.row]
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
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        print("trailingSwipeActions")
        let cell = tableView.cellForRow(at: indexPath) as? AdvancedSearchResultsCell
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AdvancedSearchResultsCell
        
        let VC = (self.storyboard?.instantiateViewController(identifier: "paging"))! as PagingDetailVC
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

        
        VC.game = cell.game!
        
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
    
    
}
