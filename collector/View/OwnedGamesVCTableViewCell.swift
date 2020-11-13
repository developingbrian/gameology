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

protocol OwnedGameDelegate: class {
    
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
    let persistenceManager = PersistenceManager.shared
    var ownedGames = [SavedGames]()
    var index : IndexPath?
    var id : Int?
    var platformName : String?
    var platformID : Int?
    var gameName : String?
    
    weak var delegate : OwnedGameDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCells()
        let effect = UIBlurEffect(style: .regular)
                let effectView = UIVisualEffectView(effect: effect)
        
                effectView.frame = boxartShadowImageView.bounds
                effectView.clipsToBounds = false
        
        //        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                effectView.alpha = 1
      
                let maskLayer = CAGradientLayer()
                maskLayer.frame = boxartShadowImageView.bounds
                maskLayer.shadowRadius = 8
                maskLayer.shadowPath = CGPath(roundedRect: boxartShadowImageView.bounds.insetBy(dx: 9, dy: 9), cornerWidth: 11, cornerHeight: 11, transform: nil)
                maskLayer.shadowOpacity = 1
                maskLayer.shadowOffset = CGSize.zero
                if traitCollection.userInterfaceStyle == .light {
                maskLayer.shadowColor = UIColor.black.cgColor
                } else {
                    maskLayer.shadowColor = UIColor.white.cgColor
                }
                boxartShadowImageView.layer.mask = maskLayer
        
                boxartShadowImageView.addSubview(effectView)
        
         boxartShadowImageView.layer.opacity = 1

               boxartShadowImageView.layer.cornerRadius = 10
               
               backgroundCell.layer.shadowOffset = CGSize(width: 0, height: 5)
               backgroundCell.layer.shadowRadius = 5
               backgroundCell.layer.shadowOpacity = 0.1
               backgroundCell.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func removeFromLibraryBtnPressed(_ sender: Any) {
        
        delegate?.removeFromLibrary(index: index!)
        
        
    }
    
    
    func configureCells() {
        if self.traitCollection.userInterfaceStyle == .light {
            backgroundCell.layer.shadowColor = UIColor.black.cgColor
            backgroundCell.layer.backgroundColor = UIColor.white.cgColor
            removeFromLibraryBtn.setTitleColor(UIColor.black, for: .normal)
            removeFromLibraryBtn.tintColor = UIColor.black
        } else {
            backgroundCell.layer.shadowColor = UIColor.white.cgColor
            backgroundCell.layer.backgroundColor = UIColor.black.cgColor
            removeFromLibraryBtn.setTitleColor(UIColor.white, for: .normal)
            removeFromLibraryBtn.tintColor = UIColor.white
        }
        
    }

    
    
}
