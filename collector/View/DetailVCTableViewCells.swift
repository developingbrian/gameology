//
//  DetailVCTableViewCells.swift
//  collector
//
//  Created by Brian on 3/28/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import SafariServices

class BoxartCell: UITableViewCell {
    @IBOutlet weak var portraitBoxartImageView: UIImageView!
    @IBOutlet weak var landscapeBoxartImageView: UIImageView!
    
    let shadowImageView = UIImageView()
    let boxartImageView = UIImageView()
    let landscapeImageView = UIImageView()
    let landscapeShadow = UIImageView()
    var imageWidth : CGFloat = 0
    var imageHeight : CGFloat = 0
    var initialDisplay = true
    var game : GameObject? {
        didSet {
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        portraitBoxartImageView.layer.cornerRadius = 12
//        portraitBoxartImageView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
//        portraitBoxartImageView.layer.shadowRadius = 5
//        portraitBoxartImageView.layer.shadowOpacity = 0.75
//        portraitBoxartImageView.layer.shadowPath = UIBezierPath(roundedRect: portraitBoxartImageView.bounds, cornerRadius: 12).cgPath
//        portraitBoxartImageView.translatesAutoresizingMaskIntoConstraints = false
//        portraitBoxartImageView.clipsToBounds = false
//        landscapeBoxartImageView.layer.cornerRadius = 12
//        landscapeBoxartImageView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
//        landscapeBoxartImageView.layer.shadowRadius = 5
//        landscapeBoxartImageView.layer.shadowOpacity = 0.75
//        landscapeBoxartImageView.clipsToBounds = false
//        landscapeBoxartImageView.translatesAutoresizingMaskIntoConstraints = false
//        landscapeBoxartImageView.layer.shadowPath = UIBezierPath(roundedRect: landscapeBoxartImageView.bounds, cornerRadius: 12).cgPath
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//            portraitBoxartImageView.layer.shadowColor = UIColor.darkGray.cgColor
//            landscapeBoxartImageView.layer.shadowColor = UIColor.darkGray.cgColor
            contentView.layer.backgroundColor = lightGray.cgColor
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            contentView.layer.backgroundColor = darkGray.cgColor
//            portraitBoxartImageView.layer.shadowColor = UIColor.lightGray.cgColor
//            landscapeBoxartImageView.layer.shadowColor = UIColor.lightGray.cgColor
           
        }
        
    }
}

extension BoxartCell {
    
    func configureCell() {
        setAppearance()
        contentView.addSubview(shadowImageView)
        shadowImageView.addSubview(boxartImageView)
        contentView.addSubview(landscapeShadow)
        landscapeShadow.addSubview(landscapeImageView)
        landscapeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        shadowImageView.layer.cornerRadius = 5
        landscapeShadow.layer.cornerRadius = 10
        
//        shadowImageView.backgroundColor = .red
//        landscapeImageView.backgroundColor = .red
        landscapeShadow.translatesAutoresizingMaskIntoConstraints = false
        shadowImageView.translatesAutoresizingMaskIntoConstraints = false
        boxartImageView.translatesAutoresizingMaskIntoConstraints = false
        landscapeShadow.isHidden = true
        boxartImageView.isHidden = true
        shadowImageView.isHidden = true
        landscapeImageView.isHidden = true
        boxartImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        boxartImageView.layer.shadowColor = UIColor.gray.cgColor
        boxartImageView.layer.shadowRadius = 5
        boxartImageView.layer.shadowOpacity = 0.75
 
        landscapeImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        landscapeImageView.layer.shadowColor = UIColor.darkGray.cgColor
        landscapeImageView.layer.shadowRadius = 5
        landscapeImageView.layer.shadowOpacity = 0.75
        
        
        //setting the image
        if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.fullHD.rawValue + boxartURL
            
            let url = URL(string: gameURL)!
            boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                print("boxart image downloaded")
                self.imageHeight = self.boxartImageView.image!.size.height
                self.imageWidth = self.boxartImageView.image!.size.width
                
                print("imageHeight", self.imageHeight, "imageWidth", self.imageWidth)
                self.landscapeImageView.image = self.boxartImageView.image
                if let image = self.boxartImageView.image {
                    let blurredImage = image.getImageWithBlur(blurAmount: 10)
                self.shadowImageView.image = blurredImage
                self.landscapeShadow.image = blurredImage
                }
                
                
                if self.imageWidth > self.imageHeight {
                    //landscape
                    print("displaying landscape")
                    self.landscapeImageView.isHidden = false
                    self.landscapeShadow.isHidden = false
                    self.boxartImageView.isHidden = true
                    self.shadowImageView.isHidden = true
                    
                } else {
                    //portrait
                    print("displaying portrait")

                    self.landscapeImageView.isHidden = true
                    self.landscapeShadow.isHidden = true
                    self.boxartImageView.isHidden = false
                    self.shadowImageView.isHidden = false
                    
                }

            }
        
    }
        
        
        
            
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let heightAnchor = (screenHeight / 2)
        
