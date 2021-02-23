//
//  CustomButton.swift
//  collector
//
//  Created by Brian on 1/15/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

final class CustomButton: UIButton {

    private var shadowLayer: CAShapeLayer!

    override func awakeFromNib() {
        super.awakeFromNib()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            if traitCollection.userInterfaceStyle == .light {
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            } else {
                shadowLayer.fillColor = UIColor.tertiarySystemBackground.cgColor
                shadowLayer.shadowColor = UIColor.gray.cgColor
            }
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.7
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }

}
