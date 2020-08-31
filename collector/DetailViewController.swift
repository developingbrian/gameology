//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var boxArtImage: UIImageView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var gameDetailView: UIView!
    
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var summaryText: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var ratingStarOne: UIImageView!
    
    @IBOutlet weak var ratingStarTwo: UIImageView!
    
    @IBOutlet weak var ratingStarThree: UIImageView!
    
    @IBOutlet weak var ratingStarFour: UIImageView!
    
    @IBOutlet weak var ratingStarFive: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var screenshotCollectionView: UICollectionView!
    
    @IBOutlet weak var ageRatingImageView: UIImageView!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var fanartImageView: UIImageView!
    
    @IBOutlet weak var numberOfPlayersLbl: UILabel!
    
    @IBOutlet weak var clearLogoImageView: UIImageView!
    
    var game : GameDBData?
//    var games : [GameDBData] = []
    var games : GDBGamesPlatform?
    var boxart : Boxart?
    var response : Response?
    var responses = [Response]()
//    var company : Companies?
//    var platform: Platform?
    var imageName = ""
    var searchValue = ""
    var media = [Media]()
    var gdbPlatformID = 7
    //    var gameData : GameDB?
    var gameDataImages : GameDBData?
    let network = Networking()
    let images = [Images.Inner]()
    let images1 : [Images.Inner] = []
    let fields = "players,publishers,genres,overview,last_updated,rating,platform,coop,youtube,os,processor,ram,hdd,video,sound,alternates"
    let include = "boxart,platform"
//    var viewController : ViewController
//    var game1 =
    //    let inner : Images.Inner?
    var frontImageName : String = ""
    var backImageName : String = ""
    var fanartArray : [Images.Inner]? = []
    var screenshotsArray : [Images.Inner]? = []
    var genre : GenreData?
    var cover : UIImage?
    
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gameDataImages?.data?.images.innerArray)
        screenshotCollectionView.delegate = self
        screenshotCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        //        downloadScreenScraperJSON {
        //            print ("Screen Scraper Success")
        //        }
        //
        //
        //        if let index = media.first(where: { $0.type == "fanart" } ) {
        //             print("\(index.url)")
        //            setFanartImage(from: index.url)
        //        }
        
        print("test game title = \(games?.gameTitle)")

        print(games?.gameTitle)
        print()
//        network.downloadGamesByGameNameJSON(gameNamed: "\(games!.gameTitle)", fields: self.fields, filterByPlatformID: "7", include: self.include) {
//              print("downloadGamesByGameNameJSON Success")
//        self.network.gameData[0].players
//            
//            print("GameDB Success")
//            //
//            //            if let playerData = self.gameData!.data.games[0].players {
//            //
//            //
//            //            }
//        if ((self.network.gameData.count)) > 0 {
//                if let players = self.network.gameData[0].players {
//                    self.numberOfPlayersLbl.text = "\(players)"
//                }
//                //                self.numberOfPlayersLbl.text = "\(self.gameData!.data.games[0].players)"
//            }
//            
//            
//            
//        }
        
        //MARK:  viewDidLoad() - Additional Images
        print("games?.id = \(games?.id)")
        if games?.id != nil {
        self.network.downloadGameImageJSON(gameID: games?.id!) {
           
            print("GameDB Image Success")
            print("self.images = \(self.images)")
            print("network.gameImageData = \(self.network.gameImageData)")
            var fanartfileName = self.getImageFileName(imageType: "fanart", imageData: self.network.gameImageData!)
            self.fanartImageView.loadImage(from: "https://cdn.thegamesdb.net/images/small/\(fanartfileName)") {
                
            }
    
            print("fileName = \(fanartfileName)")
            var clearlogoFileName = self.getImageFileName(imageType: "clearlogo", imageData: self.network.gameImageData!)
            print("clearlogoFileName = \(clearlogoFileName)")
            let innerfanartArray = self.network.gameImageData?.filter({$0.type == "fanart"})
            print("fanartArray = \(innerfanartArray)")
            if innerfanartArray != nil {
                self.fanartArray = innerfanartArray!
            }
            let innerScreenshotArray = self.network.gameImageData?.filter({$0.type == "screenshot"})
            if innerScreenshotArray != nil {
                self.screenshotsArray = innerScreenshotArray!
            }
//            let fanartFileName = self.getImageFileName(imageType: "fanart", imageData: self.images1)
//
//                                 print("fanartFileName = \(fanartFileName)")
//                                 print(self.fanartImageView.image)
//                                 if self.fanartImageView.image != nil {
//                                     self.backgroundImage.image = self.fanartImageView.image
//                                 }
                   
//                     let clearLogoFileName = self.getImageFileName(imageType: "clearlogo")
//                   //            let clearLogoArray = array?.filter({$0.type == "clearlogo"})
//                   //            if clearLogoArray!.count > 0 {
//                   //                clearLogoFileName = (clearLogoArray?[0].fileName)!
//
//                                   self.clearLogoImageView.loadImage(from: "https://cdn.thegamesdb.net/images/small/\(clearLogoFileName)")
            
//            var array:[Images.Inner]? = []
//            var clearLogoFileName : String
//            let inner = self.network.gameDataImages?.data?.images.innerArray
//            for (_, value) in inner! {
//                array = value
//            }
//            let fanartArray = array?.filter({$0.type == "fanart"})
//
//            if fanartArray!.count > 0 {
//                fanartFileName = (fanartArray?[0].fileName)!
//                self.fanartImageView.loadImage(from: "https://cdn.thegamesdb.net/images/small/\(fanartFileName)")
////                self.setFanartImage(from: "https://cdn.thegamesdb.net/images/small/\(fanartFileName)")
////
          
//
//            }
          
//                self.setImage(from: "https://cdn.thegamesdb.net/images/small/\(clearLogoFileName)", imageViewNamed: self.clearLogoImageView)
                
//            }
            
            //                let clearlogoFileName = array?.filter({$0.type == "clearlogo"})[0].fileName
            //
            //                print("clearLogoFileName = \(clearlogoFileName)")
            self.screenshotCollectionView.reloadData()
            }
        }
        
       
       
        
        //        print("rating \(game?.ageRating?[0].rating)")
        //
        //        print("rating 2 \(game?.ageRating?[0].rating?.description)")
        //        print("genre \(game?.genres[0].name)")
        //        var ageRated = game?.ageRating?[0].rating
        //        print("ageRated \(ageRated)")
        //        print("game id; \(game?.ageRating?[0].id)")
        //        if game?.ageRating?[0].rating != nil {
        //            print(String(describing: (game?.ageRating![0].rating)))
        //        } else {
        //            print("age rating is nil")
        //        }
        //        game?.ageRating?[0].category
        //        print("index 1 \(game?.ageRating?[1].rating)")
        //        print("\(String(describing: game?.ageRating?.count))")
        //        print("rating \(game?.ageRating?.rating)")
        //print("rating \(game?.ageRating?.category)")
        
