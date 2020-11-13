//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import WebKit

protocol GameDelegate {
    func didSelectRow(row: NSIndexPath, game: GameObject)
}

class DetailViewController: UIViewController, GameDelegate {
    func didSelectRow(row: NSIndexPath, game: GameObject) {
        self.game = game
        print(self.game)
    }
    
    
    
    
    
    
    @IBOutlet weak var boxArtImage: UIImageView!
    
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var gameDetailView: UIView!
    
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var summaryText: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    

    
    @IBOutlet weak var screenshotCollectionView: UICollectionView!
    
    @IBOutlet weak var ageRatingImageView: UIImageView!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var fanartImageView: UIImageView!
    
    @IBOutlet weak var numberOfPlayersLbl: UILabel!
    
    @IBOutlet weak var clearLogoImageView: UIImageView!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var fanartTitleLabel: UILabel!
    
    
        var game = GameObject()
    var extraImages : Image?
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
    var network = Networking()
    let images = [GameImages.Inner]()
    let images1 : [Images.Inner] = []
    
    let fields = "players,publishers,genres,overview,last_updated,rating,platform,coop,youtube,os,processor,ram,hdd,video,sound,alternates"
    let include = "boxart,platform"
//    var viewController : ViewController
//    var game1 =
    //    let inner : Images.Inner?
    var frontImageName : String?
    var backImageName : String?
    var fanartArray : [GameImages.Inner]? = []
    var screenshotsArray : [GameImages.Inner]? = []
    var coverArray : [GameImages.Inner]? = []
    var genre : GenreData?
    var cover : UIImage?
    var rearCover : UIImage?
    var screenshotImage : UIImage?
    var gradient : CAGradientLayer!
    var coverGradient : CAGradientLayer!
//    var testButton : UIButton!
    var developerData : [String: Developer] = [:]
    var coverImageArray : [UIImage?] = []
    var ssImageArray : [UIImage?] = []
    var indexPathSegue : Int = 0
//    var screenScraperData = response
    var gameDetailsSS : ScreenScraper?
    
    var gameObject = GameObject()
    var buttonIconName : String?

    @IBOutlet weak var boxartImageButton: UIButton!
    
    @IBOutlet weak var testImage: UIImageView!
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
//        titleView.layer.shadowOffset = CGSize(width: 5, height: 5)
        titleView.layer.shadowRadius = 10
        titleView.layer.shadowOpacity = 0.5
        titleView.layer.masksToBounds = false


        var largeBaseURL = ImageURL.large
        var smallBaseURL = ImageURL.small
        print(game)
        //MARK:  viewDidLoad() - Additional Images
        
