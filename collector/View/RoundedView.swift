//
//  RoundedView.swift
//  gameology
//
//  Created by Brian on 1/10/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit

@IBDesignable

 class RoundedLabel : UILabel {
     private var fillColor: UIColor = .clear
     
        @IBInspectable var cornerRadius: CGFloat = 0 {
           didSet {

//               backgroundColor = .blue
               layer.cornerRadius = cornerRadius
               layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
               layer.masksToBounds = true
               

           }
        }

    
     
     
   
     
//     lazy var shadowLayer : CAShapeLayer = {
//         let s = CAShapeLayer()
//           // set your button color HERE (NOT on storyboard)
//           s.fillColor = UIColor.clear.cgColor
//           // now set your shadow color/values
//           s.shadowColor = UIColor.red.cgColor
//           s.shadowOffset = CGSize(width: 0, height: 10)
//           s.shadowOpacity = 1
//           s.shadowRadius = 10
//           // now add the shadow
//           layer.insertSublayer(s, at: 0)
//           return s
//
//     }()
//
//
//
//     override func layoutSubviews() {
//         super.layoutSubviews()
//
//            shadowLayer.frame = bounds
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//
//
//
//    }

    
    
    var points: [CGPoint] = [
        CGPoint(x: 1, y: 0.1),
        CGPoint(x: 0.9, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 1, y: 1)
    ] { didSet { setNeedsLayout() } }
    
    

    
    
}


@IBDesignable

public class ShadowView : UIView {
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
//            layer.shadowColor = UIColor.red.cgColor
//            layer.shadowOffset = CGSize(width: 0, height: 10)
//            layer.shadowOpacity = 1
            layer.shadowRadius = shadowRadius
            
            
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.black {
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
            
        }
    }
    
    @IBInspectable var shadowOffset : CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    
}


@IBDesignable

public class RoundedView : UIView {
    
        @IBInspectable var cornerRadius: CGFloat = 0 {
           didSet {
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = true
               layer.masksToBounds = cornerRadius > 0
           }
        }
    
    @IBInspectable var shadowRadius : CGFloat = 0 {
        
        didSet {
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
    }
    
    var points: [CGPoint] = [
        CGPoint(x: 1, y: 0.1),
        CGPoint(x: 0.9, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 1, y: 1)
    ] { didSet { setNeedsLayout() } }
    
    
    
    
    
}