//        print("\(game?.cover?.imageID)")
//        print("platform logo image id is \(game?.platforms?[0].platformLogo?.imageID)")
//        print("\(game?.platforms?[0].platformLogo?.url)")
//        print("\(game?.platforms?[0].versions?[0].platformLogo?.imageID)")
//        //        print("platformVersion image is  \(game?.platforms?[0].versions?[0].platformLogo?.imageID)")
        
        
       //MARK: Boxart Image
        
        print(games?.id)
        print("file name info = \(boxart?.data["\(games!.id!)"]?[0].filename)")
        
        boxArtImage.layer.cornerRadius = 20
        boxArtImage.layer.masksToBounds = true
        
        let largeBaseURL = boxart?.baseURL.large
        if boxart?.data["\(games!.id!)"]?[0].side == .front {
            print(boxart?.data["\(games!.id!)"]?[0].filename)
            frontImageName = boxart?.data["\(games!.id!)"]?[0].filename as! String
            
        } else if boxart?.data["\(games!.id!)"]?[0].side == .back {
            backImageName = boxart?.data["\(games!.id!)"]?[0].filename as! String
            
        }
        if boxart?.data["\(games?.id)"]?[1] != nil {
        if boxart?.data["\(games!.id!)"]?[1].side == .front {
            print(boxart?.data["\(games!.id!)"]?[1].filename)
            frontImageName = boxart?.data["\(games!.id!)"]?[1].filename as! String
            
        } else if boxart?.data["\(games!.id!)"]?[1].side == .back {
            backImageName = boxart?.data["\(games!.id!)"]?[1].filename as! String
            
        }
        }
        
        var imageURL = "\(largeBaseURL!)" + "\(frontImageName)"
        print("frontImageName = \(frontImageName)")
        print("backImageName = \(backImageName)")
        print(imageURL)
        if frontImageName != nil {
//            setCoverImage(from: "\(imageURL)")
//            boxArtImage.loadImage(from: imageURL)
            boxArtImage.image = cover
        } else {
            boxArtImage.image = UIImage(named: "noArtNES")

        }
        
        
   //MARK: Tap Gesture
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        var genreArray : [String] = []
        print("games.genre = \(games?.genres)")
        for genreID in games!.genres! {
//            genreArray.append("\(network.gameGenreData["\(genreID)"]!.name)")
            genreArray.append("\(genre?.data .genres["\(genreID)"]?.name)")
//            games.
        }
        genreLabel.text = genreArray.joined(separator: " | ")
