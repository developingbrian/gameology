//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var platformPicker: UIPickerView!
    @IBOutlet weak var tableviewPlatformImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    
    var games = [Game]()
//    var game : Game?
    var game: ByPlatformIDData?
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
    var frontImageName : String = ""
    var backImageName : String = ""
    
    let fields = "players,publishers,genres,overview,last_updated,rating,platform,coop,youtube,os,processor,ram,hdd,video,sound,alternates"
    let include = "boxart,platform"
    let test = Networking()
    var coverImage : UIImage?
    var pageURL: String?
    var countInt = 0
    var imageArray: [UIImageView] = []
    var imageToArray = UIImageView()
    var gameObject : [GDBGamesPlatform]?
    var cache : NSCache<AnyObject, AnyObject>!
    var tableData: [AnyObject]!
    
//    let test2: ByPlatformIDData
    
    
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        games.removeAll()
//        cache.removeAllObjects()
        
        self.cache = NSCache()
        self.tableData = []
        
        gameObject = network.games
        
        self.network.games.removeAll()

        self.network.downloadDevelopersJSON {
            print("Developer JSON downloaded")
            self.tableView.reloadData()
               }
//        self.network.downloadPublishersJSON {
//            print("Publisher JSON downloaded")
//            self.tableView.reloadData()
//        }
        
        self.platformPicker.delegate = self
        self.platformPicker.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
//        self.network.gamesByPlatformID?.data.games.removeAll()
//        games.removeAll()
        
        pickerData = ["NES", "SNES", "Nintendo 64", "Gamecube", "Game Boy", "Gameboy Advance", "Sega Genesis", "Sega CD"]
        
        self.network.downloadGenreJSON {
            print("Genre JSON downloaded")
        }
       
        
        
        network.downloadGamesByPlatformIDJSON(platformID: 7, fields: fields, include: include, pageURL: nil) {
            print(self.test.gamesByPlatformID?.data?.games.count)
            print(self.network.gamesData?.data?.games.count)
            self.tableView.reloadData()
                              print("donwloadGamesByPlatformIDJSON Success")
//            self.setPlatformIcon()
            let platformImage = self.setPlatformIcon(platformID: self.network.games[0].platform, mode: self.traitCollection.userInterfaceStyle)
            self.tableviewPlatformImage.image = UIImage(named: platformImage)
            
            self.tableView.reloadData()

//            Return Data
                          }
       
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
        print("tableview count \(network.games.count)")//        return game!.data.count
        return (network.games.count)
//        (self.network.gamesByPlatformID?.data.games.count)!
//        return self.networking.games.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //creating game object
        let game1 : GDBGamesPlatform?
        game1 = network.games[indexPath.row]
//        gameObject = game1
//        print("tableview gameobject title = \(gameObject?.gameTitle)")
        games.removeAll()
        print(network.games.count - 1)
        print(network.page?.next)
        if indexPath.row == (network.games.count - 1) && network.page?.next != nil {
            pageURL = network.page?.next
            print("pagination, bitches!! \(pageURL)")
            
            network.downloadGamesByPlatformIDJSON(platformID: nil, fields: nil, include: nil, pageURL: network.page?.next) {
                print("pagination successful")
                tableView.reloadData()
                
            }
        }
        
        
        
        
//        game1 = self.network.games[indexPath.row]
//        game1 = game?.data[indexPath.row]
//        game1 = network.gamesByPlatformID?.data.games.[indexPath.row].
        
        print(network.gamesByPlatformID?.data?.games.count)
//        print("genre = \(game1?.data.games[0].genres)")
        print("genre = \(game1?.genres)")
        let genreData = [GenreData]()
        
        print(network.gameGenreData)
        
        //update the Game Name fields text to be capitialized
        cell.tableViewGameName.text = game1?.gameTitle

//MARK: Release Date Label
        //Formatting date data to presentable format and setting the release date label
        // the date comes in as yyyy-MM-DD format, and we need to convert to MM-DD-yyyy, so we take the current date string, convert it to a date and then reconvert back to a string in the format we want
        
        if game1?.releaseDate != nil {
           
            var gdbDate = game1?.releaseDate
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-DD"
            dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            
            let strDate = dateFormatter.date(from: gdbDate!)
            dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
            let finalDate = dateFormatter.string(from: strDate!)
            
            cell.tableViewReleaseDateLabel.text = finalDate
        }
        
        
        
        
        print("developers = \(game1!.developers![0])")
        //Setting the Company label{
        if network.gameDeveloperData["\(game1!.developers![0])"] != nil {
            var developerText = "\(network.gameDeveloperData["\(game1!.developers![0])"]!.name)"
//        if game1.involvedCompanies?[0].company?.name != nil {
            print("developerText = \(developerText)")
            cell.tableViewCompanyLabel.text = "\(developerText)"
//            involvedCompanies?[0].company?.name
        } else {
            cell.tableViewCompanyLabel.text = " "
        }