        if game.id != nil {
        self.network.downloadGameImageJSON(gameID: game.id!) {
           

            print("url small \(self.gameDataImages?.data?.baseURL.small)")
            print(self.game)
            self.extraImages = self.network.image
//            self.screenshotCollectionView.reloadData()
            print("extra images \(self.extraImages)")
            print("extra images ! \(self.extraImages)")
            print("extra images banner array \(self.extraImages!.boxartArray)")
//            let coverImageArray = self.network.game.filter({$0.type == "boxart"})
//print("********")
//            print(coverImageArray)
//            if coverImageArray != nil {
//                self.coverArray = coverImageArray!
//                print(self.coverArray)
//            }
            ////        let largeBaseURL = boxart?.baseURL.large
            //        if network.boxarts["\(games!.id!)"]?[0].side == .front
            print(self.extraImages!.boxartArray![0])
            if self.extraImages!.boxartArray![0].contains("front") == true {
              
                self.frontImageName = self.extraImages!.boxartArray![0]
                        
            } else if self.extraImages!.boxartArray![0].contains("back") == true {
            //        else if network.boxarts["\(games!.id!)"]?[0].side == .back {
                self.backImageName = self.extraImages!.boxartArray![0]
                        
                    }
            if self.extraImages!.boxartArray != nil {
                if (self.extraImages!.boxartArray!.count) > 1 {
                    if self.extraImages!.boxartArray![1].contains("back") == true {
//                if self.network.boxarts["\(self.games!.id!)"]?[1].side == .front {
                        self.backImageName = self.extraImages!.boxartArray![1]
                        
                    } else if self.extraImages!.boxartArray![1].contains("front") == true {
                        self.frontImageName = self.extraImages!.boxartArray![1]
                        
                    
                    }
            }
            }
//            var coverimageFileName = self.getImageFileName(imageType: "boxart", imageData: self.network.gameImages!)
//            print("coverimageFileName = \(coverimageFileName) ")
            print("GameDB Image Success")
//            print("self.images = \(self.images)")
//            print("network.gameImageData = \(self.network.gameImages)")
//            var fanartfileName = self.getImageFileName(imageType: "fanart", imageData: self.network.gameImages!)
//            if (self.extraImages!.fanartArray!.count) > 0 {
//                self.fanartImageView.loadImage(from: ImageURL.medium.rawValue + "\(self.extraImages!.fanartArray![0])") {
////                self.backgroundImage.image = self.fanartImageView.image
//            }
//            }
//            self.backgroundImage.loadImage(from: "https://cdn.thegamesdb.net/images/large31/\(fanartfileName)") {
//
//            }
            
            
            var imageURL = "\(ImageURL.medium.rawValue)" + "\(self.frontImageName!)"
            print("frontImageName = \(self.frontImageName!)")
            print("backImageName = \(self.backImageName)")
                    print(imageURL)
            if self.frontImageName != nil {
            //            setCoverImage(from: "\(imageURL)")
            //            boxArtImage.loadImage(from: imageURL)
                self.boxArtImage.sd_setImage(with: URL(string: imageURL)) { (image, error, cacheType, url) in
                            if error != nil {
                                print("Error downloading.  Error description: \(error?.localizedDescription)")
                            } else {
                                print("Image successfully downloaded from \(url)")
                            }
                        }
            //            boxArtImage.image = cover
                    } else {
                self.boxArtImage.image = UIImage(named: "noArtNES")

                    }
            
//            self.backgroundImage.image = self.cover
    
//            print("fileName = \(fanartfileName)")
//            var clearlogoFileName = self.getImageFileName(imageType: "clearlogo", imageData: self.network.gameImages)
//            print("clearlogoFileName = \(clearlogoFileName)")
            let innerfanartArray = self.network.gameImages?.filter({$0.type == "fanart"})
//
            print("fanartArray = \(innerfanartArray)")
            if innerfanartArray != nil {
                self.fanartArray = innerfanartArray!
            }
            let innerScreenshotArray = self.network.gameImages?.filter({$0.type == "screenshot"})
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
//            if self.extraImages!.clearLogoArray!.count > 0 {
//                print(self.extraImages?.clearLogoArray)
//                let clearLogoURL = "\(ImageURL.small.rawValue)\(self.extraImages!.clearLogoArray![0])"
//                print("\(clearLogoURL)")
//            self.clearLogoImageView.loadImage(from: clearLogoURL) {
//                print("clear logo loaded")
//            }
//            } else {
////                self.fanartTitleLabel.text = self.game.title
////                self.fanartTitleLabel.isHidden = false
////                self.clearLogoImageView.isHidden = false
//            }
//            }
            
            //                let clearlogoFileName = array?.filter({$0.type == "clearlogo"})[0].fileName
            //
            //                print("clearLogoFileName = \(clearlogoFileName)")
            }
        }

        
        guard let title = game.title else { return }
//        network.downloadScreenScraperJSON(gameName: title) {
//            print ("Screen Scraper Success")
//
//            var cartImages = self.network.gameDetailsSS!.response.jeu.medias.filter({$0.type == "support-2D" })
//
//                                     print("cartImages = \(cartImages)")
//            let boxImages = self.network.gameDetailsSS!.response.jeu.medias.filter({ $0.type == "support-2D" && $0.region == "us"} )
//
//                                     print(boxImages)
//
//
//        }
//
        
