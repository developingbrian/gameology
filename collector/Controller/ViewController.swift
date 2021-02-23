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


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate, UITableViewDataSource, ViewControllerTableViewCellDelegate, NetworkingDelegate, UISearchBarDelegate{
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        print(text)
////        searchController.searchBar.showsCancelButton = false
//        self.searchText = text
//        // to limit network activity, reload half a second after last key press.
//        if text == "" || text == " " {
//            print("text == \(text)")
//            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
//            self.perform(#selector(self.cancelSearch), with: nil, afterDelay: 4)
//        } else {
//            print("reload called")
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
//            self.perform(#selector(self.reload), with: nil, afterDelay: 4)
//        }
//        
//        
//    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var platformPicker: UIPickerView!
    @IBOutlet weak var tableviewPlatformImage: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var gameDelegate : GameDelegate?
    var search : UISearchController?
    var games = [GDBGamesPlatform]()
    var gameTest : [GDBGamesPlatform]?
//    var game : Game?
    var game: ByPlatformIDData?
    var game1: GDBGamesPlatform?
//    var games = [ByPlatformIDData]()
//    var boxart = [Boxart]()
    var gameImageData = [Images.Inner]()
//        [ByPlatformIDData]()
//    var companies = [Companies]()
//    var platforms = [Platform]()
//    var platform : Platform?
//    var company : Companies?
    var pickerData : [String] = [String]()
    var picked : Int = 18
    var gdbPlatformID : Int = 7
    var imageName = ""
    var gameNamed : String?
    var searchString : String?
    var currentOffset : Int = 0
    //    var currentPlatform : Int?
    var currentGame : String?
    var initialOffset = 0
//    let networking = NetworkService()
    let network = Networking()
    var gradient : CAGradientLayer!
    
    let fields = "players,publishers,genres,overview,last_updated,rating,platform,coop,youtube,os,processor,ram,hdd,video,sound,alternates"
    let include = "boxart,platform"
    let test = Networking()
    var coverImage : UIImage?
    var rearCoverImage : UIImage?
    var pageURL: String?
    var countInt = 0
    var imageArray: [UIImageView] = []
    var imageToArray = UIImageView()
    var gameObject : [GDBGamesPlatform]?
    var cache : NSCache<AnyObject, AnyObject>!
    var rearImageCache : NSCache<AnyObject, AnyObject>!
    var gameCartImageCache : NSCache<AnyObject, AnyObject>!
    var tableData: [AnyObject]!
    var fetchingMore = false
//    let rearImageView: UIImageView
    
//    let test2: ByPlatformIDData
    var segueFrontImageName : String?
    var segueRearImageName : String?
    var savedGames : [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    let persistenceManager = PersistenceManager.shared
    static var savedGameIndex: IndexPath = [0,0]
    static var savedGame = GameObject()
    static var selectedGameIndex : IndexPath = IndexPath(row: 0, section: 0)
    var selectedIndexPath: IndexPath?
    var boxartURL : String?
    var gameID : Int?
    var gameArray : [GameObject]?
    var segueObject : GameObject?
    var segueImage : UIImage?
    var searchText : String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateWithOwnedGames()
    }
    
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("app started")
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        
        
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
//
        

//        deleteAllPlatforms()
        
        
//        let realm = try! Realm()
//        self.network.initialDownload {
//            print("full db downloaded")
//        }
        
         if self.traitCollection.userInterfaceStyle == .light {
        
                tableView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
//            tableView.backgroundColor = UIColor.white
       
              
            } else {
//
//                tableView.backgroundColor = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
                
                tableView.backgroundColor = UIColor.black

        }
        self.showSpinner(onView: self.view)
        self.network.downloadDevelopersJSON {
        print("Developer JSON downloaded")
        
            self.network.downloadPlatformJSON {
                print("platforms downloaded")
//                self.savePlatformToCoreData(7)
                
                self.network.downloadGenreJSON {
             print("Genre JSON downloaded")
             
                    self.network.downloadGamesByGameNameJSON(gameNamed:"", fields: self.fields, filterByPlatformID: "7", include: self.include, pageURL: nil) {
                        self.gameArray = self.network.gameArray
                        let platformImage = self.setPlatformIcon(platformID: self.gameArray?[0].platformID, mode: self.traitCollection.userInterfaceStyle)
                        self.tableviewPlatformImage.image = UIImage(named: platformImage)
                        self.tableView.reloadData()
                        self.removeSpinner()
                    }
//            self.network.downloadGamesByPlatformIDJSON(platformID: 7, fields: self.fields, include: self.include, pageURL: nil) {
//                self.removeSpinner()
//                print("donwloadGamesByPlatformIDJSON Success")
//
//
//    //            for i in 1..<self.network.games.count {
//    //
//    //                self.network.games[i].owned = self.checkForGameInLibrary(title: self.network.games[i].gameTitle, id: self.network.games[i].id!)
//    //            }
//                self.gameArray = self.network.gameArray
//                let platformImage = self.setPlatformIcon(platformID: self.gameArray?[0].platformID, mode: self.traitCollection.userInterfaceStyle)
//                self.tableviewPlatformImage.image = UIImage(named: platformImage)
//                self.tableView.reloadData()
//
//
//
//                              }
            
            
         }
            }

            
            
        }
        
        
        
        
        
        
//        gradient = CAGradientLayer()
//        gradient.frame = 
        
//        searchTextField.borderStyle = .roundedRect
//        var searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
//        searchButton.setTitle( "🔍", for: .normal)
//        searchTextField.rightViewMode = .always
//        searchTextField.rightView = searchButton
//        searchButton.layer.opacity = 0.5
//        searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)
//        searchTextField.layer.shadowOffset = CGSize(width: 5, height: 5)
//        searchTextField.layer.shadowRadius = 5
//        searchTextField.layer.shadowOpacity = 0.1
//        searchTextField.layer.masksToBounds = false
//        searchTextField.clipsToBounds = false
        setForDarkMode()
//        searchButton.backgroundColor = UIColor.black

//        cache.removeAllObjects()
        
        self.cache = NSCache()
        self.rearImageCache = NSCache()
        self.gameCartImageCache = NSCache()
        self.tableData = []
        
        gameObject = network.games
        
//        self.network.games.removeAll()

        
//        self.network.downloadPublishersJSON {
//            print("Publisher JSON downloaded")
//            self.tableView.reloadData()
//        }
        
        self.platformPicker.delegate = self
        self.platformPicker.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.autoresizingMask = .flexibleWidth

        network.delegate = self
        
        

//        self.network.gamesByPlatformID?.data.games.removeAll()
//        games.removeAll()
        
        pickerData = ["NES", "SNES", "Nintendo 64", "Gamecube", "Game Boy", "Gameboy Advance", "Sega Genesis", "Sega CD"]
        
        
       
        
        

       
//        network.downloadGamesByPlatformIDJSON(platformID: 3, fields: fields, include: include, page: nil) { (_, _) -> (Data?, Error?) in
//            
//            
//            print(self.game?.data.games.count)
//            
//            
//            return self.game
//        }
//
//        networking.downloadJSON(platformSelected: 18, gameName: nil, offset: nil) {
//
//            self.tableView.reloadData()
//            print("in")
//
//            print("platform image id is ** \(self.networking.games[0].platforms?[0].versions?[0].platformLogo?.imageID)")
//
//            self.setPlatformIcon()
//
//
//            self.tableView.reloadData()
//
//
//        }
        
       
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    
    
    
    //MARK: TableView Methods
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        game?.data.count
//        return self.network.games.count
//        print("tableview count \(network.games.count)")//        return game!.data.count
//        return (network.games.count)
//        (self.network.gamesByPlatformID?.data.games.count)!
//        return self.networking.games.count
        if gameArray != nil {
            return gameArray!.count
            
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var imageURLStringed: String?
        var gameOwned : Bool?
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.delegate = self
        cell.configureCells()
//
        cell.game = gameArray?[indexPath.row]
        
        
        if let game = gameArray?[indexPath.row] {
            let platformObject = fetchPlatformObject(platformID: game.platformID!)
            cell.platformID = platformObject.id
            cell.platformName = platformObject.name
            
            cell.tableViewGameName.text = game.title
          
            cell.tableViewGenreLabel.text = game.genreDescriptions
          
            if let rating = game.rating {
                cell.tableViewAgeRatingLabel.text = rating
            
            } else {
                cell.tableViewAgeRatingLabel.text = " "
            }
            cell.tableViewCompanyLabel.text = game.developer
            print("release date \(game.releaseDate)")
            cell.tableViewReleaseDateLabel.text = game.releaseDate!
            if let imageFileName = game.boxartFrontImage {
                
                var imageURLString = baseURL.small.rawValue + imageFileName
                cell.loadCoverImageWith(urlString: imageURLString, gameID: game.id!)
                
            }
            
            if let imageFileName = game.boxartRearImage {
                var imageURLString = baseURL.medium.rawValue + imageFileName
                cell.loadRearCoverImageWith(urlString: imageURLString)
                
            }
            cell.addToLibraryButton.tag = indexPath.row

            
            let ownedImage = fetchSaveToLibraryBtnImg(platformID: (cell.platformID)!, owned: true)
            let unownedImage = fetchSaveToLibraryBtnImg(platformID: (cell.platformID)!, owned: false)
            
            if checkForGameInLibrary(name: game.title!, id: game.id!) {
                cell.addToLibraryButton.setImage(UIImage(named: ownedImage), for: .normal)

            } else {
                cell.addToLibraryButton.setImage(UIImage(named: unownedImage), for: .normal)
            }
        }
        
        
        
// 
//        print("boxart data \(network.boxart?.data)")
        
//        cell.tag = indexPath.row
        
        //creating game object
//        var game1 : GDBGamesPlatform?
//        for i in 1..<network.games.count {
//
//            network.games[i].owned = checkForGameInLibrary(network.games[i].gameTitle, network.games[i].id!)
//
//
//            }
        
//        }
        
//        for newGame in network.games {
//
//
//                newGame.owned = checkForGameInLibrary(newGame.gameTitle, newGame.id!)
//
//
//
//        }
//        checkForGameInLibrary(title: "", id: 1)
//        checkForGameInLibrary(title: game1?.gameTitle, id: game1?.id)
//        gameOwned = checkForGameInLibrary(game1?.gameTitle, game1?.id)
//        game1 = network.games[indexPath.row]
//        cell.tag = game1?.id! as! Int
//        print(network.games.count - 1)
//        print(network.page?.next)
//        cell.gameID = (game1?.id)!
//        gameID = game1?.id
//        gameOwned = checkForGameInLibrary(title: "\(game1?.gameTitle)", id: Int((game1?.id)!))
//        print("gameOwned = \(gameOwned)")
//        print("owned? \(game1?.owned)")
//        network.downloadScreenScraperJSON(gameName: game1!.gameTitle) {
//             let boxImages = self.network.gameDetailsSS?.response.jeu.medias.filter({ $0.type == "support-2D" && $0.region == "us"} )
//            if boxImages?.count != 0 {
//            let url = URL(string: (boxImages?[0].url)!)
//
//            cell.gameCartImage.sd_setImage(with: url) { (image, error, cacheType, url) in
//                if (error != nil) {
//                    print("Error, could not download.  Download reason \(error?.localizedDescription)")
//                    
//                } else {
//                    print("Successfully downloaded game cart image from \(url)")
//                    
//                }
//            }
//            
//            }
//            
//            
//        
//        }
//        print(game1?.gameTitle)
//        var testgames = network.games[indexPath.row]
//        if checkForGameInLibrary(title: game1!.gameTitle, id: gameID!) {
//            print("game is in library")
//
//
//            print(testgames.gameTitle)
//            testgames.owned = true
//            game1?.owned = true
//            cell.addToLibraryButton.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
//        } else {
//            print(testgames.gameTitle)
//            testgames.owned = false
//            game1?.owned = false
//            cell.addToLibraryButton.setImage(UIImage(systemName: "rectangle"), for: .normal)
//            print("game is not in library")
//        }
//
//
//        print(network.gamesByPlatformID?.data?.games.count)
////        print("genre = \(game1?.data.games[0].genres)")
//        print("genre = \(game1?.genres)")
//        let genreData = [GenreData]()
//
//        print(network.gameGenreData)
        
        //update the Game Name fields text to be capitialized
//        cell.tableViewGameName.text = game1?.gameTitle

//MARK: Release Date Label
        //Formatting date data to presentable format and setting the release date label
        // the date comes in as yyyy-MM-DD format, and we need to convert to MM-DD-yyyy, so we take the current date string, convert it to a date and then reconvert back to a string in the format we want
        
//        if game1?.releaseDate != nil {
//
//            let gdbDate = game1?.releaseDate
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-DD"
//            dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
//            dateFormatter.locale = NSLocale.current
//
//            let strDate = dateFormatter.date(from: gdbDate!)
//            dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
//            let finalDate = dateFormatter.string(from: strDate!)
//
//            cell.tableViewReleaseDateLabel.text = finalDate
//        }
        
        
        
        
        //Setting the Company label{
//        if game1?.developers != nil {
//        if network.gameDeveloperData["\(game1!.developers![0])"] != nil {
//            let developerText = "\(network.gameDeveloperData["\(game1!.developers![0])"]!.name)"
//            print("developerText = \(developerText)")
//            cell.tableViewCompanyLabel.text = "\(developerText)"
//        } else {
//            cell.tableViewCompanyLabel.text = " "
//        }
//        }
        
        
//        var genreText = " \(network.gameGenreData["\(game1?.genres)"])"
//
//        var genreArray : [String] = []
//        if game1?.genres != nil {
//        for genre in game1!.genres! {
//
//            genreArray.append("\(network.gameGenreData["\(genre)"]!.name)")
//
//        }
        
        
        
//        print(genreArray)
//        cell.tableViewGenreLabel.text = genreArray.joined(separator: " | ")
//
//        }
        
        
        
        //Setting the Age Rating label
//
//        if game1?.rating != nil {
//        cell.tableViewAgeRatingLabel.text = game1?.rating
//        } else {
//            cell.tableViewAgeRatingLabel.text = " "
//            print("Invalid Age Rating")
//
//        }

        
        
        
        
        
//        print("TEST TEST \(network.boxart?.baseURL)")
//        print(network.baseURL)
        
        //retrieving the filename information based on the game id
//
//        var frontImageName : String = ""
//        var backImageName : String = ""
//
//        if network.boxarts["\(game1!.id!)"]?[0].side == .front {
//            print(network.boxarts["\(game1!.id!)"]?[0].filename)
//            frontImageName = network.boxarts["\(game1!.id!)"]?[0].filename as! String
//
//        } else if network.boxarts["\(game1!.id!)"]?[0].side == .back {
//            backImageName = network.boxarts["\(game1!.id!)"]?[0].filename as! String
//
//        }
//
//        if network.boxarts["\(game1!.id!)"]?.count == 2 {
//        if network.boxarts["\(game1!.id!)"]?[1].side == .front {
//            frontImageName = network.boxarts["\(game1!.id!)"]?[1].filename as! String
//
//        } else if network.boxarts["\(game1!.id!)"]?[1].side == .back {
//            backImageName = network.boxarts["\(game1!.id!)"]?[1].filename as! String
//
//        }
//        }
   
        
        
       
        
        //if data exists for the front cover image download it, otherwise show default image
//        if frontImageName != "" {
//
//            //creating image url string
//                   var imageUrlString = network.baseURL!.small + frontImageName
//                    boxartURL = "\(imageUrlString)"
//                    imageURLStringed = imageUrlString
//                   print(imageUrlString)
//                    print("boxartURL = \(boxartURL)")
//                   let imageURL = URL(string: imageUrlString)
//
//
//
//            cell.loadCoverImageWith(urlString: imageUrlString, gameID: (game1?.id)!)
//            cell.tableViewCoverImage.setImageAnimated(imageUrl: imageURL!, placeholderImage: UIImage(named: "noArtNES")!)
//
//              if tableView.indexPath(for: cell) == indexPath {
//            cell.loadCoverImageWith(urlString: imageUrlString)
//            }
//            cell.loadCoverImageWith(urlString: imageUrlString, gameID: (game1?.id)!)
//       SDWebImageManager.shared.loadImage(with: imageURL, options: SDWebImageOptions.highPriority, progress: nil) { (image, data, error, cacheType, downloading, downloadURL) in
//
//                         if let error = error {
//                             print("Error downloading the image \(error.localizedDescription)")
//                         }
//                         else {
//                             print("Successfully downloaded image from \(downloadURL?.absoluteString)")
//                            print("game1.id = \(game1?.id)")
//                            print("cell.tag = \(cell.tag)")
//                         
////                            let edgeColor = image?.edgeColor(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), defaultColor: .black)
////                              cell.tableViewCoverImage.image = image
////
////                            cell.coverImageShadow.image = image
////                            cell.shadowView.image = image
////                            let edgeColor = cell.tableViewCoverImage.image?.edgeColor()
//                            //                            cell.tableViewCoverImage.layer.shadowColor = edgeColor?.cgColor
//                          
//                                
////                                cell.tableViewCoverImage.layer.shadowColor = edgeColor!.cgColor
//                            
//
//                         }
//
//
//
//            }
            
//        } else {
//            cell.tableViewCoverImage.image = UIImage(named: "noArtNES")
//
//        }
        
        
        
        //if data exists for the rear cover image download it, otherwise show default image
        
//        if backImageName != nil {
//
//            var rearImageURLString = network.baseURL!.medium + backImageName
//                    cell.loadRearCoverImageWith(urlString: rearImageURLString)
//
//
//        } else {
//            cell.tableViewCoverRearImage.image = UIImage(named: "noArtNES")
//
//        }

        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Assigning the image at the selected cell to coverImage, so that it may be passed to the DetailViewController to avoid redownloading
        
        print("****DIDSELECTROW in main VC called****")
        let cell = tableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
        print("test \(cell.frontImageName)")
        segueObject = gameArray?[indexPath.row]
//        segueFrontImageName = cell.frontImageName
//        segueRearImageName = cell.rearImageName
        coverImage = cell.tableViewCoverImage.image
        self.gameDelegate?.didSelectRow(row: indexPath as NSIndexPath, game: segueObject!)
        if let VC = UIViewController.self as? DetailViewController {
            VC.game = segueObject!
        }
        
        if let image = cell.tableViewCoverImage.image {
            segueImage = image
        }
        print("segueObject = \(segueObject!)")
        print("seguefrontimagename = \(segueFrontImageName)")
        if cell.tableViewCoverRearImage.image != nil {
        rearCoverImage = cell.tableViewCoverRearImage?.image!
        print(rearCoverImage)
        }
        //Segue to DetailViewController
//        performSegue(withIdentifier: "showDetails", sender: self)
                performSegue(withIdentifier: "paging", sender: self)

        
    }
    
//image
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PagingDetailVC {
//            let cell = tableView.cellForRow(at: <#T##IndexPath#>)
//            destination.frontImageName = segueFrontImageName!
//            destination.backImageName = segueRearImageName!
//            destination.network = network
//            destination.cover = coverImage!
//            destination.rearCover = rearCoverImage
////            destination.cover = tableView.cellForRow(at: IndexPath.row)
//            destination.genre = network.genre
//            destination.games =  network.games[tableView.indexPathForSelectedRow!.row]
//            destination.boxart = network.boxart
//            destination.developerData = network.gameDeveloperData
            destination.game = segueObject!
            destination.boxartImage = segueImage
            destination.network = network
//            destination.boxart = network.boxarts[tableView.indexPathForSelectedRow!.row]
//            destination.frontImageName = frontImageName
//            destination.backImageName = backImageName
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    //MARK:  - Pickerview Functions
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Number of columns of data
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // The number of rows of data
        return pickerData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // The data to return for the row and component (column) that's being passed in
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row), \(component)")
        //Will allow user to choose the preferred console platform and will present a specific image corresponding to the chosen platform.
        
        
        switch row {
        case 0:
            //NES
            //folder image available
            picked = 18
            gdbPlatformID = 7
        //            image.
        case 1:
            //SNES
            //folder image available
            picked = 19
            gdbPlatformID = 6
        case 2:
            //N64
            //folder image available
            picked = 4
            gdbPlatformID = 3
        case 3:
            //GC
            // cd folder image available
            picked = 21
            gdbPlatformID = 2
        case 4:
            //GB
            //folder image available
            picked = 33
            gdbPlatformID = 4
        case 5:
            //GBA
            //folder image available
            picked = 24
            gdbPlatformID = 5
            
        case 6:
            //SG
            //folder image available
            picked = 29
            gdbPlatformID = 18
        case 7:
            //SCD
            //cd folder image available

            picked = 78
            gdbPlatformID = 21
        default:
            print("invalid selection")
        }
//        network.gamesByPlatformID?.data.games.removeAll()
//        self.games.removeAll()
//        self.network.games.removeAll()
        network.gameArray.removeAll()
//        self.gameArray?.removeAll()
        

        self.network.boxart?.data.removeAll()
//        self.networking.games.removeAll()
//        self.tableView.reloadData()
//        network.currentOffset = 0
        
        print("picked = \(gdbPlatformID)")
        
//        self.networking.downloadJSON(platformSelected: gdbPlatformID, gameName: nil, offset: network.currentOffset) {
        self.network.downloadGamesByGameNameJSON(gameNamed: "", fields: fields, filterByPlatformID: "\(gdbPlatformID)", include: include, pageURL: nil) {
            self.setForDarkMode()
            self.gameArray = self.network.gameArray

            
            print("pickerview JSON downloaded")
            
            //setting the platform image name
//            self.setPlatformIcon()
            print(self.gameArray?[0].platformID)
            let platformLogos = self.setPlatformIcon(platformID: self.gameArray?[0].platformID, mode: self.traitCollection.userInterfaceStyle)
            
            self.tableviewPlatformImage.image = UIImage(named: platformLogos)
            //loading the platform image
//            self.tableviewPlatformImage.image = UIImage(named: "\(self.imageName)")
            //            self.networking.games.removeAll()
            self.cache.removeAllObjects()
            self.rearImageCache.removeAllObjects()
            self.tableView.reloadData()
            if self.traitCollection.userInterfaceStyle == .light {
                   
                self.tableView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)

                       } else {

//                self.tableView.backgroundColor = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
//                        
                        self.tableView.backgroundColor = UIColor.black

                   }
            
            print("test after")
            
            
            
            
        }
        
