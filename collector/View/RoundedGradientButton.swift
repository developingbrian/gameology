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
    let gradientLayer = CAGradientLayer()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.layer.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let blue = UIColorFromRGB(0x2ECAD5)
        
        gradientLayer.colors = [lightBlue, blue]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.cornerRadius = 10
        gradientLayer.cornerRadius = 10
        self.layer.addSublayer(gradientLayer)
        
    }
    
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    
}