        definesPresentationContext = true

//        screenshotCollectionView.allowsMultipleSelection = false
        
//        view.backgroundColor = .clear
//        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImage.insertSubview(blurView, at: 0)
//
//       NSLayoutConstraint.activate([
//        blurView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor),
//        blurView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor),
//        ])
//
        
        
//        boxartImageButton.bounds = boxArtImage.bounds
        
        
       
        
//        boxartImageButton.layer.zPosition = 5
        
        print(gameDataImages?.data?.images.innerArray)
//        screenshotCollectionView.delegate = self
//        screenshotCollectionView.dataSource = self
        
//        gradient = CAGradientLayer()
//        gradient.frame = fanartImageView.bounds
//        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor ]
//        gradient.locations = [0.5, 1]
//        fanartImageView.layer.mask = gradient
        
        coverGradient = CAGradientLayer()
        coverGradient.frame = boxArtImage.bounds
        coverGradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor ]
        coverGradient.locations = [0.75, 1]
        boxArtImage.layer.mask = coverGradient
        
//        if game.youtubePath == nil {
//
//            playButton.isHidden = true
//            webView.isHidden = true
//        }

        
        
        // Do any additional setup after loading the view.

        //
        //
       
        
      
        
        if game.maxPlayers != nil {
            self.numberOfPlayersLbl.text = "\(game.maxPlayers!)"
        }
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
        print(network.baseURL)
        print(games?.id)
        print("file name info = \(network.boxarts["\(games?.id)"]?[0].filename)")
        
        boxArtImage.layer.cornerRadius = 20
        boxArtImage.layer.masksToBounds = true
        

        
  
        
        
   //MARK: Tap Gesture
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        var genreArray : [String] = []
        print("games.genre = \(games?.genres)")