//        self.network.downloadGamesByPlatformIDJSON(platformID: gdbPlatformID, fields: fields, include: include, pageURL: nil) {
//                
//            self.setForDarkMode()
//            self.gameArray = self.network.gameArray
//
//            
//            print("pickerview JSON downloaded")
//            
//            //setting the platform image name
////            self.setPlatformIcon()
//            print(self.gameArray?[0].platformID)
//            let platformLogos = self.setPlatformIcon(platformID: self.gameArray?[0].platformID, mode: self.traitCollection.userInterfaceStyle)
//            
//            self.tableviewPlatformImage.image = UIImage(named: platformLogos)
//            //loading the platform image
////            self.tableviewPlatformImage.image = UIImage(named: "\(self.imageName)")
//            //            self.networking.games.removeAll()
//            self.cache.removeAllObjects()
//            self.rearImageCache.removeAllObjects()
//            self.tableView.reloadData()
//            if self.traitCollection.userInterfaceStyle == .light {
//                   
//                self.tableView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
//                         
//                       } else {
//
//                self.tableView.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)
//
//                   }
//            
//            print("test after")
//        }
        
        print("gamesArray \(network.gamesByPlatformID?.data?.games)")
        
        
    }
    
   


    
    
    //MARK: Button Methods
    
    
    
    @objc func searchButtonPressed(_ sender: UIButton!) {
        //rudimentary search function.  Will take what is entered and run it through the downloadJSON function and return any results
        
        
        
        print("searchButtonPressed")
//        if searchTextField.text != nil {
//            gameNamed = searchTextField.text
//            print("game named \(gameNamed!)")
////            self.network.games.removeAll()
//            self.games.removeAll()
//            self.tableView.reloadData()
////            self.networking.downloadJSON(platformSelected: nil, gameName: gameNamed, offset: 0) {
//                print("search executed")
//                self.tableView.reloadData()
//            }
            
//        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        //clear out the search field
        
//        searchTextField.text = nil
    }
    
    func setForDarkMode() {
        if self.traitCollection.userInterfaceStyle == .light {
                   view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
               platformLabel.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
               platformPicker.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
//            searchTextField.layer.shadowColor = UIColor.black.cgColor
            

                   } else {
                    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
                    view.backgroundColor = darkGray
                    searchBar.backgroundColor = darkGray
                    searchView.backgroundColor = darkGray
                    searchBar.searchBarStyle = .minimal
                    
               platformLabel.backgroundColor = darkGray
               platformPicker.backgroundColor = darkGray
//               searchTextField.layer.shadowColor = UIColor.white.cgColor

               
                   }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            if fetchingMore == false {
                print("end of table")
                beginBatchFetch()
            }
        }
    }
    func beginBatchFetch() {
        fetchingMore = true
        print("fetching data")
        print(network.pages!.next!)
        
        network.downloadGamesByGameNameJSON(gameNamed: nil, fields: nil, filterByPlatformID: nil, include: nil, pageURL: network.pages!.next!) {
            self.gameArray = self.network.gameArray
            print("pagination successful")
            self.fetchingMore = false
            self.tableView.reloadData()
        }
//        network.downloadGamesByPlatformIDJSON(platformID: nil, fields: nil, include: nil, pageURL: network.page?.next) {
//            self.gameArray = self.network.gameArray
//            print("pagination successful")
//            self.fetchingMore = false
//            self.tableView.reloadData()
////            self.network.owned = self.checkForGameInLibrary(<#T##title: String##String#>, <#T##id: Int##Int#>)
//
//                  }
        
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
            
            print("platform object \(platform)")
            print("owned \(cell.game?.owned)")
//            guard let owned = cell.game?.owned else { return }
            print("\(cell.game)")
            let owned = cell.game?.owned
            let ownedImage = fetchSaveToLibraryBtnImg(platformID: cell.platformID!, owned: true)
            let unownedImage = fetchSaveToLibraryBtnImg(platformID: cell.platformID!, owned: false)
            guard let title = cell.game?.title else { return }
            guard let gameID = cell.game?.id else { return }
            if checkForGameInLibrary(name: title, id: gameID) {
                print("owned = \(owned)")
                
            
               
                    
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    let deleteConfirmation = UIAlertAction(title: "Confirm", style: .default) { (action) in
                        
                    
                    
                    cell.addToLibraryButton.setImage(UIImage(named: unownedImage), for: UIControl.State.normal)
                    cell.game?.owned = false
                        self.gameArray?[(indexPath?.row)!].owned = false
                    print(" check for platform in lib")
                    print(cell.platformName!)
                    print(cell.platformID!)
                        print(self.checkForPlatformInLibrary(name: (cell.platformName!), id: Int((cell.platformID!))))
                        if self.checkForPlatformInLibrary(name: cell.platformName!, id: Int((cell.platformID!))) {
                        
                            self.deleteGameFromCoreData()

                        
                            let savedPlatforms = self.persistenceManager.fetch(Platform.self)
//                        var platformCoreData = fetchCoreDataPlatformObject(id: Int((cell.game?.platformID)!))
                        print("saved platforms count = \(savedPlatforms.count)")
                       
                            let existingPlatforms = self.fetchCoreDataPlatformObject(id: cell.platformID!)
                        print("existingPlatforms count = \(existingPlatforms.games?.count)")
                        if existingPlatforms.games!.count < 1 {
//                        if savedPlatforms.count < 1 {
                            self.deletePlatformFromCoreData()
                        }

                       
                    }
//                return
                    
                    
                    }
                    
                    let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved pictures and stats will not be able to be restored.", preferredStyle: .alert)
                    alert.addAction(deleteConfirmation)
                    alert.addAction(cancel)
                    self.present(alert, animated: true) {
                        
                    }
                    
            
            } else {
                print("not owned")
                print(cell.platformName)
                print(cell.platformID)
                guard let title = cell.game?.title, let id = cell.game?.id, let image = cell.tableViewCoverImage.image, let platformName = cell.platformName, let platformID = cell.platformID else { return }
                
                print(platformName)
                print(platformID)
            let imageData = image.jpegData(compressionQuality: 1)
                
            
            ViewController.savedGame.title = title
            ViewController.savedGame.id = id
            ViewController.savedGame.index = indexPath?.row ?? 0
                
            saveGameToCoreData(title, id, imageData!, platform)
            let platformButtonImg = self.fetchSaveToLibraryBtnImg(platformID: platformID, owned: true)
                cell.addToLibraryButton.setImage(UIImage(named: platformButtonImg), for: .normal)
                
                cell.game?.owned = true
                print("cell.game.owned = \(cell.game?.owned)")
                gameArray?[(indexPath?.row)!].owned = true
                
                if let cell = tableView.cellForRow(at: indexPath!) as? ViewControllerTableViewCell {


                let savedGames = persistenceManager.fetch(SavedGames.self)

                for currentGame in savedGames {

                    if currentGame.title == cell.game?.title && currentGame.gameID == (cell.game?.id)! {
                //        platform.id = Int32(platformObject.id)
                //        platform.name = platformObject.name
                //        platform.addToGames(game)
                        print("platform CORE DATA \(platform)")
//                        let existingPlatforms = fetchCoreDataPlatformObject(id: cell.platformID!)
                        let savedPlatform = persistenceManager.fetch(Platform.self)
//                        print("existingPlatforms count = \(existingPlatforms.games?.count)")
//                        if existingPlatforms.games!.count >= 1 {
                        if savedPlatform.count >= 1 {

                        if checkForPlatformInLibrary(name: platformName, id: platformID) {
                            print("Platform already exists--retreiving and adding game to platform")
                            let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
                           
                            existingPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            print("existing platform is \(existingPlatform.games)")
                        }
                        else {
                            print("Platform doesnt exist--creating platform then adding game to platform")
                           savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            
                            print("new platform is \(newPlatform.games)")
                        }
                            
                        } else {
                            print("Platform doesnt exist--creating platform then adding game to platform")
                           savePlatformToCoreData(platformID)
                            let newPlatform = fetchCoreDataPlatformObject(id: platformID)
                            newPlatform.addToGames(currentGame)
                            persistenceManager.save()
                            print("new platform is \(newPlatform.games)")

                        }


                    }
                }



                }
            
            }
            
            }
        
        
        
        