//        genreLabel.text = game?.genres.compactMap { $0.name }.joined(separator: " / ")
//        print("gameData \(network.gameData?.data.games[0].players)")
//        print("games.count \(network.gameData?.data.games.count)")
        //        game?.genres.map(\.name).joined(separator: " / ")
        
        
//        if game?.firstReleaseDate != nil {
//            let date = Date(timeIntervalSince1970: (game?.firstReleaseDate!)!)
//            let dateFormatter = DateFormatter()
//            dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
//            dateFormatter.locale = NSLocale.current
//            dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
//            let strDate = dateFormatter.string(from: date)
//            if strDate != nil {
//                releaseDateLabel.text =  strDate
//            } else {
//                releaseDateLabel.text = " "
//            }
//        }
        
   //MARK: Game Rating Icon
        
        
        switch games?.rating {
        //setting the ESRB label icon based on age rating from api
        case "EC- Early Childhood":
            ageRatingImageView.image = UIImage(named: "ESRB-EC")
        case "E - Everyone":
            ageRatingImageView.image = UIImage(named: "ESRB-E")
        case "E10+ - Everyone 10+":
            ageRatingImageView.image = UIImage(named: "ESRB-E10Plus")
        case "T - Teen":
            ageRatingImageView.image = UIImage(named: "ESRB-T")
        case "M - Mature 17+":
            ageRatingImageView.image = UIImage(named: "ESRB-M")
        case "A - Adults Only":
            ageRatingImageView.image = UIImage(named: "ESRB-AO")
        default:
            ageRatingImageView.image = UIImage(named: "ESRB-NR")
            print("Invalid Age Rating -- age rating = \(games?.rating)")
        }

        //MARK: Platform Logo
        
        let platformLogo = setPlatformIcon(platformID: games!.platform, mode: traitCollection.userInterfaceStyle)
        logoImage.image = UIImage(named: platformLogo)
        
        
        
        
        titleView.layer.cornerRadius = 10
        titleView.layer.masksToBounds = false
        gameDetailView.layer.cornerRadius = 10
        gameDetailView.layer.masksToBounds = false
        gameNameLabel.text = games?.gameTitle
        summaryText.text = games?.overview
//        publisherLabel.text = game?.involvedCompanies?[0].company?.name
        
        
        print("\(boxArtImage.image)")
        var placeholder = 1
//        if game?.totalRating != nil {
        if placeholder != nil {
            //IGDB gives ratings in 1-100 results, however this app displays 1-5 stars.  This takes those values and converts them to a 1-5 rating, and then displays the result as varying images.
            
//            let ratingConvert = (((game!.totalRating!)/10)/2)
            let ratingConvert = 1.0
            
            print(ratingConvert)
            
            switch ratingConvert {
                
            case 0.5..<1:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingLabel.text = String(halfRating)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star.lefthalf.fill")
                ratingStarTwo.image = UIImage(systemName: "star")
                ratingStarThree.image = UIImage(systemName: "star")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
                
            case 1..<1.5:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingLabel.text = String(halfRating)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star")
                ratingStarThree.image = UIImage(systemName: "star")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
            case 1.5..<2:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingLabel.text = String(halfRating)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.lefthalf.fill")
                ratingStarThree.image = UIImage(systemName: "star")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
            case 2..<2.5:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingLabel.text = String(halfRating)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
            case 2.5..<3:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingLabel.text = String(halfRating)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star.lefthalf.fill")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
            case 3..<3.5:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingLabel.text = String(halfRating)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star.fill")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
            case 3.5..<4:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingLabel.text = String(halfRating)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star.fill")
                ratingStarFour.image = UIImage(systemName: "star.lefthalf.fill")
                ratingStarFive.image = UIImage(systemName: "star")
            case 4..<4.5:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingLabel.text = String(halfRating)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star.fill")
                ratingStarFour.image = UIImage(systemName: "star.fill")
                ratingStarFive.image = UIImage(systemName: "star")
            case 4.5..<5:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingLabel.text = String(halfRating)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star.fill")
                ratingStarFour.image = UIImage(systemName: "star.fill")
                ratingStarFive.image = UIImage(systemName: "star.lefthalf.fill")
            case 5:
                let halfRating = String(format: "%.2f", ratingConvert)
                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                ratingLabel.text = String(halfRating)
                ratingStarOne.image = UIImage(systemName: "star.fill")
                ratingStarTwo.image = UIImage(systemName: "star.fill")
                ratingStarThree.image = UIImage(systemName: "star.fill")
                ratingStarFour.image = UIImage(systemName: "star.fill")
                ratingStarFive.image = UIImage(systemName: "star.fill")
            default:
                ratingLabel.text = "N/A"
                ratingStarOne.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                ratingStarOne.image = UIImage(systemName: "star")
                ratingStarTwo.image = UIImage(systemName: "star")
                ratingStarThree.image = UIImage(systemName: "star")
                ratingStarFour.image = UIImage(systemName: "star")
                ratingStarFive.image = UIImage(systemName: "star")
            }
            
        } else {
            ratingLabel.text = "N/A"
            ratingStarOne.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarOne.image = UIImage(systemName: "star")
            ratingStarTwo.image = UIImage(systemName: "star")
            ratingStarThree.image = UIImage(systemName: "star")
            ratingStarFour.image = UIImage(systemName: "star")
            ratingStarFive.image = UIImage(systemName: "star")
            
        }
        
        print("network.gameImageData = \(network.gameImageData)")

        
    }
    
    
