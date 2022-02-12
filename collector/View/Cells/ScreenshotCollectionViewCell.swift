//
//  ScreenshotCollectionViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    var game : GameObject? {
        didSet {
            self.configureCell()
            
        }
    }
    var indexPath : IndexPath?
    
    
}


extension ScreenshotCollectionViewCell {
    
    
    func configureCell() {
        guard let indexPath = indexPath else { return }
        if let screenshots = game?.screenshots {
            if let imageID = screenshots[indexPath.item].imageID {
                let screenshotURL = imageID + ".jpg"
                let imageURLString = baseURL.screenshotLarge.rawValue + screenshotURL
                let imageURL = URL(string: imageURLString)!
                self.screenshotImageView.setImageAnimated(imageUrl: imageURL, placeholderImage: nil) {
                    
                }
            }
        }
        screenshotImageView.layer.cornerRadius = 12
        
    }
    
}
