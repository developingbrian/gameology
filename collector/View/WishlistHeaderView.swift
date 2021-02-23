//
//  WishlistHeaderView.swift
//  collector
//
//  Created by Brian on 2/5/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

protocol SectionHeaderDelegate: class {
    func didPressButton(isOpen: Bool, section: Int)
}


class WishlistHeaderView: UICollectionReusableView {
    
    var sectionHeaderDelegate: SectionHeaderDelegate?
    var collectionIsExpanded = false
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        collectionIsExpanded = !collectionIsExpanded
        sectionHeaderDelegate?.didPressButton(isOpen: collectionIsExpanded, section: moreButton.tag)
        print("more button pressed")
    }
    
}
