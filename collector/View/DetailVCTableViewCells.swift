//
//  DetailVCTableViewCells.swift
//  collector
//
//  Created by Brian on 3/28/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class BoxartCell: UITableViewCell {
    @IBOutlet weak var portraitBoxartImageView: UIImageView!
    @IBOutlet weak var landscapeBoxartImageView: UIImageView!
    
    let boxartImageView = UIImageView()
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
        contentView.addSubview(boxartImageView)
        boxartImageView.translatesAutoresizingMaskIntoConstraints = false
        boxartImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        boxartImageView.layer.shadowRadius = 5
        boxartImageView.layer.shadowOpacity = 0.75
        if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.fullHD.rawValue + boxartURL
            
            let url = URL(string: gameURL)!
            boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                print("boxart image downloaded")

        }
        
    }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let heightAnchor = (screenHeight / 2)
        
        print("screenheight", screenHeight, "screenwidth", screenWidth, "heightAnchor", heightAnchor)
        
        if let width = game?.boxartWidth {
            if let height = game?.boxartHeight {
                
                
                if width < height {
                    print("portrait orientation")
                NSLayoutConstraint.activate( [
                    
                    self.boxartImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                    self.boxartImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
                    self.boxartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 50),
                    self.boxartImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: 50),
                    
        //            self.boxartImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 366),
        //            self.boxartImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500),
                    self.boxartImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
                    self.boxartImageView.widthAnchor.constraint(equalTo: self.boxartImageView.heightAnchor, multiplier: (366/500)),
                    self.boxartImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                    self.boxartImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)

                ])
                } else {
                    print("landscape orientation")

                    NSLayoutConstraint.activate( [
                    
                        self.boxartImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                        self.boxartImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
                        self.boxartImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
                        self.boxartImageView.widthAnchor.constraint(equalTo: self.boxartImageView.heightAnchor, multiplier: (228/160)),
                        self.boxartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 50),
                        self.boxartImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: 50),
                        self.boxartImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                        self.boxartImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)

                    ])
                }
                
                
            }
        } else {
            print("no image info preloaded")
            
            self.boxartImageView.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate( [
            
                self.boxartImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                self.boxartImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
                self.boxartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 50),
                self.boxartImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: 50),
    //            self.boxartImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 366),
    //            self.boxartImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500),
                self.boxartImageView.heightAnchor.constraint(equalToConstant: heightAnchor),
                self.boxartImageView.widthAnchor.constraint(equalTo: self.boxartImageView.heightAnchor, multiplier: (366/500)),
                self.boxartImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                self.boxartImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)

            ])
            
            
            
            
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
        }
        
        
    }
    
    
    
}




