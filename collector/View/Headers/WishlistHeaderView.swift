//
//  WishlistHeaderView.swift
//  collector
//
//  Created by Brian on 2/5/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

protocol SectionHeaderDelegate: AnyObject {
    func didPressButton(isOpen: Bool, section: Int)
}


class WishlistHeaderView: UICollectionReusableView {
    
    
    var sectionHeaderDelegate: SectionHeaderDelegate?
    var collectionIsExpanded = false
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    var indexPath : IndexPath?

    var platformName : String?

    var section: SectionData? {
        didSet {
            configureHeader()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        collectionIsExpanded = !collectionIsExpanded
        sectionHeaderDelegate?.didPressButton(isOpen: collectionIsExpanded, section: moreButton.tag)

    }
    
    
    
    func configureHeader() {
        if let platformName = platformName {
        let platformImage = getPlatformImage(platformName: platformName, mode: self.traitCollection.userInterfaceStyle)
            
            headerImageView.image = platformImage
            
        }
        
        if let index = indexPath {
        moreButton.tag = index.section
        }
        if let open = section?.isOpen {
            
        if open {
            moreButton.setTitle("Close", for: .normal)
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            moreButton.setTitle("Open", for: .normal)
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)

        }
            
        }
    }
    
    func getPlatformImage(platformName: String, mode: UIUserInterfaceStyle) -> UIImage {
       
        let platformID = changePlatformNameToID(platformName: platformName)
        let platformIcon = setPlatformIcon(platformID: platformID, mode: mode)
        guard let platformImage = UIImage(named: platformIcon) else { fatalError("no platform icon was found") }
        
        return platformImage
    }
    

    
}