//        }
        
        
//        
//        print("test test test")
//        var testgames = network.games[indexPath!.row]
//        print("gametest /\(gameTest?[indexPath!.row].owned)")
//        
//        if let cell = tableView.cellForRow(at: indexPath!) as? ViewControllerTableViewCell {
//            
//            print("testgames.owned = \(testgames.owned)")
//            print("cell.owned = \(cell.owned)")
////            guard let owned = cell.owned else { return }
////            print("owned = \(cell.owned)")
////            if cell.owned {
//            print(testgames.owned, testgames.gameTitle)
//            print(game1?.owned, game1?.gameTitle)
////            if game1?.owned == false {
//            if testgames.owned == false {
//                
//
//                game1?.owned = true
//                    cell.owned = true
//                    testgames.owned = true
//                    cell.addToLibraryButton.setImage(UIImage(systemName: "checkmark.rectangle"), for: UIControl.State.normal)
//                    print("testgames is now \(testgames.owned!)")
//                    print("adding \(testgames.gameTitle) to library")
//                    print(cell.game?.gameTitle, cell.game?.id)
//                guard let title = cell.game?.gameTitle, let id = cell.game?.id, let image = cell.tableViewCoverImage.image else { return }
//                
//                let imageData = image.jpegData(compressionQuality: .zero)!
//                
//                ViewController.savedGame[0].gameTitle = title
//                ViewController.savedGame[0].id = id
//                ViewController.savedGame[0].index = indexPath?.row ?? 0
//                saveGameToCoreData(title, id, imageData)
//                
//                    
//                    cell.addToLibraryButton.setTitle("test", for: .normal)
//                    network.games[(indexPath?.row)!].owned = true
//                    cell.tableViewGameName.text = "test"
//                
//                return
//            } else {
//                
//                
//                print("removing game from library")
//                game1?.owned = false
//                cell.addToLibraryButton.setImage(UIImage(systemName: "rectangle"), for: .normal)
//                cell.owned = false
//                
//                testgames.owned = false
//                deleteGameFromCoreData()
//            
//            
//            }
//        }
        
        getSavedGames()
        getSavedPlatforms()
        
    }


   // Pagination
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        print("scrollViewDidEndDragging")
//        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
//        {
//            if !isDataLoading{
//                isDataLoading = true
//                self.pageNo=self.pageNo+1
//                self.limit=self.limit+10
//                self.offset=self.limit * self.pageNo
////                loadCallLogData(offset: self.offset, limit: self.limit)
//  network.downloadGamesByPlatformIDJSON(platformID: nil, fields: nil, include: nil, pageURL: network.page?.next) {
//                  print("pagination successful")
//    self.tableView.reloadData()
//
//              }
//            }
//        }
//    }
    
    
//    func downloadImages() {
//        for games in network.boxart[0]! {
//
//            games.
//        if (countInt <= gameObject!.count) {
//
//            var imageToInsert = UIImageView()
//            imageToInsert.loadImage(from: "") {
//                self.countInt = self.countInt + 1
//                self.imageArray.insert(imageToInsert, at: 0)
//                print("Image downloaded. Current count: \(self.imageArray.count)")
//                self.downloadImages()
//            }
//
//        }  else {
//                       print("no more items")
//                           self.countInt = 0
//                                   }
//    }
//
//}