//        contentView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        
        print("screenheight", screenHeight, "screenwidth", screenWidth, "heightAnchor", heightAnchor)
        shadowImageView.contentMode = .scaleToFill
        boxartImageView.contentMode = .scaleToFill
        landscapeImageView.contentMode = .scaleToFill
        landscapeShadow.contentMode = .scaleToFill
        
        
        NSLayoutConstraint.activate( [
            //portrait constraints
            boxartImageView.topAnchor.constraint(equalTo: shadowImageView.topAnchor),
            boxartImageView.leadingAnchor.constraint(equalTo: shadowImageView.leadingAnchor),
            boxartImageView.trailingAnchor.constraint(equalTo: shadowImageView.trailingAnchor, constant: -15),
            boxartImageView.bottomAnchor.constraint(equalTo: shadowImageView.bottomAnchor, constant: -15),

            self.shadowImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.shadowImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),

            self.shadowImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
            self.shadowImageView.widthAnchor.constraint(equalTo: self.shadowImageView.heightAnchor, multiplier: (103/137)),
            self.shadowImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.shadowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate( [
            //landscape constraints

            
            landscapeImageView.topAnchor.constraint(equalTo: landscapeShadow.topAnchor),
            landscapeImageView.leadingAnchor.constraint(equalTo: landscapeShadow.leadingAnchor),
            landscapeImageView.trailingAnchor.constraint(equalTo: landscapeShadow.trailingAnchor, constant: -11),
            landscapeImageView.bottomAnchor.constraint(equalTo: landscapeShadow.bottomAnchor, constant: -13),
            
            
            self.landscapeShadow.heightAnchor.constraint(equalToConstant: heightAnchor * 0.6),
            self.landscapeShadow.widthAnchor.constraint(equalTo: self.landscapeShadow.heightAnchor, multiplier: (228/160)),
            self.landscapeShadow.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 20),
            self.landscapeShadow.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -20),
            self.landscapeShadow.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.landscapeShadow.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)

        ])
        

    
        
