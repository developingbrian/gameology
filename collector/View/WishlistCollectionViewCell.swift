//
//  WishlistCollectionViewCell.swift
//  collector
//
//  Created by Brian on 1/27/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var boxartImageView: UIImageView!

    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var addToLibraryButton: UIButton!
    
    @IBOutlet weak var roundedBackground: UIView!
    var game : WishList? {
        didSet {
            configureCell()
        }
    }
    var wishlistDelegate : WishlistDelegate?

    
    @IBAction func addToWishlistButtonPressed(_ sender: Any) {


        wishlistDelegate?.didPressManageButton(self)
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
    }
    
    override func prepareForReuse() {
        boxartImageView.image = nil
    }
    
    func configureCell() {
        
        roundedBackground.translatesAutoresizingMaskIntoConstraints = false
        boxartImageView.translatesAutoresizingMaskIntoConstraints = false
        gameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addToLibraryButton.translatesAutoresizingMaskIntoConstraints = false
        
        roundedBackground.layer.shadowOpacity = 0.75
        roundedBackground.layer.cornerRadius = 10
        roundedBackground .layer.shadowRadius = 2
        roundedBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        roundedBackground.layer.shadowColor = UIColor.gray.cgColor
        
//        boxartImageView.layer.cornerRadius = 10
        boxartImageView.clipsToBounds = false
        boxartImageView.layer.shadowOpacity = 1
        boxartImageView.layer.shadowRadius = 2
        boxartImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        boxartImageView.layer.shadowColor = UIColor.gray.cgColor
        
        if let boxartURL = game?.boxartImageURL {
            let url = URL(string: baseURL.coverSmall.rawValue + boxartURL)!
            
            boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                
            }
            
        } else {
            boxartImageView.image = UIImage(named: "noBoxart")
            
        }
        
        
        if let title = game?.title {
            gameTitleLabel.text = title
        }
        
        addToLibraryButton.setTitle("Manage", for: .normal)
        
        addToLibraryButton.setTitleColor(.white, for: .normal)
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let blue = UIColorFromRGB(0x2ECAD5)
        
        addToLibraryButton.applyGradientRounded(layoutIfNeeded: true, colors: [blue.cgColor, lightBlue.cgColor])
        
        
        
        
    }
    
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
   }
    
}