//    func setCoverImage(from url: String) {
//        guard let imageURL = URL(string: url) else { return }
//
//        // just not to cause a deadlock in UI!
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.boxArtImage.image = image
//                self.backgroundImage.image = image
//
//            }
//        }
//    }
//
//    func setLogoImage(from url: String) {
//        guard let imageURL = URL(string: url) else { return }
//        // just not to cause a deadlock in UI!
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.logoImage.image = image
//            }
//        }
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let item = sender as! Game
        
        if segue.identifier == "imageViewController" {
            if let vc = segue.destination as? ImageViewController {
                
                
                func setScreenShotImage(from url: String) {
                    guard let imageURL = URL(string: url) else { return }
                    
                    // just not to cause a deadlock in UI!
                    DispatchQueue.global().async {
                        guard let imageData = try? Data(contentsOf: imageURL) else { return }
                        
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            vc.imageFromCollectionView.image = image
                        }
                    }
                }
                
                
                
//                if (item.screenshots?[0].imageID) != nil {
//
//                    let coverID = ((item.screenshots?[0].imageID)!)
//                    setScreenShotImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
//
//                }
                //                if (game?.cover?.imageID) != nil {
                //                           let coverID = ((game?.cover?.imageID)!)
                //                           setScreenShotImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
                //                vc.imageFromCollectionView.image = set
                //                item.screenshots?[0].imageID
            }
            
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    // MARK - CollctionView Stubs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("screenshotsArray \(screenshotsArray)")
        if screenshotsArray != nil {
            return (screenshotsArray?.count)!
        } else {
            return 1
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView,
    //                               didSelectItemAt indexPath: IndexPath) {
    //        var selectedImage : String
    //        let gameImage = games[indexPath.item]
    //        if gameImage.screenshots?[0].imageID != nil {
    //        selectedImage = (gameImage.screenshots?[0].imageID)!
    //        }
    //        performSegue(withIdentifier: "imageViewController", sender: gameImage)
    //
    //
    //           }
    //
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = screenshotCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailVCCollectionViewCell
        

        print("screenshots array = \(screenshotsArray)")
        if screenshotsArray?[indexPath.row].fileName != nil {
            let coverID = screenshotsArray?[indexPath.row].fileName
            print("coverID = \(coverID)")
            cell.screenshotImageView.loadImage(from: "https://cdn.thegamesdb.net/images/small/\(coverID!)") {
                
                
            }
        }

        
        return cell
        
    }
    
    
    
    
    func downloadScreenScraperJSON(completed: @escaping () -> () ) {
        
        
//        if let gameName = game?.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//            print("\(gameName)")
//            let url = URL(string: "https://www.screenscraper.fr/api2/jeuInfos.php?devid=\(Constants.screenScaperDevID)&devpassword=\(Constants.screenScraperDevPassword)&softname=collector&output=json&romnom=\(gameName)")!
//            var requestHeader = URLRequest.init(url: url )
//            //        requestHeader.httpBody = "fields name;limit 50;".data(using: .utf8, allowLossyConversion: false)
//            requestHeader.httpMethod = "GET"
//            //        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
//            //        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
//            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
//
//                if error == nil {
//                    do {
//                        let json = String(data: data!, encoding: .utf8)
//                        print("\(json)")
//
//                        self.response = try JSONDecoder().decode(Response.self, from: data!)
//
//                        DispatchQueue.main.async {
//                            completed()
//                        }
//                    } catch {
//
//                        print(error)
//
//                    }
//                }
//            }.resume()
//        }
        
    }
    
    func setImage(from url: String, imageViewNamed: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageViewNamed.image = image
            }
        }
    }
    
//    func setFanartImage(from url: String) {
//        guard let imageURL = URL(string: url) else { return }
//
//        // just not to cause a deadlock in UI!
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.fanartImageView.image = image
//            }
//        }
//    }
    
    
}

//extension Array where Element: CustomStringConvertible {
//  public func stringRepresentation(separator: String = "") -> String {
//    return self.map{ $0.description }.joined(separator: ",")
//  }
//}

//extension Genre : CustomStringConvertible {
//    public func stringRepresentation(separator: String = "") -> String {
//        return self.map{ $0.description }.joined(separator: ",")
//    }
//    
//    
//}
