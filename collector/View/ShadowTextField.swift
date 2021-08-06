//
//  ShadowTextField.swift
//  collector
//
//  Created by Brian on 1/20/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

final class ShadowTextField: UITextField {

    private var shadowLayer: CAShapeLayer!

    override class func awakeFromNib() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            if traitCollection.userInterfaceStyle == .light {
            shadowLayer.fillColor = UIColor.tertiarySystemBackground.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            } else {
                shadowLayer.fillColor = UIColor.tertiarySystemBackground.cgColor
                shadowLayer.shadowColor = UIColor.gray.cgColor
            }
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
        if traitCollection.userInterfaceStyle == .light {
        shadowLayer.fillColor = UIColor.tertiarySystemBackground.cgColor

        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        } else {
            shadowLayer.fillColor = UIColor.tertiarySystemBackground.cgColor
            shadowLayer.shadowColor = UIColor.gray.cgColor
        }
        
    }

}