//        var genreHolder = genreData["\(game1?.genres)"]
        
        var genreText = " \(network.gameGenreData["\(game1?.genres)"])"
//        network.games[indexPath.row].gameTitle
//        var genreText = genreHolder["\(game1.data.games[0].genres)"]?.name
//        var genreText = genreHolder["\(game1?.genres)"]
        
        //Setting the Genere label
//        game1.data.games[0].
//        cell.tableViewGenreLabel.text = game1?.genres?.compactMap { $0.name }.joined(separator: " / ")
        var genreArray : [String] = []
        if game1?.genres != nil {
        for genre in game1!.genres! {
            
            genreArray.append("\(network.gameGenreData["\(genre)"]!.name)")
            
        }
        
        
        
        print(genreArray)
        cell.tableViewGenreLabel.text = genreArray.joined(separator: " | ")
        
        }
        //Setting the Age Rating label
        if game1?.rating != nil {
        cell.tableViewAgeRatingLabel.text = game1?.rating
        } else {
            cell.tableViewAgeRatingLabel.text = " "
            print("Invalid Age Rating")
            
        }

        
        //Used to download the image file
        
//        func setCoverImage(from url: String) {
//            print("setCoverImage()")
//
//
//            guard let imageURL = URL(string: url) else { return }
//
//            // just not to cause a deadlock in UI!
//            DispatchQueue.global().async {
//                guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//                let image = UIImage(data: imageData)
//                DispatchQueue.main.async {
//                    cell.tableViewCoverImage.image = image
//                }
//            }
//        }
        
        //retrieving the filename information based on the game id
        if network.boxart?.data["\(game1!.id!)"]?[0].side == .front {
            print(network.boxart?.data["\(game1!.id!)"]?[0].filename)
            frontImageName = network.boxart?.data["\(game1!.id!)"]?[0].filename as! String
            
        } else if network.boxart?.data["\(game1!.id!)"]?[0].side == .back {
            backImageName = network.boxart?.data["\(game1!.id!)"]?[0].filename as! String
            
        }
        
        if network.boxart?.data["\(game1!.id!)"]?.count == 2 {
        if network.boxart?.data["\(game1!.id!)"]?[1].side == .front {
            frontImageName = network.boxart?.data["\(game1!.id!)"]?[1].filename as! String
                       
        } else if network.boxart?.data["\(game1!.id!)"]?[1].side == .back {
            backImageName = network.boxart?.data["\(game1!.id!)"]?[1].filename as! String
                       
        }
        }
        print("baseurl test \(network.boxart?.baseURL)")
        
        print("network.baseURL = \(network.baseURL)")
        //creating image url string
        var imageUrl = network.baseURL!.medium + frontImageName
        print(imageUrl)
        
        
        //if data exists- download it, otherwise show default image
        if frontImageName != nil {
            cell.tableViewCoverImage.image = UIImage(named: "noArtNES")
//            cell.tableViewCoverImage.loadImage(from: imageUrl) {
//                print("image loaded")
//            }
            if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil) {
                //use cache
                print("Cached image used, no need to download it.")
                cell.tableViewCoverImage.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage

            } else {
                //download image
                print("Downloading image from \(imageUrl)...")
                var image : UIImage?
                    cell.tableViewCoverImage.loadImage(from: imageUrl, completed: {
                        print("Image Downloaded")
                        image = cell.tableViewCoverImage.image!
                        self.cache?.setObject(image!, forKey: (indexPath as NSIndexPath).row as AnyObject)
                    })
//
//
//
//
//
//
            }
            
