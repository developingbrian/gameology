//
//  OwnedGamesVCTableViewCell.swift
//  collector
//
//  Created by Brian on 10/11/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol OwnedGameDelegate: AnyObject {
    
    func removeFromLibrary(index: IndexPath)
    
}

class OwnedGamesVCTableViewCell: UITableViewCell {

    @IBOutlet weak var boxartImageView: UIImageView!
    @IBOutlet weak var boxartShadowImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var removeFromLibraryBtn: UIButton!
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var platformImage: UIImageView!
    @IBOutlet weak var landscapeBoxart: UIImageView!
    @IBOutlet weak var landscapeShadow: UIImageView!
    let persistenceManager = PersistenceManager.shared
    var ownedGames = [SavedGames]()
    var index : IndexPath?
    var id : Int?
    var platformName : String?
    var platformID : Int?
    var gameName : String?
    var game : SavedGames? {
        didSet {
            
            configureCell()
        }
    }
//    var indexPath: IndexPath?
    weak var delegate : OwnedGameDelegate?
    
    override func prepareForReuse() {
        self.boxartImageView.image = nil
        self.boxartShadowImageView.image = nil
        self.landscapeShadow.image = nil
        self.landscapeBoxart.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func removeFromLibraryBtnPressed(_ sender: Any) {
        
        delegate?.removeFromLibrary(index: index!)
        
        
    }
    
    
//    func configureCells() {
//        if self.traitCollection.userInterfaceStyle == .light {
//            backgroundCell.layer.shadowColor = UIColor.black.cgColor
//            backgroundCell.layer.backgroundColor = UIColor.white.cgColor
//            removeFromLibraryBtn.setTitleColor(UIColor.black, for: .normal)
//            removeFromLibraryBtn.tintColor = UIColor.black
//        } else {
//            backgroundCell.layer.shadowColor = UIColor.white.cgColor
//            backgroundCell.layer.backgroundColor = UIColor.black.cgColor
//            removeFromLibraryBtn.setTitleColor(UIColor.white, for: .normal)
//            removeFromLibraryBtn.tintColor = UIColor.white
//        }
//        
//    }
    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewControllerTableViewCell

        
        if appearanceSelection == 0 {
            
            overrideUserInterfaceStyle = .unspecified
        } else if appearanceSelection == 1 {
            overrideUserInterfaceStyle = .light
            


        } else {
            overrideUserInterfaceStyle = .dark
           

        }
        
        if traitCollection.userInterfaceStyle == .light {
            backgroundCell.layer.shadowColor = UIColor.darkGray.cgColor
            backgroundCell.layer.backgroundColor = UIColor.tertiarySystemBackground.cgColor
//            gameTitleLabel.textColor = .white
//            releaseDateLabel.textColor = .tertiarySystemBackground
//            developerLabel.textColor = .tertiarySystemBackground
            
        } else if traitCollection.userInterfaceStyle == .dark {
            backgroundCell.layer.shadowColor = UIColor.gray.cgColor
            backgroundCell.layer.backgroundColor = UIColor.tertiarySystemBackground.cgColor
//            gameTitleLabel.textColor = .tertiarySystemBackground
//            releaseDateLabel.textColor = .tertiarySystemBackground
//            developerLabel.textColor = .tertiarySystemBackground
//            
        }
    }

//    func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage? {
//        guard let ciImage = CIImage(image: image) else
//        {
//         return nil
//        }
//        
//        let blurFilter = CIFilter(name: "CIGuassianBluar")
//        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
//        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
//        
//        guard let outputImage = blurFilter?.outputImage else {
//            return nil
//        }
//        
//        return UIImage(ciImage: outputImage)
//        
//        
//    }
    
}



extension OwnedGamesVCTableViewCell {
    