//        if let width = game?.boxartWidth {
//            if let height = game?.boxartHeight {
//
//
//
//                print("width is", width)
//                print("height is", height)
//                if width > 0 && height > 0 {
//                if width < height {
//
//                    print("portrait orientation")
//
//                NSLayoutConstraint.activate( [
//
//                    boxartImageView.topAnchor.constraint(equalTo: shadowImageView.topAnchor),
//                    boxartImageView.leadingAnchor.constraint(equalTo: shadowImageView.leadingAnchor),
//                    boxartImageView.trailingAnchor.constraint(equalTo: shadowImageView.trailingAnchor, constant: -15),
//                    boxartImageView.bottomAnchor.constraint(equalTo: shadowImageView.bottomAnchor, constant: -15),
//
//                    self.shadowImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//                    self.shadowImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
//
//                    self.shadowImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
//                    self.shadowImageView.widthAnchor.constraint(equalTo: self.shadowImageView.heightAnchor, multiplier: (103/137)),
//                    self.shadowImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//                    self.shadowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//                ])
//
//                }
//                else {
//
//                    print("landscape orientation")
//
//                    NSLayoutConstraint.activate( [
//
//                        self.boxartImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//                        self.boxartImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
//                        self.boxartImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
//                        self.boxartImageView.widthAnchor.constraint(equalTo: self.boxartImageView.heightAnchor, multiplier: (228/160)),
//                        self.boxartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 50),
//                        self.boxartImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: 50),
//                        self.boxartImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//                        self.boxartImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//
//                    ])
//                }
//
//
//            }
//        }
//        }
//
//
//        let boxHeight = boxartImageView.image?.size.height
//        let boxWidth = boxartImageView.image?.size.width
//
//
//        if game?.boxartWidth == 0 || game?.boxartWidth == nil {
//
//            if let boxartURL = game?.boxartFrontImage {
//                let gameURL = baseURL.fullHD.rawValue + boxartURL
//
//                let url = URL(string: gameURL)!
//                boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
//                    print("boxart image downloaded")
//
//                    let blurredImage = self.boxartImageView.image?.getImageWithBlur()
//                    self.shadowImageView.image = blurredImage
//
//                    print("no image info preloaded")
//
//                    let width = self.boxartImageView.image?.size.width
//                    let height = self.boxartImageView.image?.size.height
//
//                    print("width", width)
//                    print("height", height)
//
//
//
//
//
//                }
//
//        }
//
//            NSLayoutConstraint.activate( [
//
//
//                self.boxartImageView.topAnchor.constraint(equalTo: self.shadowImageView.topAnchor),
//                self.boxartImageView.leadingAnchor.constraint(equalTo: self.shadowImageView.leadingAnchor),
//                self.boxartImageView.trailingAnchor.constraint(equalTo: self.shadowImageView.trailingAnchor, constant: -15),
//                self.boxartImageView.bottomAnchor.constraint(equalTo: self.shadowImageView.bottomAnchor, constant: -15),
//
//                self.shadowImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//                self.shadowImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
//
//                self.shadowImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
//                self.shadowImageView.widthAnchor.constraint(equalTo: self.shadowImageView.heightAnchor, multiplier: (103/137)),
//                self.shadowImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//                self.shadowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//
//            ])
//
//
            
        }
    
    
    
//        guard let width = game?.boxartInfo?.width else { return }
//        guard let height = game?.boxartInfo?.height else { return }
        
//        if width < height {
//            print("portrait orientation")
//        NSLayoutConstraint.activate( [
//
//            self.boxartImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//            self.boxartImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//            self.boxartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 50),
//            self.boxartImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: 50),
////            self.boxartImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 366),
////            self.boxartImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500),
////            self.boxartImageView.heightAnchor.constraint(equalToConstant: 500),
//            self.boxartImageView.widthAnchor.constraint(equalTo: self.boxartImageView.heightAnchor, multiplier: (366/500)),
//            self.boxartImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//            self.boxartImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//
//        ])
//        } else {
//            print("landscape orientation")
//
//            NSLayoutConstraint.activate( [
//
//                self.boxartImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//                self.boxartImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//                self.boxartImageView.heightAnchor.constraint(equalToConstant: 500),
//                self.boxartImageView.widthAnchor.constraint(equalTo: self.boxartImageView.heightAnchor, multiplier: (500/366)),
//                self.boxartImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//                self.boxartImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//
//            ])
//        }
        
    }
    




class TitleCell: UITableViewCell {
    
    @IBOutlet weak var platformImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    var initialDisplay = true
    let progress = KDCircularProgress()
    var game : GameObject? {
        didSet {
            
            configureCell()
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
          
            contentView.layer.backgroundColor = lightGray.cgColor
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            contentView.layer.backgroundColor = darkGray.cgColor

           
        }
        
    }
    


}
extension TitleCell {
    