//func setImage() {
//
//
//}
    @objc func reload() {
        self.showSpinner(onView: self.view)
        self.network.gameArray.removeAll()
        self.network.boxart?.data.removeAll()
        print("prints a half second after last key typed")
        network.downloadGamesByGameNameJSON(gameNamed: searchText, fields: self.fields, filterByPlatformID: nil, include: self.include, pageURL: nil) {
            
            self.gameArray = self.network.gameArray
            self.tableView.reloadData()
            self.removeSpinner()
        }
    }
    
    @objc func cancelSearch() {
        print("cancelSearch called")
        
        navigationItem.searchController?.searchBar.showsCancelButton = false
        
        
//        search!.searchBar.showsCancelButton = false
        search!.searchBar.endEditing(true)
//        searchController.searchBar.showsCancelButton = false
//        searchController.searchBar.endEditing(true)
//        self.showSpinner(onView: self.view)
//        self.network.gameArray.removeAll()
//        self.network.boxart?.data.removeAll()
//        print("prints a half second after last key typed")
//
//        network.downloadGamesByGameNameJSON(gameNamed: searchText, fields: self.fields, filterByPlatformID: nil, include: self.include) {
//
//            self.gameArray = self.network.gameArray
//            self.tableView.reloadData()
//            self.removeSpinner()
//        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true

    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.searchBar.endEditing(true)

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBarText = searchBar.text
        if searchBarText == "" {
        self.searchBar.endEditing(true)
        } else if searchBarText == nil {
            self.searchBar.endEditing(true)
        } else {
            
        
        
            self.searchBar.endEditing(true)
        self.showSpinner(onView: self.view)
        self.network.gameArray.removeAll()
        self.network.boxart?.data.removeAll()
        print("prints a half second after last key typed")
            network.downloadGamesByGameNameJSON(gameNamed: searchBarText, fields: self.fields, filterByPlatformID: nil, include: self.include, pageURL: nil) {
            
            self.gameArray = self.network.gameArray
            self.tableView.reloadData()
            self.removeSpinner()
        }
        
    }
    }
    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {
        let platform = PlatformObject(id: network.platforms["\(platformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)

        return platform
        
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
    

    

func setPlatformIcon() {
    //helper function to set the appropriate platform icon when the platform is changed in pickerView
    print("setPlatformIcon()")
    print("platformID \(self.gameArray?[0].platformID)")
    switch gameArray?[0].platformID! {

    case 18:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "NESLogo"
        } else {
            //Dark Mode
            self.imageName = "NESLogoInverse"

        }

    case 19:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "SNESLogo1"
        } else {
            //Dark Mode
            self.imageName = "SNESLogo1Inverse"

        }
    case 4:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "N64Logo"
        } else {
            //Dark Mode
            self.imageName = "N64LogoInverse"

        }
    case 21:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "GCLogo"
        } else {
            //Dark Mode
            self.imageName = "GCLogoInverse"

        }
    case 33:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "GBLogo"
        } else {
            //Dark Mode
            self.imageName = "GBLogoInverse"

        }
    case 24:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "GBALogo"
        } else {
            //Dark Mode
            self.imageName = "gbaLogoInverse"

        }
    case 29:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "SegaGenesisLogo"
        } else {
            //Dark Mode
            self.imageName = "SegaGenesisLogoInverse"

        }
    case 78:
        if self.traitCollection.userInterfaceStyle == .light {
            //Light Mode
            self.imageName = "SegaCDLogo"
        } else {
            //Dark Mode
            self.imageName = "SegaCDLogoInverse"

        }

    default:
        print("Invalid Platform")

    }

}
}