    func configureCell() {
        setAppearance()
        
        let effect = UIBlurEffect(style: .regular)
                let effectView = UIVisualEffectView(effect: effect)
                effectView.frame = boxartShadowImageView.bounds
                effectView.clipsToBounds = false


                effectView.alpha = 1

//                let maskLayer = CAGradientLayer()
//                maskLayer.frame = boxartShadowImageView.bounds
//                maskLayer.shadowRadius = 4
//                maskLayer.shadowPath = CGPath(roundedRect: boxartShadowImageView.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
//
//        maskLayer.shadowOffset = CGSize.zero
//
//        maskLayer.shadowOpacity = 1
//
//        maskLayer.shadowColor = UIColor.darkGray.cgColor
        
//        let landscapeMaskLayer = CAGradientLayer()
//        landscapeMaskLayer.frame = landscapeBoxart.bounds
//        landscapeMaskLayer.shadowRadius = 4
//        landscapeMaskLayer.shadowPath = CGPath(roundedRect: landscapeShadow.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
//        landscapeMaskLayer.shadowOffset = CGSize.zero
//        landscapeMaskLayer.shadowOpacity = 1
//        landscapeMaskLayer.shadowColor = UIColor.darkGray.cgColor
//        landscapeShadow.layer.mask = landscapeMaskLayer
//        landscapeShadow.layer.cornerRadius = 10
        
        
        landscapeBoxart.layer.opacity = 1
        landscapeBoxart.layer.shadowRadius = 5
        landscapeBoxart.layer.shadowOpacity = 0.75
        landscapeBoxart.layer.shadowOffset = CGSize(width: 3, height: 3)
        landscapeBoxart.layer.shadowColor = UIColor.darkGray.cgColor
        landscapeBoxart.clipsToBounds = false
        landscapeBoxart.layer.masksToBounds = false
        landscapeBoxart.translatesAutoresizingMaskIntoConstraints = true
        landscapeBoxart.layer.cornerRadius = 10

//        boxartShadowImageView.layer.mask = maskLayer
        boxartShadowImageView.layer.cornerRadius = 10
        
        boxartShadowImageView.layer.opacity = 1
        boxartImageView.layer.opacity = 1
        boxartImageView.layer.shadowRadius = 5
        boxartImageView.layer.shadowOpacity = 0.75
        boxartImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        boxartImageView.layer.shadowColor = UIColor.darkGray.cgColor
        boxartImageView.clipsToBounds = false
        boxartImageView.layer.masksToBounds = false
        boxartImageView.translatesAutoresizingMaskIntoConstraints = true
        boxartImageView.layer.cornerRadius = 10
        boxartShadowImageView.backgroundColor = .clear
        
        let color1 = UIColorFromRGB(0x2B95CE)
        let color2 = UIColorFromRGB(0x2ECAD5)
        
        removeFromLibraryBtn.layer.cornerRadius = 10
        removeFromLibraryBtn.layer.shadowColor = UIColor.black.cgColor
        removeFromLibraryBtn.layer.shadowOffset = CGSize(width: 0, height: 5)
        removeFromLibraryBtn.layer.shadowRadius = 5
        removeFromLibraryBtn.layer.shadowOpacity = 0.75
        removeFromLibraryBtn.applyGradientRounded(layoutIfNeeded: true, colors: [color2.cgColor, color1.cgColor])
        if let platformID = game?.platformID {
            let removeFromLibraryString = fetchAddToButtonIcon(platformID: Int(platformID), owned: true)
            let buttonImage = UIImage(named: removeFromLibraryString)
            removeFromLibraryBtn.setImage(buttonImage, for: .normal)
        }
//        if let indexPath = indexPath {
//            index = indexPath
//        }
        backgroundCell.layer.backgroundColor = UIColor.tertiarySystemBackground.cgColor
        if let gameID = game?.gameID {
            id = Int(gameID)
        }
        gameName = game?.title
        if let platform = game?.platformID {
            platformID = Int(platform)
        }
        platformName = game?.platformName
        if let boxartImageURL = game?.boxartImageURL {
            
            let urlString = baseURL.coverSmall.rawValue + boxartImageURL
            
            let url = URL(string: urlString)!
            
            boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                let image = self.boxartImageView.image
                self.landscapeBoxart.image = image
                
                if let boxImage = image {
                    
                    let blurredImage = self.blurImage(usingImage: boxImage, blurAmount: 3.0)
                    self.boxartShadowImageView.image = blurredImage
                    self.landscapeShadow.image = blurredImage
                    
                    
                    if let width = self.boxartImageView.image?.size.width {
                        if let height = self.boxartImageView.image?.size.height {
                            
                            if width > height {
                                print("landscape image")
                                self.boxartImageView.isHidden = true
                                self.boxartShadowImageView.isHidden = true
                                self.landscapeBoxart.isHidden = false
                                self.landscapeShadow.isHidden = false
                            
                                
                            } else {
                                print("portrait image")
                                self.boxartImageView.isHidden = false
                                self.boxartShadowImageView.isHidden = false
                                self.landscapeBoxart.isHidden = true
                                self.landscapeShadow.isHidden = true
                            }
                            
                            
                        }
                        
                    } else {
                        print("image is nil")
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
            }
        }
        
//        let set = game?.genreType
//        let array = set?.value(forKey: "name")

        gameTitleLabel.text = game?.title
        releaseDateLabel.text = game?.releaseDate
        developerLabel.text = game?.developerName
        if let platformID = game?.platformID {
        let platformName =
            self.setPlatformIconName(platformID: Int(platformID), mode: self.traitCollection.userInterfaceStyle)
            
            platformImage.image = UIImage(named: platformName)
        }
        
    }
    
}
