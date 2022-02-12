//
//  AdvancedSearchResultsCell.swift
//  collector
//
//  Created by Brian on 10/30/21.
//  Copyright © 2021 Brian. All rights reserved.
//

//import UIKit
//import CoreData
//
//class AdvancedSearchResultsCell: UITableViewCell {
//
//    @IBOutlet weak var titleLbl: UILabel!
//    
//    @IBOutlet weak var releaseDateLbl: UILabel!
//    
//    @IBOutlet weak var genreLbl: UILabel!
//    
//    @IBOutlet weak var companyLbl: UILabel!
//    
//    @IBOutlet weak var platformLogoImage: UIImageView!
//    
//    @IBOutlet weak var addRemoveBtn: UIButton!
//    
//    @IBOutlet weak var landscapeImage: UIImageView!
//    
//    @IBOutlet weak var landscapeImageShadow: UIImageView!
//    
//    @IBOutlet weak var portraitImage: UIImageView!
//    
//    @IBOutlet weak var portraitImageShadow: UIImageView!
//    
//    @IBOutlet weak var backgroundCell: RoundedShadowView!
//    var delegate : AdvancedSearchBtnDelegate?
//    var platformName = ""
//    var platformID = 0
//    var game: GameObject? {
//        didSet {
//            configureCell()
//        }
//    }
//    
//    var persistenceManager = PersistenceManager.shared
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    override func layoutSubviews() {
//        cellActionButtonLabel?.textColor = .label
//    }
//    
//    override func layoutIfNeeded() {
//        cellActionButtonLabel?.textColor = .label
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    @IBAction func addRemovePressed(_ sender: Any) {
//        
//        delegate?.addRemoveBtnPressed(self)
//        
//    }
//    
//    
//    func configureCell() {
//
//        
//        titleLbl.text = game?.title
//        
//        if let genre = game?.genreDescriptions {
//            genreLbl.text = genre
//        } else {
//            genreLbl.text = " "
//        }
//        if let releaseDate = game?.releaseDate {
//        releaseDateLbl.text = releaseDate
//        } else {
//            releaseDateLbl.text = " "
//        }
//        
//        if let developer = game?.developer {
//        companyLbl.text = developer
//        } else {
//            companyLbl.text = " "
//        }
//        if let platformID = game?.platformID {
//        let platform =
//            self.setPlatformIconName(platformID: Int(platformID), mode: self.traitCollection.userInterfaceStyle)
//            
//            platformLogoImage.image = UIImage(named: platform)
//        }
//        
//        if let platform = game?.platformID {
//            let platformObject = fetchPlatformObject(platformID: platform)
//            platformName = platformObject.name
//        }
//        
//        
//        
//        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            backgroundCell.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -6),
//            addRemoveBtn.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -3)
//        ])
//        
//        backgroundCell.layer.backgroundColor = UIColor.tertiarySystemBackground.cgColor
//        
//        let effect = UIBlurEffect(style: .regular)
//                let effectView = UIVisualEffectView(effect: effect)
//                effectView.frame = portraitImage.bounds
//                effectView.clipsToBounds = false
//
//
//                effectView.alpha = 1
//        
//        landscapeImage.layer.opacity = 1
//        landscapeImage.layer.shadowRadius = 5
//        landscapeImage.layer.shadowOpacity = 0.75
//        landscapeImage.layer.shadowOffset = CGSize(width: 3, height: 3)
//        landscapeImage.layer.shadowColor = UIColor.darkGray.cgColor
//        landscapeImage.clipsToBounds = false
//        landscapeImage.layer.masksToBounds = false
//        landscapeImage.translatesAutoresizingMaskIntoConstraints = false
//        landscapeImage.layer.cornerRadius = 10
//        
//        let landscapeMaskLayer = CAGradientLayer()
//        landscapeMaskLayer.frame = landscapeImageShadow.bounds
//        landscapeMaskLayer.shadowRadius = 4
//        landscapeMaskLayer.shadowPath = CGPath(roundedRect: landscapeImageShadow.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
//        landscapeMaskLayer.shadowOpacity = 1
//        landscapeMaskLayer.shadowOffset = CGSize.zero
//        landscapeMaskLayer.shadowColor = UIColor.darkGray.cgColor
//
//        landscapeImageShadow.layer.mask = landscapeMaskLayer
//        
//        
//        portraitImageShadow.layer.cornerRadius = 10
//
//        portraitImageShadow.layer.opacity = 1
//        portraitImage.layer.opacity = 1
//        portraitImage.layer.shadowRadius = 5
//        portraitImage.layer.shadowOpacity = 0.75
//        portraitImage.layer.shadowOffset = CGSize(width: 3, height: 3)
//        portraitImage.layer.shadowColor = UIColor.darkGray.cgColor
//        portraitImage.clipsToBounds = false
//        portraitImage.layer.masksToBounds = false
//        portraitImage.translatesAutoresizingMaskIntoConstraints = false
//        portraitImage.layer.cornerRadius = 10
//        portraitImageShadow.backgroundColor = .clear
//        
//        
//        let maskLayer = CAGradientLayer()
//        maskLayer.frame = portraitImageShadow.bounds
//        maskLayer.shadowRadius = 4
//        maskLayer.shadowPath = CGPath(roundedRect: portraitImageShadow.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
//        maskLayer.shadowOpacity = 1
//        maskLayer.shadowOffset = CGSize.zero
//        maskLayer.shadowColor = UIColor.darkGray.cgColor
//        
//        portraitImageShadow.layer.mask = maskLayer
//        
//        portraitImageShadow.alpha = 0.75
//        landscapeImageShadow.alpha = 0.75
//        guard let platformID = game?.platformID else {return}
//        let ownedImage = fetchAddToButtonIcon(platformID: platformID, owned: true)
//        let unownedImage = fetchAddToButtonIcon(platformID: platformID, owned: false)
//        guard let gameName = game?.title else { return }
//        guard let gamedID = game?.id else { return }
//        
//        
//        if checkForGameInLibrary(name: gameName, id: gamedID, platformID: platformID) {
//            addRemoveBtn.setImage(UIImage(named: ownedImage), for: .normal)
//        } else {
//            addRemoveBtn.setImage(UIImage(named: unownedImage), for: .normal)
//            
//        }
//        
//        let color1 = UIColorFromRGB(0x2B95CE)
//        let color2 = UIColorFromRGB(0x2ECAD5)
//        addRemoveBtn.layer.cornerRadius = 10
//        addRemoveBtn.layer.shadowColor = UIColor.black.cgColor
//        addRemoveBtn.layer.shadowOffset = CGSize(width: 0, height: 5)
//        addRemoveBtn.layer.shadowRadius = 5
//        addRemoveBtn.layer.shadowOpacity = 0.75
//        addRemoveBtn.applyGradientRounded(layoutIfNeeded: true, colors: [color2.cgColor, color1.cgColor])
//
//        
//        if let boxartImageURL = game?.boxartFrontImage {
//            
//            let urlString = baseURL.coverSmall.rawValue + boxartImageURL
//            
//            let url = URL(string: urlString)!
//            
//            portraitImage.setImageAnimated(imageUrl: url, placeholderImage: nil) {
//                let image = self.portraitImage.image
//                self.landscapeImage.image = image
//                
//                if let boxImage = image {
//                    
//                    let blurredImage = self.blurImage(usingImage: boxImage, blurAmount: 1.5)
//                    self.portraitImageShadow.image = blurredImage
//                    self.landscapeImageShadow.image = blurredImage
//                    
//                    
//                    if let width = self.portraitImage.image?.size.width {
//                        if let height = self.portraitImage.image?.size.height {
//                            
//                            if width > height {
//
//                                self.portraitImage.isHidden = true
//                                self.portraitImageShadow.isHidden = true
//                                self.landscapeImage.isHidden = false
//                                self.landscapeImageShadow.isHidden = false
//                            
//                                
//                            } else {
//
//                                self.portraitImage.isHidden = false
//                                self.portraitImageShadow.isHidden = false
//                                self.landscapeImage.isHidden = true
//                                self.landscapeImageShadow.isHidden = true
//                            }
//                            
//                            
//                        }
//                        
//                    }
//                    
//                    
//                    
//                    
//                    
//                    
//                }
//                
//                
//            }
//        }
//        
//        
//        
//    }
//
//}
//
//
//
//extension AdvancedSearchResultsCell {
//    
//func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool {
//
//    let savedGames = persistenceManager.fetch(SavedGames.self)
//    
//    for savedGame in savedGames {
//        if savedGame.title == name && savedGame.gameID == id && savedGame.platformID == Int64(platformID) {
//            return true
//        }
//    }
//    
//    return false
//    
//}
//
//}
