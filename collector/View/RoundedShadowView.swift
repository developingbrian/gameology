//
//  RoundedShadowView.swift
//  collector
//
//  Created by Brian on 1/19/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

final class RoundedShadowView: UIView {

//    private var shadowLayer: CAShapeLayer!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 12
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 2
        
                    if traitCollection.userInterfaceStyle == .light {
                        self.layer.backgroundColor = UIColor.white.cgColor
        
                        self.layer.shadowColor = UIColor.darkGray.cgColor
                    } else {
                        self.layer.backgroundColor = UIColor.tertiarySystemBackground.cgColor
                        self.layer.shadowColor = UIColor.gray.cgColor
                    }
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.layer.frame.width * 1.04, height: self.layer.frame.height), cornerRadius: 12).cgPath
//
//            if traitCollection.userInterfaceStyle == .light {
//            shadowLayer.fillColor = UIColor.white.cgColor
//
//            shadowLayer.shadowColor = UIColor.darkGray.cgColor
//            } else {
//                shadowLayer.fillColor = UIColor.tertiarySystemBackground.cgColor
//                shadowLayer.shadowColor = UIColor.gray.cgColor
//            }
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
//            shadowLayer.shadowOpacity = 0.7
//            shadowLayer.shadowRadius = 2
//            shadowLayer.frame = self.layer.bounds
//
//
//
//            layer.insertSublayer(shadowLayer, at: 0)
//            self.translatesAutoresizingMaskIntoConstraints = false
////            self.layer.insertSublayer(shadowLayer, below: nil) // also works
//
//        }
//    }
    }
}