//        if games?.genres != nil {
//        for genreID in games!.genres! {
////            genreArray.append("\(network.gameGenreData["\(genreID)"]!.name)")
//            genreArray.append((genre?.data.genres["\(genreID)"]!.name)!)
////            games.
//        }
//        genreLabel.text = genreArray.joined(separator: " | ")
//            genrelabel.text = game.genreDescriptions
////        genreLabel.text = game?.genres.compactMap { $0.name }.joined(separator: " / ")
////        print("gameData \(network.gameData?.data.games[0].players)")
////        print("games.count \(network.gameData?.data.games.count)")
//        //        game?.genres.map(\.name).joined(separator: " / ")
//        }
        genreLabel.text = game.genreDescriptions
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
        
        if game.releaseDate != nil {
           
//            let gdbDate = games?.releaseDate
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-DD"
//            dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
//            dateFormatter.locale = NSLocale.current
//
//            let strDate = dateFormatter.date(from: gdbDate!)
//            dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
//            let finalDate = dateFormatter.string(from: strDate!)
            
            releaseDateLabel.text = game.releaseDate
        }
        
   //MARK: Game Rating Icon
        
        
        switch game.rating {
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
        
//        let platformLogo = setPlatformIcon(platformID: game.platformID, mode: traitCollection.userInterfaceStyle)
//        logoImage.image = UIImage(named: platformLogo)
        
        
        
        
        titleView.layer.cornerRadius = 10
        titleView.layer.masksToBounds = false
//        gameDetailView.layer.cornerRadius = 10
//        gameDetailView.layer.masksToBounds = false
//        fanartImageView.layer.cornerRadius = 10
//        fanartImageView.layer.masksToBounds = false
//        webView.layer.cornerRadius = 10
//        webView.layer.masksToBounds = false
        gameNameLabel.text = game.title
        summaryText.text = game.overview
    
        if game.developer != nil {
            if game.developer != nil {
//                    var developerText = "\(developerData["\(games!.developers![0])"]!.name)"
//
//                    print("detailviewcontroller developerText = \(developerText)")
            publisherLabel.text = game.developer

                } else {
            publisherLabel.text = ""
            print("developerData == nil")
                }
        
        }
        
        
        print("\(boxArtImage.image)")
        var placeholder = 1
//        if game?.totalRating != nil {
        if placeholder != nil {
            //IGDB gives ratings in 1-100 results, however this app displays 1-5 stars.  This takes those values and converts them to a 1-5 rating, and then displays the result as varying images.
            
//            let ratingConvert = (((game!.totalRating!)/10)/2)
//            let ratingConvert = 1.0
//
//            print(ratingConvert)
//
//            switch ratingConvert {
//
//            case 0.5..<1:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star.lefthalf.fill")
//                ratingStarTwo.image = UIImage(systemName: "star")
//                ratingStarThree.image = UIImage(systemName: "star")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//
//            case 1..<1.5:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star")
//                ratingStarThree.image = UIImage(systemName: "star")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 1.5..<2:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.lefthalf.fill")
//                ratingStarThree.image = UIImage(systemName: "star")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 2..<2.5:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 2.5..<3:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star.lefthalf.fill")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 3..<3.5:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star.fill")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 3.5..<4:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star.fill")
//                ratingStarFour.image = UIImage(systemName: "star.lefthalf.fill")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 4..<4.5:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star.fill")
//                ratingStarFour.image = UIImage(systemName: "star.fill")
//                ratingStarFive.image = UIImage(systemName: "star")
//            case 4.5..<5:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star.fill")
//                ratingStarFour.image = UIImage(systemName: "star.fill")
//                ratingStarFive.image = UIImage(systemName: "star.lefthalf.fill")
//            case 5:
//                let halfRating = String(format: "%.2f", ratingConvert)
//                ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
//                ratingLabel.text = String(halfRating)
//                ratingStarOne.image = UIImage(systemName: "star.fill")
//                ratingStarTwo.image = UIImage(systemName: "star.fill")
//                ratingStarThree.image = UIImage(systemName: "star.fill")
//                ratingStarFour.image = UIImage(systemName: "star.fill")
//                ratingStarFive.image = UIImage(systemName: "star.fill")
//            default:
//                ratingLabel.text = "N/A"
//                ratingStarOne.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//                ratingStarOne.image = UIImage(systemName: "star")
//                ratingStarTwo.image = UIImage(systemName: "star")
//                ratingStarThree.image = UIImage(systemName: "star")
//                ratingStarFour.image = UIImage(systemName: "star")
//                ratingStarFive.image = UIImage(systemName: "star")
//            }
//
//        } else {
//            ratingLabel.text = "N/A"
//            ratingStarOne.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//            ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//            ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//            ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//            ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
//            ratingStarOne.image = UIImage(systemName: "star")
//            ratingStarTwo.image = UIImage(systemName: "star")
//            ratingStarThree.image = UIImage(systemName: "star")
//            ratingStarFour.image = UIImage(systemName: "star")
//            ratingStarFive.image = UIImage(systemName: "star")
//
//        }
        
        print("network.gameImageData = \(network.gameImages)")

        
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
    

    
        func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
     let width = boxArtImage.bounds.width
        let height = boxArtImage.bounds.height
          
//        boxartImageButton.frame = CGRect(x: boxArtImage.frame.origin.x, y: boxArtImage.frame.origin.y, width: width, height: height)
//        self.view.bringSubviewToFront(boxartImageButton)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        return true
    }
    
    
    // MARK - CollctionView Stubs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("screenshotsArray \(self.extraImages?.screenshotArray)")
        return self.extraImages?.screenshotArray!.count ?? 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! DetailVCCollectionViewCell
              print("screenshot before \(screenshotImage)")
              screenshotImage = cell.screenshotImageView.image
              print("screenshot after \(screenshotImage)")

              print("didSelectItem at screenshot image = \(screenshotImage)")
    
                    print("indexPath.row = \(indexPath.row)")
                    self.indexPathSegue = indexPath.row
        
        
        
        return true
    }
    
