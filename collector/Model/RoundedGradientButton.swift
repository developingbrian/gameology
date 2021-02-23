//
//  RoundedGradientButton.swift
//  collector
//
//  Created by Brian on 2/11/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class RoundedGradientButton: UIButton {

    private var shadowLayer : CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
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
//
//            layer.insertSublayer(shadowLayer, at: 0)
//            //layer.insertSublayer(shadowLayer, below: nil) // also works
            let lightBlue = UIColorFromRGB(0x2B95CE)
            let blue = UIColorFromRGB(0x2ECAD5)
            self.applyGradientRounded(layoutIfNeeded: false, colors: [ blue.cgColor, lightBlue.cgColor])
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = colors
//            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
//            gradientLayer.frame = self.bounds
//            self.layer.cornerRadius = 10
//            gradientLayer.cornerRadius = 10
//
//            gradientLayer.shadowColor = UIColor.darkGray.cgColor
//            gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//            gradientLayer.shadowRadius = 5.0
//            gradientLayer.shadowOpacity = 0.3
//            gradientLayer.masksToBounds = false
//
//            self.layer.insertSublayer(gradientLayer, at: 0)
//            self.contentVerticalAlignment = .center
//            self.setTitleColor(UIColor.white, for: .normal)
//    //        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
//            self.titleLabel?.textColor = UIColor.white
            
//        }
    }
        
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
   }
    }


