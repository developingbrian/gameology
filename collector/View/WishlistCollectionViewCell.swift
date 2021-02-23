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
    var shadowLayer : CAShapeLayer?
    var wishlistDelegate : WishlistDelegate?

    
    @IBAction func addToWishlistButtonPressed(_ sender: Any) {


        wishlistDelegate?.didPressManageButton(self)
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
    }
    
}
