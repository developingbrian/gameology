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
    
    var game : Game?
    var games : [Game] = []
    var response : Response?
    var responses = [Response]()
    var company : Companies?
    var platform: Platform?
    var imageName = ""
    var searchValue = ""
    var media = [Media]()
    var gdbPlatformID = 7
    var gameData : GameDB?
    var gameDataImages : GameDBData?
     
//    let inner : Images.Inner?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        switch game?.platforms?[0].id {
        case 18:
            //NES
            gdbPlatformID = 7
        case 19:
            //SNES
            gdbPlatformID = 6
        case 4:
            //N64
            gdbPlatformID = 3
        case 21:
            //GC
            gdbPlatformID = 2
        case 33:
            //GB
            gdbPlatformID = 4
        case 24:
            //GBA
            gdbPlatformID = 5
        case 29:
            //SG
            gdbPlatformID = 18
        case 78:
            //SCD
            gdbPlatformID = 21

        default:
            print("invalid platform")
        }
        
        downloadGameDBGameInfoJSON {
            print("GameDB Success")
//
//            if let playerData = self.gameData!.data.games[0].players {
//
//
//            }
            if (self.gameData?.data.games.count)! > 0 {
                if let players = self.gameData?.data.games[0].players {
                    self.numberOfPlayersLbl.text = "\(players)"
                }
//                self.numberOfPlayersLbl.text = "\(self.gameData!.data.games[0].players)"
            }
            
            self.downloadGameDBGameImageJSON {
                print("GameDB Image Success")
                var array:[Images.Inner]? = []
                var fanartFileName : String
                var clearLogoFileName : String
                let inner = self.gameDataImages?.data.images.innerArray
                for (_, value) in inner! {
                   array = value
                }
                let fanartArray = array?.filter({$0.type == "fanart"})
                
                if fanartArray!.count > 0 {
                    fanartFileName = (fanartArray?[0].fileName)!
                    self.setFanartImage(from: "https://cdn.thegamesdb.net/images/small/\(fanartFileName)")
                    
                    print("fanartFileName = \(fanartFileName)")
                    
                    if self.fanartImageView.image != nil {
                        self.backgroundImage.image = self.fanartImageView.image
                    }
                    
                }
                
                let clearLogoArray = array?.filter({$0.type == "clearlogo"})
                if clearLogoArray!.count > 0 {
                    clearLogoFileName = (clearLogoArray?[0].fileName)!
                    self.setImage(from: "https://cdn.thegamesdb.net/images/small/\(clearLogoFileName)", imageViewNamed: self.clearLogoImageView)
                    
                }
                
//                let clearlogoFileName = array?.filter({$0.type == "clearlogo"})[0].fileName
//
//                print("clearLogoFileName = \(clearlogoFileName)")
                
                

                
            }
        }
       
        
       

        
      
            
  
       
        
        
        screenshotCollectionView.delegate = self
        screenshotCollectionView.dataSource = self
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
        
        print("\(game?.cover?.imageID)")
        print("platform logo image id is \(game?.platforms?[0].platformLogo?.imageID)")
        print("\(game?.platforms?[0].platformLogo?.url)")
        print("\(game?.platforms?[0].versions?[0].platformLogo?.imageID)")
        //        print("platformVersion image is  \(game?.platforms?[0].versions?[0].platformLogo?.imageID)")
        if (game?.cover?.imageID) != nil {
            let coverID = ((game?.cover?.imageID)!)
            setCoverImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
            
        } else {
            boxArtImage.image = UIImage(named: "noArtNES")
            
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        //        func handle(tap: UITapGestureRecognizer) {
        //               view.endEditing(true)
        //           }
        //
        //        var tap = UITapGestureRecognizer(target: self, action: "handle:")
        //        view.addGestureRecognizer(tap)
        
        
        //        if game?.platforms?[0].platformLogo?.imageID != nil {
        //            let logoID = (game?.platforms?[0].versions?[0].platformLogo?.imageID)!
        //
        //            setLogoImage(from: "https://images.igdb.com/igdb/image/upload/t_logo_med/\(logoID).png")
        //
        //        }
//        if game?.genres?[0].name != nil {
//            let separator = " / "
//
//
//            for (index,genre) in game!.genres!.enumerated() {
//
//
//                if index == (game!.genres!.count - 1) {
//                   // do something with last index
//                    genreLabel.text! += "\(genre.name!)"
//                } else {
//                   genreLabel.text! += "\(genre.name!) / "
//                }
//
//            }
//        } else {
//            genreLabel.text = " "
//        }
        genreLabel.text = game?.genres.compactMap { $0.name }.joined(separator: " / ")
        print("gameData \(gameData?.data.games[0].players)")
        print("games.count \(gameData?.data.games.count)")
//        game?.genres.map(\.name).joined(separator: " / ")

            
        if game?.firstReleaseDate != nil {
            let date = Date(timeIntervalSince1970: (game?.firstReleaseDate!)!)
                   let dateFormatter = DateFormatter()
                   dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
                   dateFormatter.locale = NSLocale.current
                   dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
                   let strDate = dateFormatter.string(from: date)
                   if strDate != nil {
                    releaseDateLabel.text =  strDate
                   } else {
                      releaseDateLabel.text = " "
                   }
               }
            
        
        switch game?.ageRating?[0].rating {
            
        case 7:
            ageRatingImageView.image = UIImage(named: "ESRB-EC")
        case 8:
            ageRatingImageView.image = UIImage(named: "ESRB-E")
        case 9:
            ageRatingImageView.image = UIImage(named: "ESRB-E10Plus")
        case 10:
            ageRatingImageView.image = UIImage(named: "ESRB-T")
        case 11:
            ageRatingImageView.image = UIImage(named: "ESRB-M")
        case 12:
            ageRatingImageView.image = UIImage(named: "ESRB-AO")
        default:
            ageRatingImageView.image = UIImage(named: "ESRB-NR")
            print("Invalid Age Rating")
        }
        
        
        print("platform ID is ** **\(game!.platforms![0].id)")
        
        switch game!.platforms![0].id {
            
        case 18:
            if traitCollection.userInterfaceStyle == .light {
                //Light Mode
                imageName = "NESLogo"
            } else {
                //Dark Mode
                imageName = "NESLogoInverse"
                
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
        
        logoImage.image = UIImage(named: "\(imageName)")
        
        print("screenshots count is  \(game?.screenshots?.count)")
        
        boxArtImage.layer.cornerRadius = 20
        boxArtImage.layer.masksToBounds = true
        titleView.layer.cornerRadius = 10
        titleView.layer.masksToBounds = false
        gameDetailView.layer.cornerRadius = 10
        gameDetailView.layer.masksToBounds = false
        gameNameLabel.text = game?.name
        summaryText.text = game?.summary
        publisherLabel.text = game?.involvedCompanies?[0].company?.name
        
        
        print("\(boxArtImage.image)")
        if game?.totalRating != nil {
            let ratingConvert = (((game!.totalRating!)/10)/2)
            
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
    }
    
    
    func setCoverImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.boxArtImage.image = image
                self.backgroundImage.image = image
                
            }
        }
    }
    
    func setLogoImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.logoImage.image = image
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! Game
        
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
                
                
                
                if (item.screenshots?[0].imageID) != nil {
                    
                    let coverID = ((item.screenshots?[0].imageID)!)
                    setScreenShotImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
                    
                }
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
        
        if game?.screenshots != nil {
            return (game?.screenshots!.count)!
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
        
        
        func setScreenShotImage(from url: String) {
            guard let imageURL = URL(string: url) else { return }
            
            // just not to cause a deadlock in UI!
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.screenshotImageView.image = image
                }
            }
        }
        
        
        
        if (game?.screenshots?[indexPath.row].imageID) != nil {
            
            let coverID = ((game?.screenshots?[indexPath.row].imageID)!)
            setScreenShotImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
            
        }
        
        
        return cell
        
    }
    
    func downloadGameDBGameImageJSON(completed: @escaping () -> () ) {
        if (gameData?.data.games.count)! > 0  {
        if let gameData = gameData?.data.games[0].id {
                print("gameData = \(gameData)")
        let apiKey = "8b574d53e9ff612a214486cfe8def1f5c045b0e4eaac50cfd54aa7873d89fd7b"
            
        let url = URL(string: "https://api.thegamesdb.net/v1/Games/Images?apikey=\(apiKey)&games_id=\(gameData)&filter%5Btype%5D=clearlogo%20%2C%20fanart")!
            
            var requestHeader = URLRequest.init(url: url)
    //        requestHeader.httpBody = "apikey \(apiKey),name \(game?.name), fields players, filter \(gdbPlatformID) ".data(using: .utf8, allowLossyConversion: false)
            requestHeader.httpMethod = "GET"
            requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in

                if error == nil {
                    do {
                                let json = String(data: data!, encoding: .utf8)
                                print("\(json)")

                                self.gameDataImages = try JSONDecoder().decode(GameDBData.self, from: data!)

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

            }
    
    func downloadGameDBGameInfoJSON(completed: @escaping () -> () ) {
        if let gameName = game?.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
    let apiKey = "8b574d53e9ff612a214486cfe8def1f5c045b0e4eaac50cfd54aa7873d89fd7b"
        
    let url = URL(string: "https://api.thegamesdb.net/v1.1/Games/ByGameName?apikey=\(apiKey)&name=\(gameName)&fields=players&filter%5Bplatform%5D=\(gdbPlatformID)")!
        
        var requestHeader = URLRequest.init(url: url)
//        requestHeader.httpBody = "apikey \(apiKey),name \(game?.name), fields players, filter \(gdbPlatformID) ".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "GET"
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in

            if error == nil {
                do {
                            let json = String(data: data!, encoding: .utf8)
                            print("\(json)")

                            self.gameData = try JSONDecoder().decode(GameDB.self, from: data!)

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
    
    
    func downloadScreenScraperJSON(completed: @escaping () -> () ) {
        
       
        if let gameName = game?.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        print("\(gameName)")
        let url = URL(string: "https://www.screenscraper.fr/api2/jeuInfos.php?devid=thesuffering&devpassword=06QOJ0pDreS&softname=collector&output=json&romnom=\(gameName)")!
//        let apiKey = "cb4d31574547c1aae77a34959ef2dfa6"
        var requestHeader = URLRequest.init(url: url )
//        requestHeader.httpBody = "fields name;limit 50;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "GET"
//        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
//        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                do {
                    let json = String(data: data!, encoding: .utf8)
                    print("\(json)")
                    
                    self.response = try JSONDecoder().decode(Response.self, from: data!)
                    
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
    
    func setFanartImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.fanartImageView.image = image
            }
        }
    }
    
    
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
