//
//  BoxartCollectionViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class BoxartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boxartImageView: UIImageView!
    
    
    var game : GameObject? {
        didSet {
            self.configureCell()
        }
    }
    
    override class func awakeFromNib() {
    }
    
    
    
}


extension BoxartCollectionViewCell {
    
    func configureCell() {
        if let boxartURL = game?.boxartFrontImage {
            
            let imageURLString = baseURL.coverSmall.rawValue + boxartURL
            
            let imageURL = URL(string: imageURLString)!
            
            self.boxartImageView.setImageAnimated(imageUrl: imageURL, placeholderImage: nil, completed: {
                
            })
        }
        
        boxartImageView.layer.cornerRadius = 12
    }
}