    func configureCell() {
        print("configure title cell")
        setAppearance()
       configureRatingView()
        
        let platformImageName = setPlatformIconName(platformID: game?.platformID, mode: traitCollection.userInterfaceStyle)
        print("platformImageName", platformImageName)
        platformImage.image = UIImage(named: platformImageName)
        
        if let totalRating = game?.totalRating {
            print("totalRating",totalRating)
            let circleRating = (Double(totalRating) * 3.6)
            ratingLabel.text = "\(totalRating)"
            if initialDisplay == true {
                initialDisplay = false
            progress.animate(fromAngle: 0, toAngle: circleRating, duration: 3, completion: nil)
            } else {
                progress.animate(fromAngle: 0, toAngle: circleRating, duration: 0, completion: nil)
            }
            
        } else if let userRating = game?.userRating {
            
            let circleRating = (Double(userRating) * 3.6)
            ratingLabel.text = "\(userRating)"
            if initialDisplay == true {
                initialDisplay = false
            progress.animate(fromAngle: 0, toAngle: circleRating, duration: 3, completion: nil)
            } else {
                progress.animate(fromAngle: 0, toAngle: circleRating, duration: 0, completion: nil)

            }
        } else {
            ratingLabel.text = "-"
            progress.trackColor = UIColor.lightGray
            progress.layer.opacity = 0.3
            
        }
        
        if let title = game?.title {
            titleLabel.text = title
//            titleLabel.adjustsFontSizeToFitWidth = true
//            titleLabel.minimumScaleFactor = 0.75
        }
        if let developer = game?.developer {
            developerLabel.text = developer
        } else {
            developerLabel.text = ""
        }
        
        
    }
    
    func configureRatingView() {
        progress.frame = ratingView.bounds
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.2
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.layer.shadowOffset = CGSize(width: 3, height: 3)
        progress.layer.shadowColor = UIColor.gray.cgColor
        progress.layer.shadowOpacity = 0.7
        progress.layer.shadowRadius = 3
        progress.trackColor = UIColor.clear
//        progress.set(colors: UIColor.systemTeal ,UIColor.white, UIColor.systemRed, UIColor.white, UIColor.systemGreen)
        progress.set(colors: .systemYellow, .systemRed, .systemBlue, .systemGreen)
//        progress.center = CGPoint(x: ratingView.center.x, y: ratingView.center.y)
        ratingView.addSubview(progress)
    }
}

protocol PriceChartPresentationProtocol: AnyObject {
    
    func presentPriceCharting(controller: UIViewController)
    
}

class ValueCell:UITableViewCell {
    weak var delegate: PriceChartPresentationProtocol?
    
    @IBOutlet weak var loosePrice: UILabel!
    @IBOutlet weak var cibPrice: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var valueTitle: UILabel!
    @IBOutlet weak var priceChartingButton: UIButton!
    @IBOutlet weak var visitPCLabel: UILabel!
    let pricechartURL : String? = nil

    var game: GameObject? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func priceChartButtonPressed(_ sender: Any) {
        print("button pressed")
        let urlString = network.scrapedURL
        let url = URL(string: urlString)!
        let vc = SFSafariViewController(url: url)
        
        delegate?.presentPriceCharting(controller: vc)
    }
    
    
    
}

extension ValueCell {
    
