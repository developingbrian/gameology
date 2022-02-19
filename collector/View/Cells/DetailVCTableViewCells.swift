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
            let gameURL = baseURL.hd.rawValue + boxartURL
            
            let url = URL(string: gameURL)!
            boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {

                self.imageHeight = self.boxartImageView.image!.size.height
                self.imageWidth = self.boxartImageView.image!.size.width
                
                self.landscapeImageView.image = self.boxartImageView.image
                if let image = self.boxartImageView.image {
                    let blurredImage = image.getImageWithBlur(blurAmount: 10)
                    self.shadowImageView.image = blurredImage
                    self.landscapeShadow.image = blurredImage
                }
                
                
                if self.imageWidth > self.imageHeight {
                    //landscape
                    self.landscapeImageView.isHidden = false
                    self.landscapeShadow.isHidden = false
                    self.boxartImageView.isHidden = true
                    self.shadowImageView.isHidden = true
                    
                } else {
                    //portrait

                    
                    self.landscapeImageView.isHidden = true
                    self.landscapeShadow.isHidden = true
                    self.boxartImageView.isHidden = false
                    self.shadowImageView.isHidden = false
                    
                }

            }
        
    }
        
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let heightAnchor = (screenHeight / 2)
        
        
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
        

            
        }
    
    

        
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
        setAppearance()
       configureRatingView()
        guard let platformID = game?.platformID else { return }
//        let platformImageName = setPlatformIconName(platformID: game?.platformID, mode: traitCollection.userInterfaceStyle)
        let image = game?.fetchPlatformFlag(platformID: platformID, uiMode: traitCollection.userInterfaceStyle)
        platformImage.image = image
        
        if let totalRating = game?.totalRating {
            if totalRating == 0 {
                ratingLabel.text = "-"
                progress.trackColor = UIColor.lightGray
                progress.layer.opacity = 0.3
            } else {
            
            let circleRating = (Double(totalRating) * 3.6)
            ratingLabel.text = "\(totalRating)"
            if initialDisplay == true {
                initialDisplay = false
            progress.animate(fromAngle: 0, toAngle: circleRating, duration: 3, completion: nil)
            } else {
                progress.animate(fromAngle: 0, toAngle: circleRating, duration: 0, completion: nil)
            }
            }
        } else if let userRating = game?.userRating {
            if userRating == 0 {
                ratingLabel.text = "-"
                progress.trackColor = UIColor.lightGray
                progress.layer.opacity = 0.3
                
                
            } else {
            let circleRating = (Double(userRating) * 3.6)
            ratingLabel.text = "\(userRating)"
            if initialDisplay == true {
                initialDisplay = false
            progress.animate(fromAngle: 0, toAngle: circleRating, duration: 3, completion: nil)
            } else {
                progress.animate(fromAngle: 0, toAngle: circleRating, duration: 0, completion: nil)

            }
    }
        } else {
            ratingLabel.text = "-"
            progress.trackColor = UIColor.lightGray
            progress.layer.opacity = 0.3
            
        }
        
        if let title = game?.title {
            titleLabel.text = title

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
        progress.set(colors: .systemYellow, .systemRed, .systemBlue, .systemGreen)
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
    @IBOutlet weak var valueActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var looseActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cibActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var priceChartingButton: UIButton!
    @IBOutlet weak var visitPCLabel: UILabel!
    let pricechartURL : String? = nil

    var game: GameObject? {
        didSet {
            configureCell()
        }
    }
    
    var priceInfo : PriceInfo? {
        didSet {
            setPriceLabels()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    
    @IBAction func priceChartButtonPressed(_ sender: Any) {

        let urlString = network.scrapedURL
        let url = URL(string: urlString)!
        let vc = SFSafariViewController(url: url)
        
        delegate?.presentPriceCharting(controller: vc)
    }
    
    
    
}

extension ValueCell {
    
    func setPriceLabels() {

        if let priceInfo = priceInfo {

        valueTitle.text = priceInfo.title
        loosePrice.text = priceInfo.loosePrice
        cibPrice.text = priceInfo.cibPrice
        newPrice.text = priceInfo.newPrice
        
        if priceInfo.title == "N/A" && priceInfo.loosePrice == "N/A" {
            visitPCLabel.isHidden = true
            priceChartingButton.isHidden = true
        }
        }
        
    }
    
    func configureCell() {
        setAppearance()
        valueActivityIndicator.isHidden = false
        valueActivityIndicator.startAnimating()
        cibActivityIndicator.isHidden = false
        cibActivityIndicator.startAnimating()
        looseActivityIndicator.isHidden = false
        looseActivityIndicator.startAnimating()
        newActivityIndicator.isHidden = false
        newActivityIndicator.startAnimating()

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
        //setting the PEGI or ESRB label icon based on age rating from api
        case "PEGI 3":
            ratingImageView.image = UIImage(named: "pegi3")
        case "PEGI 7":
            ratingImageView.image = UIImage(named: "pegi7")
        case "PEGI 12":
            ratingImageView.image = UIImage(named: "pegi12")
        case "PEGI 16":
            ratingImageView.image = UIImage(named: "pegi16")
        case "PEGI 18":
            ratingImageView.image = UIImage(named: "pegi18")
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
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            contentView.layer.backgroundColor = darkGray.cgColor

           
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