//            cell.tableViewCoverImage.loadImage(from: imageUrl) { print("tableViewCoverImage loaded!")
//                self.network.imageArray.append(cell.tableViewCoverImage.image)
//                self.coverImage = cell.tableViewCoverImage.image!
//                cell.tableViewCoverImage.image = self.network.imageArray[indexPath.row]
//
//
//            }
     
        }
        else {
            cell.tableViewCoverImage.image = UIImage(named: "noArtNES")

        }
  
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Assigning the image at the selected cell to coverImage, so that it may be passed to the DetailViewController to avoid redownloading
        let cell = tableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
        coverImage = cell.tableViewCoverImage.image
    
        //Segue to DetailViewController
        performSegue(withIdentifier: "showDetails", sender: self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailViewController {
//            let cell = tableView.cellForRow(at: <#T##IndexPath#>)
            destination.cover = coverImage!
//            destination.cover = tableView.cellForRow(at: IndexPath.row)
            destination.genre = network.genre
            destination.games = network.games[tableView.indexPathForSelectedRow!.row]
            destination.boxart = network.boxart
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
            picked = 18
            gdbPlatformID = 7
        //            image.
        case 1:
            //SNES
            picked = 19
            gdbPlatformID = 6
        case 2:
            //N64
            picked = 4
            gdbPlatformID = 3
        case 3:
            //GC
            picked = 21
            gdbPlatformID = 2
        case 4:
            //GB
            picked = 33
            gdbPlatformID = 4
        case 5:
            //GBA
            picked = 24
            gdbPlatformID = 5
            
        case 6:
            //SG
            picked = 29
            gdbPlatformID = 18
        case 7:
            //SCD
            picked = 78
            gdbPlatformID = 21
        default:
            print("invalid selection")
        }
//        network.gamesByPlatformID?.data.games.removeAll()
//        self.games.removeAll()
        self.network.games.removeAll()
//        self.networking.games.removeAll()
        self.tableView.reloadData()
        network.currentOffset = 0
        
        print("picked = \(gdbPlatformID)")
        
//        self.networking.downloadJSON(platformSelected: gdbPlatformID, gameName: nil, offset: network.currentOffset) {
        self.network.downloadGamesByPlatformIDJSON(platformID: gdbPlatformID, fields: fields, include: include, pageURL: nil) {
                
                
                
            
            print("pickerview JSON downloaded")
            
            //setting the platform image name
//            self.setPlatformIcon()
            let platformLogos = self.setPlatformIcon(platformID: self.network.games[0].platform, mode: self.traitCollection.userInterfaceStyle)
            
            self.tableviewPlatformImage.image = UIImage(named: platformLogos)
            //loading the platform image
//            self.tableviewPlatformImage.image = UIImage(named: "\(self.imageName)")
            //            self.networking.games.removeAll()
            self.cache.removeAllObjects()
            self.tableView.reloadData()
            
            print("test after")
        }
        
        print("gamesArray \(network.gamesByPlatformID?.data?.games)")
        
        
    }
    
   


    
    
    //MARK: Button Methods
    
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        //rudimentary search function.  Will take what is entered and run it through the downloadJSON function and return any results
        
        if searchTextField.text != nil {
            gameNamed = searchTextField.text
            print("game named \(gameNamed!)")
//            self.network.games.removeAll()
            self.games.removeAll()
            self.tableView.reloadData()
//            self.networking.downloadJSON(platformSelected: nil, gameName: gameNamed, offset: 0) {
//                print("search executed")
//                self.tableView.reloadData()
//            }
            
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        //clear out the search field
        
        searchTextField.text = nil
    }
    
    
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

//func setPlatformIcon() {
//    //helper function to set the appropriate platform icon when the platform is changed in pickerView
//    print("setPlatformIcon()")
//    print("\(self.networking.games[0].platforms![0].id)")
//
//    print("GameDB platform ID count \(network.gamesByPlatformID?.data.games.count)")
//    print("GameDB platform ID name  \(network.gamesByPlatformID?.data.games[0].gameTitle)")
//    print("GameDB platform ID   \(network.gamesByPlatformID?.data.games[0].platform)")
//    switch self.networking.games[0].platforms![0].id {
//
//    case 18:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "NESLogo"
//        } else {
//            //Dark Mode
//            self.imageName = "NESLogoInverse"
//
//        }
//
//    case 19:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "SNESLogo1"
//        } else {
//            //Dark Mode
//            self.imageName = "SNESLogo1Inverse"
//
//        }
//    case 4:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "N64Logo"
//        } else {
//            //Dark Mode
//            self.imageName = "N64LogoInverse"
//
//        }
//    case 21:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "GCLogo"
//        } else {
//            //Dark Mode
//            self.imageName = "GCLogoInverse"
//
//        }
//    case 33:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "GBLogo"
//        } else {
//            //Dark Mode
//            self.imageName = "GBLogoInverse"
//
//        }
//    case 24:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "GBALogo"
//        } else {
//            //Dark Mode
//            self.imageName = "gbaLogoInverse"
//
//        }
//    case 29:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "SegaGenesisLogo"
//        } else {
//            //Dark Mode
//            self.imageName = "SegaGenesisLogoInverse"
//
//        }
//    case 78:
//        if self.traitCollection.userInterfaceStyle == .light {
//            //Light Mode
//            self.imageName = "SegaCDLogo"
//        } else {
//            //Dark Mode
//            self.imageName = "SegaCDLogoInverse"
//
//        }
//
//    default:
//        print("Invalid Platform")
//
//    }
//
//}
}
