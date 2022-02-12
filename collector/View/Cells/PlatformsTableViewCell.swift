//
//  PlatformsTableViewCell.swift
//  collector
//
//  Created by Brian on 10/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import CoreData


class PlatformsTableViewCell: UITableViewCell {
    @IBOutlet weak var platformBanner: UIImageView!
    @IBOutlet weak var ownedTotalLbl: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    var persistenceManager = PersistenceManager.shared
    var game : Platform? {
        didSet {
            
            configureCell()
        }
        
    }
    var savedPlatforms = [Platform]()
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension PlatformsTableViewCell {
    
    
    func configureCell() {
        guard let game = game else { return }
        let platform = fetchCoreDataPlatformObject(id: Int(game.id))
        
        if game.name == "0All Games" {
            
            for platform in savedPlatforms {
                
                count += platform.games!.count
            }
            
            for platform in savedPlatforms {
                if platform.id == 0 {
                    ownedTotalLbl.isHidden = true
                    ownedLabel.isHidden = true
                    
                }
            }
            ownedTotalLbl.text = "\(count)"
            
        } else {
            ownedTotalLbl.text = "\(platform.games!.count)"
        }
        let platformName = self.setPlatformIcon(platformID: Int(game.id), mode: self.traitCollection.userInterfaceStyle)
        platformBanner.image = UIImage(named: platformName)
        
        
        
    }
    
    func fetchCoreDataPlatformObject(id: Int) -> Platform {
        
        let platform = persistenceManager.fetchFilteredByPlatform(Platform.self, platformID: id)
        
        let platformobj = platform[0]
        
        return platformobj
    }
    
}