//        func collectionView(_ collectionView: UICollectionView,
//                                   didSelectItemAt indexPath: IndexPath) {
//
//
//            let cell = collectionView.cellForItem(at: indexPath) as! DetailVCCollectionViewCell
//            print("screenshot before \(screenshotImage)")
//            screenshotImage = cell.screenshotImageView.image
//            print("screenshot after \(screenshotImage)")
//
//            print("didSelectItem at screenshot image = \(screenshotImage)")
//            performSegue(withIdentifier: "showScreenshot", sender: self)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = screenshotCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailVCCollectionViewCell
        

        print("screenshots array = \(screenshotsArray)")
      
        
        if let coverID = self.extraImages?.screenshotArray {
            let cover = coverID[indexPath.row]
            print("coverID = \(cover)")
        cell.screenshotImageView.loadImage(from: "https://cdn.thegamesdb.net/images/medium/\(cover)") {
                self.ssImageArray.append(cell.screenshotImageView.image)
                
            }
    }
        

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("indexPath.row = \(indexPath.row)")
//        self.indexPathSegue = indexPath.row
//        print(indexPathSegue)
//                    performSegue(withIdentifier: "showScreenshot", sender: self)
//
//        screenshotCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)

        
        

    
    }
//
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//                 if let destination = segue.destination as? CoverImageViewController {
//
//                    switch segue.identifier
//                    {
//                    case "showCoverImage":
//                        destination.frontCoverImage = cover
//                        destination.rearCoverImage = rearCover
//                        destination.tag = 1
//                        destination.imageIndexPath = indexPathSegue
//
//                    case "showScreenshot":
//
//                        destination.screenshotImage = screenshotImage
//                        destination.screenshotsArray = ssImageArray
//                        destination.tag = 2
//                        print("switch indexPathSegue = \(indexPathSegue)")
//                        destination.imageIndexPath = indexPathSegue
//
//                    default:
//                        break
//
//
//                    }
//    }
//
//}
    
    func downloadScreenScraperJSON(completed: @escaping () -> () ) {
        
        
        if let gameName = games?.gameTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            print("\(gameName)")
            let url = URL(string: "https://www.screenscraper.fr/api2/jeuInfos.php?devid=\(Constants.screenScaperDevID)&devpassword=\(Constants.screenScraperDevPassword)&softname=collector&output=json&romnom=\(gameName)")!
            var requestHeader = URLRequest.init(url: url )
            //        requestHeader.httpBody = "fields name;limit 50;".data(using: .utf8, allowLossyConversion: false)
            requestHeader.httpMethod = "GET"
            //        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
            //        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in

                if error == nil {
                    do {
                        let json = String(data: data!, encoding: .utf8)
                        print("Screen scraper JSON \(json)")

                        self.gameDetailsSS = try JSONDecoder().decode(ScreenScraper.self, from: data!)

                        DispatchQueue.main.async {
                            completed()
                        }
                    } catch {

                        print(error)

                    }
                }
            }.resume()
        }
        
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
//    @IBAction func testButtonPressed(_ sender: Any) {
//        //            let cell = collectionView.cellForItem(at: indexPath) as! DetailVCCollectionViewCell
//        //            screenshotImage = cell.screenshotImageView.image
//
//        performSegue(withIdentifier: "showScreenshot", sender: self)
//    }
    
//    @IBAction func playButtonPressed(_ sender: Any) {
//        webView.isHidden = false
//            let embedURLString = Constants.youtubeEmbedURL
//        var url : URL
//        if games?.youtube != nil {
//        if (games?.youtube?.hasPrefix("https"))! {
//            url = URL(string: (games?.youtube!)!)!
//        } else {
//            url = URL(string: embedURLString + (games?.youtube)!)!
//        }
//        print ("youtube URL = \(url)")
//        let request = URLRequest(url: url)
//               webView.load(request)
//        } else {
//            playButton.isHidden = true
//            webView.isHidden = true
//        }
//
//    }
    
    
//    @IBAction func boxArtImageButtonPressed(_ sender: Any) {
//
////        modalCoverView.isHidden = false
////        modalCoverImage.image = cover
////        print(rearCover)
////        if rearCover != nil {
////            modalNextButton.isHidden = false
////        }
//
//
//    }
    

        
        

    

    
    
    
    
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
}
