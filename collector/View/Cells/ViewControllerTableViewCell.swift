//
//  ViewControllerTableViewCell.swift
//  collector
//
//  Created by Brian on 3/28/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

protocol ViewControllerTableViewCellDelegate: AnyObject {
    
    func addGameToLibraryPressed(_ sender: ViewControllerTableViewCell)
    
}

class ViewControllerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tableViewCoverImage: UIImageView!
    @IBOutlet weak var tableViewGameName: UILabel!
    @IBOutlet weak var tableViewGenreLabel: UILabel!
    @IBOutlet weak var tableViewAgeRatingLabel: UILabel!
    @IBOutlet weak var tableViewCompanyLabel: UILabel!
    @IBOutlet weak var tableViewReleaseDateLabel: UILabel!
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var coverImageShadow: UIImageView!
    @IBOutlet weak var addToLibraryButton: UIButton!
    @IBOutlet weak var landscapeCoverImage: UIImageView!
    @IBOutlet weak var landscapeCoverImageShadow: UIImageView!
    
    weak var delegate: ViewControllerTableViewCellDelegate?
    
    var network = Networking.shared
    var persistenceManager = PersistenceManager.shared
    var frontImageName : String?
    var rearImageName : String?
    var gradient : CAGradientLayer!
    var gameID: Int?
    var game: GameObject? {
        didSet {
            configureCell()
        }
    }
    var platform : Platform?
    var platformID: Int?
    var platformName: String?
    var indexPath : IndexPath?
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.tableViewCoverImage.sd_cancelCurrentImageLoad()
        self.tableViewCoverImage.image = nil
        self.coverImageShadow.image = nil
        self.landscapeCoverImage.image = nil
        self.landscapeCoverImageShadow.image = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        autoresizingMask = .flexibleWidth
        cellActionButtonLabel?.textColor = .label
        
    }
    
    override func layoutIfNeeded() {
        
        cellActionButtonLabel?.textColor = .label
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
    
    @IBAction func addToLibrary() {
        
        delegate?.addGameToLibraryPressed(self)
    }
    
    
    func configureCell() {
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            backgroundCell.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -6),
//            addToLibraryButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -3)
//        ])
        backgroundCell.layer.shadowPath = UIBezierPath(roundedRect: backgroundCell.bounds, cornerRadius: 10).cgPath
        backgroundCell.layer.masksToBounds = false
        backgroundCell.clipsToBounds = false
        tableViewCoverImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableViewCoverImage.layer.shadowRadius = 5
        tableViewCoverImage.layer.shadowOpacity = 0.75
        tableViewCoverImage.layer.cornerRadius = 10
        tableViewCoverImage.clipsToBounds = false
        tableViewCoverImage.layer.shadowColor = UIColor.darkGray.cgColor
        tableViewCoverImage.translatesAutoresizingMaskIntoConstraints = false
        
        landscapeCoverImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        landscapeCoverImage.layer.shadowRadius = 5
        landscapeCoverImage.layer.shadowOpacity = 0.75
        landscapeCoverImage.layer.cornerRadius = 10
        landscapeCoverImage.clipsToBounds = false
        landscapeCoverImage.layer.shadowColor = UIColor.darkGray.cgColor
        landscapeCoverImage.translatesAutoresizingMaskIntoConstraints = false
        
        coverImageShadow.clipsToBounds = false
        coverImageShadow.layer.cornerRadius = 10
        
        if self.traitCollection.userInterfaceStyle == .light {
            
            addToLibraryButton.setTitleColor(UIColor.black, for: .normal)
            addToLibraryButton.tintColor = UIColor.black
            
        } else {
            
            addToLibraryButton.setTitleColor(UIColor.white, for: .normal)
            addToLibraryButton.tintColor = UIColor.white
            
        }
        let color1 = UIColorFromRGB(0x2B95CE)
        let color2 = UIColorFromRGB(0x2ECAD5)
        
        addToLibraryButton.layer.cornerRadius = 10
        addToLibraryButton.layer.shadowColor = UIColor.black.cgColor
        addToLibraryButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addToLibraryButton.layer.shadowRadius = 5
        addToLibraryButton.layer.shadowOpacity = 0.75
        addToLibraryButton.applyGradientRounded(layoutIfNeeded: true, colors: [color2.cgColor, color1.cgColor])
        
        
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = coverImageShadow.bounds
        effectView.clipsToBounds = false
        effectView.alpha = 1
        
        let maskLayer = CAGradientLayer()
        maskLayer.frame = coverImageShadow.bounds
        maskLayer.shadowRadius = 4
        maskLayer.shadowPath = CGPath(roundedRect: coverImageShadow.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
        maskLayer.shadowOpacity = 1
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.darkGray.cgColor
        
        
        coverImageShadow.layer.mask = maskLayer
        
        
        coverImageShadow.layer.opacity = 1
        coverImageShadow.alpha = 0.75
        landscapeCoverImageShadow.alpha = 0.75
        coverImageShadow.layer.cornerRadius = 10
        
        
        let landscapeEffectView = UIVisualEffectView(effect: effect)
        
        landscapeEffectView.frame = landscapeCoverImageShadow.bounds
        landscapeEffectView.clipsToBounds = false
        landscapeEffectView.alpha = 1
        
        let landscapeMaskLayer = CAGradientLayer()
        landscapeMaskLayer.frame = landscapeCoverImageShadow.bounds
        landscapeMaskLayer.shadowRadius = 4
        landscapeMaskLayer.shadowPath = CGPath(roundedRect: landscapeCoverImageShadow.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
        landscapeMaskLayer.shadowOpacity = 1
        landscapeMaskLayer.shadowOffset = CGSize.zero
        landscapeMaskLayer.shadowColor = UIColor.darkGray.cgColor
        landscapeCoverImageShadow.layer.mask = landscapeMaskLayer
        
        landscapeCoverImageShadow.layer.cornerRadius = 10
        
        if let platform = game?.platformID {
            let platformObject = fetchPlatformObject(platformID: platform)
            platformID = platformObject.id
            platformName = platformObject.name
            
            let ownedImage = fetchAddToButtonIcon(platformID: platform, owned: true)
            let unownedImage = fetchAddToButtonIcon(platformID: platform, owned: false)
            
            guard let gameName = game?.title else { return }
            guard let gamedID = game?.id else { return }
            
            
            if checkForGameInLibrary(name: gameName, id: gamedID, platformID: platform) {
                addToLibraryButton.setImage(UIImage(named: ownedImage), for: .normal)
            } else {
                addToLibraryButton.setImage(UIImage(named: unownedImage), for: .normal)
                
            }
            
            tableViewGameName.text = game?.title
            
            tableViewGenreLabel.text = game?.genreDescriptions
            
            if let rating = game?.rating {
                tableViewAgeRatingLabel.text = rating
                
            } else {
                tableViewAgeRatingLabel.text = "Not Rated"
                
            }
            
            if let developerName = game?.developer {
                tableViewCompanyLabel.text = developerName
            } else {
                tableViewCompanyLabel.text = ""
            }
            
            if let releseDate = game?.releaseDate {
                tableViewReleaseDateLabel.text = releseDate
            }
            
            if let imageFileName = game?.boxartFrontImage {
                let imageURLString = baseURL.coverSmall.rawValue + imageFileName
                let url = URL(string: imageURLString)!
                
                if let width = game?.boxartWidth {
                    
                    if let height = game?.boxartHeight {
                        
                        if width > height {
                            
                            landscapeCoverImage.sd_setImage(with: url) { image, error, cacheType, url in
                                
                                if let image = image {
                                    
                                    let blurredImage = self.blurImage(usingImage: image, blurAmount: 1.5)
                                    self.landscapeCoverImageShadow.image = blurredImage
                                    self.tableViewCoverImage.image = self.landscapeCoverImage.image
                                    
                                    
                                }
                                
                                
                            }
                            
                            tableViewCoverImage.isHidden = true
                            coverImageShadow.isHidden = true
                            landscapeCoverImage.isHidden = false
                            landscapeCoverImageShadow.isHidden = false
                        } else {
                            //image is portrait
                            
                            tableViewCoverImage.sd_setImage(with: url) { image, error, cacheType, url in
                                
                                
                                self.landscapeCoverImage.isHidden = true
                                self.landscapeCoverImageShadow.isHidden = true
                                
                                if self.coverImageShadow.image == nil {
                                    
                                    if let image = image {
                                        
                                        let blurredImage = self.blurImage(usingImage: image, blurAmount: 1.5)
                                        self.coverImageShadow.image = blurredImage
                                        
                                    }
                                    
                                    
                                }
                                
                                self.tableViewCoverImage.isHidden = false
                                self.coverImageShadow.isHidden = false
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                } else if game?.boxartFrontImage != nil {
                    
                    tableViewCoverImage.sd_setImage(with: url) { image, error, cacheType, url in
                        
                        if let image = image {
                            
                            let blurredImage = self.blurImage(usingImage: image, blurAmount: 1.5)
                            self.landscapeCoverImage.image = self.tableViewCoverImage.image
                            self.coverImageShadow.image = blurredImage
                            self.landscapeCoverImageShadow.image = blurredImage
                            
                            if let width = self.tableViewCoverImage.image?.size.width {
                                if let height = self.tableViewCoverImage.image?.size.height {
                                    
                                    if width > height {
                                        
                                        self.tableViewCoverImage.isHidden = true
                                        self.coverImageShadow.isHidden = true
                                        self.landscapeCoverImage.isHidden = false
                                        self.landscapeCoverImageShadow.isHidden = false
                                        
                                        
                                        
                                        
                                    } else {
                                        
                                        self.tableViewCoverImage.isHidden = false
                                        self.coverImageShadow.isHidden = false
                                        self.landscapeCoverImage.isHidden = false
                                        self.landscapeCoverImageShadow.isHidden = false
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                } else if game?.boxartFrontImage == nil {
                    
                    tableViewCoverImage.image = UIImage(named: "noBoxart")
                    coverImageShadow.image = tableViewCoverImage.image
                    tableViewCoverImage.isHidden = false
                    coverImageShadow.isHidden = false
                    landscapeCoverImage.isHidden = true
                    landscapeCoverImageShadow.isHidden = false
                    
                }
                
                
                
                
                
                
                if let index = indexPath {
                    addToLibraryButton.tag = index.row
                }
                
                
                
            } else {
                
                
                tableViewCoverImage.image = UIImage(named: "noBoxart")
                coverImageShadow.image = tableViewCoverImage.image
                tableViewCoverImage.isHidden = false
                coverImageShadow.isHidden = false
                landscapeCoverImage.isHidden = true
                landscapeCoverImageShadow.isHidden = false
                
                
            }
            
        }
        
        
        
    }
}

extension ViewControllerTableViewCell {
    
    func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool {
        
        let savedGames = persistenceManager.fetch(SavedGames.self)
        
        for savedGame in savedGames {
            if savedGame.title == name && savedGame.gameID == id && savedGame.platformID == Int64(platformID) {
                return true
            }
        }
        
        return false
        
    }
    
}
