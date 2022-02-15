//
//  RoundedShadowView.swift
//  collector
//
//  Created by Brian on 1/19/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

final class RoundedShadowView: UIView {


    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
                    if traitCollection.userInterfaceStyle == .light {
                  
        
                        self.layer.shadowColor = UIColor.darkGray.cgColor
                    } else {
              
                        self.layer.shadowColor = UIColor.gray.cgColor
                    }
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath

    }
}