    func configureCell() {
        setAppearance()
        var title = game?.title
        title = title?.replacingOccurrences(of: "Expansion Pass", with: "")
        title = title?.replacingOccurrences(of: "Special Edition", with: "")
        title = title?.replacingOccurrences(of: "Game of the Year Edition", with: "")
        title = title?.replacingOccurrences(of: "Game Of The Year Edition", with: "")
        title = title?.replacingOccurrences(of: "Premium Online Edition", with: "")
        title = title?.replacingOccurrences(of: "Gold Edition", with: "")
        title = title?.replacingOccurrences(of: "Complete Edition", with: "")
        title = title?.replacingOccurrences(of: "Deluxe Edition", with: "")
        title = title?.replacingOccurrences(of: "Directors Cut", with: "")
        


        title = title?.removingPercentEncoding
        title = title?.replacingOccurrences(of: "'", with: "")
        title = title?.replacingOccurrences(of: ":", with: "")
        title = title?.replacingOccurrences(of: " & ", with: "+")
        title = title?.replacingOccurrences(of: ".", with: "")
        title = title?.replacingOccurrences(of: "!", with: "")
        title = title?.replacingOccurrences(of: "?", with: "")
        title = title?.replacingOccurrences(of: "/", with: "")
        title = title?.replacingOccurrences(of: "-", with: "+")
        title = title?.replacingOccurrences(of: "³", with: "+3")
        title = title?.replacingOccurrences(of: " ", with: "+")
        
        
        print("title is", title)

        let priceInfo = network.scrapePriceCharting(platformID: (game?.platformID)!, gameName: title!, uneditedGameName: (game?.title)!)
        print(priceInfo.loosePrice, priceInfo.cibPrice, priceInfo.newPrice)
        valueTitle.text = priceInfo.title
        loosePrice.text = priceInfo.loosePrice
        cibPrice.text = priceInfo.cibPrice
        newPrice.text = priceInfo.newPrice
        
        if priceInfo.title == "N/A" && priceInfo.loosePrice == "N/A" {
            visitPCLabel.isHidden = true
            priceChartingButton.isHidden = true
        }
    }
    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
          
            contentView.layer.backgroundColor = lightGray.cgColor
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            contentView.layer.backgroundColor = darkGray.cgColor

           
        }
        
    }
    
    
    
    
    
}



class InfoCell: UITableViewCell {
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var maxPlayersLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var game: GameObject? {
        didSet {
            configureCell()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
          
            contentView.layer.backgroundColor = lightGray.cgColor
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            contentView.layer.backgroundColor = darkGray.cgColor

           
        }
        
    }
}

extension InfoCell {
    
    func configureCell() {
        setAppearance()
        
        
        if let genres = game?.genreDescriptions {
            genreLabel.text = genres
        }
        
        if let releaseDate = game?.releaseDate {
            releaseDateLabel.text = releaseDate
        }
        
        if let maxPlayers = game?.maxPlayers {
            maxPlayersLabel.text = "\(maxPlayers)"
        }
        
        switch game?.rating {
        //setting the ESRB label icon based on age rating from api
        case "ESRB EC":
            ratingImageView.image = UIImage(named: "ESRB-EC")
        case "ESRB E":
            ratingImageView.image = UIImage(named: "ESRB-E")
        case "ESRB E10":
            ratingImageView.image = UIImage(named: "ESRB-E10Plus")
        case "ESRB T":
            ratingImageView.image = UIImage(named: "ESRB-T")
        case "ESRB M":
            ratingImageView.image = UIImage(named: "ESRB-M")
        case "ESRB AO":
            ratingImageView.image = UIImage(named: "ESRB-AO")
        case "ESRB RP":
            ratingImageView.image = UIImage(named: "ESRB-NR")
        default:
            ratingImageView.image = UIImage(named: "ESRB-NR")
            print("Invalid Age Rating -- age rating = \(String(describing: game?.rating))")
        }
        
        
        
    }
}



class SummaryCell: UITableViewCell {
    @IBOutlet weak var summaryLabel: UILabel!
    var game: GameObject? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
          
            contentView.layer.backgroundColor = lightGray.cgColor
//            summaryLabel.backgroundColor = lightGray
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            contentView.layer.backgroundColor = darkGray.cgColor
//            summaryLabel.backgroundColor = darkGray

           
        }
        
    }

}


extension SummaryCell {
    
    func configureCell() {
        
        setAppearance()
        
        if let summary = game?.overview {
        summaryLabel.text = summary
        } else {
            summaryLabel.text = ""
        }
        
        
    }
    
    
    
}




