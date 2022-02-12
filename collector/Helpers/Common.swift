//
//  Common.swift
//  collector
//
//  Created by Brian on 8/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

var imageCache = NSCache<AnyObject, UIImage>()
let testimageCache = NSCache<NSString, UIImage>()
var vSpinner : UIView?
let network = Networking.shared

extension UIButton {

    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat) {
            self.contentEdgeInsets = UIEdgeInsets(
                top: contentPadding.top,
                left: contentPadding.left,
                bottom: contentPadding.bottom,
                right: contentPadding.right + imageTitlePadding
            )
            self.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: imageTitlePadding,
                bottom: 0,
                right: -imageTitlePadding
            )
        }
    func applyGradients(colors: [CGColor]) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    
    func applyGradient(colors: [CGColor]) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
    
    func moveImageLeftTextCenter(imagePadding: CGFloat = 30.0){
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 5.0, left: imagePadding - imageViewWidth / 2, bottom: 5.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: (bounds.width - titleLabelWidth) / 2 - imageViewWidth, bottom: 0.0, right: 0.0)
    }
    
    
    
     func applyGradientRounded(layoutIfNeeded: Bool, colors: [CGColor]) {
        self.backgroundColor = nil
        if layoutIfNeeded {
            self.layoutIfNeeded()
            
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.cornerRadius = 4
        gradientLayer.cornerRadius = 4
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        self.titleEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.textColor = UIColor.white
        self.tintColor = .white
    }
    
    
}


//extension UILabel {
//
//
//    func applyGradientRounded(layoutIfNeeded: Bool, colors: [CGColor]) {
//        self.backgroundColor = nil
//        if layoutIfNeeded {
//            self.layoutIfNeeded()
//
//        }
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
//        gradientLayer.frame = self.bounds
//        self.layer.cornerRadius = 10
//        gradientLayer.cornerRadius = 10
//        gradientLayer.masksToBounds = false
//
//        self.layer.insertSublayer(gradientLayer, at: 0)
//
//        self.textAlignment = .center
//        self.textColor = .white
//    }
//
//}



extension UIBezierPath {
    static func calculateBounds(paths: [UIBezierPath]) -> CGRect {
        let myPaths = UIBezierPath()
        for path in paths {
            myPaths.append(path)
        }
        return (myPaths.bounds)
    }
    
    
    static var gLogoFill: UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 795.23, y: 132.27))
        shape.addCurve(to: CGPoint(x: 770.23, y: 137.54), controlPoint1: CGPoint(x: 786.9, y: 134.04), controlPoint2: CGPoint(x: 778.63, y: 136.06))
        shape.addCurve(to: CGPoint(x: 694.09, y: 142.54), controlPoint1: CGPoint(x: 745.05, y: 142.01), controlPoint2: CGPoint(x: 719.58, y: 142.71))
        shape.addCurve(to: CGPoint(x: 644.78, y: 141.33), controlPoint1: CGPoint(x: 677.65, y: 142.42), controlPoint2: CGPoint(x: 661.18, y: 142.31))
        shape.addCurve(to: CGPoint(x: 570.36, y: 125.96), controlPoint1: CGPoint(x: 619.28, y: 139.81), controlPoint2: CGPoint(x: 594.19, y: 135.69))
        shape.addCurve(to: CGPoint(x: 551.68, y: 116.96), controlPoint1: CGPoint(x: 563.98, y: 123.36), controlPoint2: CGPoint(x: 557.86, y: 120.06))
        shape.addCurve(to: CGPoint(x: 540.19, y: 110.81), controlPoint1: CGPoint(x: 547.8, y: 115.02), controlPoint2: CGPoint(x: 544.01, y: 112.87))
        shape.addCurve(to: CGPoint(x: 490.19, y: 97.72), controlPoint1: CGPoint(x: 524.8, y: 102.54), controlPoint2: CGPoint(x: 507.66, y: 98.06))
        shape.addCurve(to: CGPoint(x: 387.56, y: 123.72), controlPoint1: CGPoint(x: 453.52, y: 96.72), controlPoint2: CGPoint(x: 419.35, y: 105.72))
        shape.addCurve(to: CGPoint(x: 341.35, y: 176.98), controlPoint1: CGPoint(x: 365.92, y: 135.96), controlPoint2: CGPoint(x: 349.97, y: 153.45))
        shape.addCurve(to: CGPoint(x: 323.49, y: 228.49), controlPoint1: CGPoint(x: 335.1, y: 194.04), controlPoint2: CGPoint(x: 329.35, y: 211.29))
        shape.addCurve(to: CGPoint(x: 280.02, y: 371.02), controlPoint1: CGPoint(x: 307.48, y: 275.52), controlPoint2: CGPoint(x: 292.78, y: 323.02))
        shape.addCurve(to: CGPoint(x: 254.55, y: 487.45), controlPoint1: CGPoint(x: 269.81, y: 409.46), controlPoint2: CGPoint(x: 261.02, y: 448.22))
        shape.addCurve(to: CGPoint(x: 246.73, y: 583.66), controlPoint1: CGPoint(x: 249.27, y: 519.29), controlPoint2: CGPoint(x: 246.08, y: 551.35))
        shape.addCurve(to: CGPoint(x: 250.55, y: 647.33), controlPoint1: CGPoint(x: 247.16, y: 604.93), controlPoint2: CGPoint(x: 247.78, y: 626.2))
        shape.addCurve(to: CGPoint(x: 261.06, y: 689.33), controlPoint1: CGPoint(x: 252.44, y: 661.73), controlPoint2: CGPoint(x: 255.49, y: 675.86))
        shape.addCurve(to: CGPoint(x: 289.88, y: 720.33), controlPoint1: CGPoint(x: 266.8, y: 703.25), controlPoint2: CGPoint(x: 275.75, y: 714.24))
        shape.addCurve(to: CGPoint(x: 317.29, y: 724.95), controlPoint1: CGPoint(x: 298.62, y: 724.11), controlPoint2: CGPoint(x: 307.88, y: 725.24))
        shape.addCurve(to: CGPoint(x: 366.38, y: 713.35), controlPoint1: CGPoint(x: 334.45, y: 724.44), controlPoint2: CGPoint(x: 350.59, y: 719.63))
        shape.addCurve(to: CGPoint(x: 426.43, y: 681.54), controlPoint1: CGPoint(x: 387.55, y: 704.93), controlPoint2: CGPoint(x: 407.27, y: 693.76))
        shape.addCurve(to: CGPoint(x: 461.89, y: 656.4), controlPoint1: CGPoint(x: 438.66, y: 673.74), controlPoint2: CGPoint(x: 450.82, y: 665.83))
        shape.addCurve(to: CGPoint(x: 484.8, y: 631), controlPoint1: CGPoint(x: 470.7, y: 649.07), controlPoint2: CGPoint(x: 478.41, y: 640.52))
        shape.addCurve(to: CGPoint(x: 490.98, y: 568.43), controlPoint1: CGPoint(x: 497.8, y: 611.2), controlPoint2: CGPoint(x: 500.04, y: 590.25))
        shape.addCurve(to: CGPoint(x: 478.41, y: 544), controlPoint1: CGPoint(x: 487.47, y: 560), controlPoint2: CGPoint(x: 482.91, y: 551.97))
        shape.addCurve(to: CGPoint(x: 465.98, y: 516.36), controlPoint1: CGPoint(x: 473.41, y: 535.14), controlPoint2: CGPoint(x: 468.6, y: 526.27))
        shape.addCurve(to: CGPoint(x: 472.92, y: 473.47), controlPoint1: CGPoint(x: 461.91, y: 501.01), controlPoint2: CGPoint(x: 464.05, y: 486.73))
        shape.addCurve(to: CGPoint(x: 501.3, y: 446.18), controlPoint1: CGPoint(x: 480.39, y: 462.29), controlPoint2: CGPoint(x: 490.1, y: 453.41))
        shape.addCurve(to: CGPoint(x: 574.88, y: 417.12), controlPoint1: CGPoint(x: 523.62, y: 431.63), controlPoint2: CGPoint(x: 548.65, y: 421.74))
        shape.addCurve(to: CGPoint(x: 748.76, y: 459.36), controlPoint1: CGPoint(x: 638.88, y: 405.91), controlPoint2: CGPoint(x: 696.59, y: 421.93))
        shape.addCurve(to: CGPoint(x: 821.02, y: 542.49), controlPoint1: CGPoint(x: 779.33, y: 481.29), controlPoint2: CGPoint(x: 803.85, y: 508.81))
        shape.addCurve(to: CGPoint(x: 838.61, y: 613.04), controlPoint1: CGPoint(x: 832.29, y: 564.62), controlPoint2: CGPoint(x: 838.72, y: 588.05))
        shape.addCurve(to: CGPoint(x: 831.72, y: 665.04), controlPoint1: CGPoint(x: 838.53, y: 630.65), controlPoint2: CGPoint(x: 836.61, y: 648.04))
        shape.addCurve(to: CGPoint(x: 831.07, y: 666.85), controlPoint1: CGPoint(x: 831.59, y: 665.67), controlPoint2: CGPoint(x: 831.38, y: 666.28))
        shape.addCurve(to: CGPoint(x: 822.07, y: 680.95), controlPoint1: CGPoint(x: 827.97, y: 671.48), controlPoint2: CGPoint(x: 825.88, y: 676.69))
        shape.addCurve(to: CGPoint(x: 611.82, y: 815.47), controlPoint1: CGPoint(x: 764.53, y: 745.45), controlPoint2: CGPoint(x: 693.94, y: 789.48))
        shape.addCurve(to: CGPoint(x: 521.24, y: 834.67), controlPoint1: CGPoint(x: 582.31, y: 824.75), controlPoint2: CGPoint(x: 551.98, y: 831.18))
        shape.addCurve(to: CGPoint(x: 430.02, y: 837.02), controlPoint1: CGPoint(x: 490.97, y: 838.15), controlPoint2: CGPoint(x: 460.44, y: 838.93))
        shape.addCurve(to: CGPoint(x: 277.02, y: 802.9), controlPoint1: CGPoint(x: 377.52, y: 833.95), controlPoint2: CGPoint(x: 325.86, y: 822.42))
        shape.addCurve(to: CGPoint(x: 93.75, y: 671.02), controlPoint1: CGPoint(x: 205.02, y: 774.02), controlPoint2: CGPoint(x: 143.42, y: 730.76))
        shape.addCurve(to: CGPoint(x: 10.86, y: 504.95), controlPoint1: CGPoint(x: 53.12, y: 622.2), controlPoint2: CGPoint(x: 25.12, y: 566.95))
        shape.addCurve(to: CGPoint(x: 2.49, y: 391.17), controlPoint1: CGPoint(x: 2.25, y: 467.68), controlPoint2: CGPoint(x: -0.57, y: 429.3))
        shape.addCurve(to: CGPoint(x: 121.75, y: 138.08), controlPoint1: CGPoint(x: 10.49, y: 291.86), controlPoint2: CGPoint(x: 51.82, y: 208.09))
        shape.addCurve(to: CGPoint(x: 321.02, y: 21.58), controlPoint1: CGPoint(x: 177.88, y: 81.9), controlPoint2: CGPoint(x: 245.02, y: 44.02))
        shape.addCurve(to: CGPoint(x: 408.57, y: 4.35), controlPoint1: CGPoint(x: 349.62, y: 13.19), controlPoint2: CGPoint(x: 378.93, y: 7.42))
        shape.addCurve(to: CGPoint(x: 505.17, y: 3.35), controlPoint1: CGPoint(x: 440.67, y: 0.91), controlPoint2: CGPoint(x: 473.02, y: 0.57))
        shape.addCurve(to: CGPoint(x: 731.35, y: 80.4), controlPoint1: CGPoint(x: 586.85, y: 10.53), controlPoint2: CGPoint(x: 662.49, y: 35.57))
        shape.addCurve(to: CGPoint(x: 791.83, y: 127.69), controlPoint1: CGPoint(x: 752.83, y: 94.4), controlPoint2: CGPoint(x: 773.07, y: 110.22))
        shape.addCurve(to: CGPoint(x: 795.29, y: 130.98), controlPoint1: CGPoint(x: 792.99, y: 128.78), controlPoint2: CGPoint(x: 794.13, y: 129.88))
        shape.addLine(to: CGPoint(x: 795.23, y: 132.27))
        shape.close()
        return shape
    }
    
    static var gLogoShape : UIBezierPath {
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 794.83, y: 130.82))
        shape.addCurve(to: CGPoint(x: 737.97, y: 139.92), controlPoint1: CGPoint(x: 775.93, y: 134.88), controlPoint2: CGPoint(x: 757.3, y: 138.56))
        shape.addCurve(to: CGPoint(x: 681.78, y: 140.92), controlPoint1: CGPoint(x: 719.27, y: 141.24), controlPoint2: CGPoint(x: 700.51, y: 141.11))
        shape.addCurve(to: CGPoint(x: 573.02, y: 125.37), controlPoint1: CGPoint(x: 645.02, y: 140.54), controlPoint2: CGPoint(x: 607.65, y: 139.02))
        shape.addCurve(to: CGPoint(x: 524.69, y: 102.37), controlPoint1: CGPoint(x: 556.37, y: 118.83), controlPoint2: CGPoint(x: 541.6, y: 108.19))
        shape.addCurve(to: CGPoint(x: 475.53, y: 96.37), controlPoint1: CGPoint(x: 508.84, y: 96.88), controlPoint2: CGPoint(x: 492.19, y: 95.62))
        shape.addCurve(to: CGPoint(x: 383.53, y: 124.37), controlPoint1: CGPoint(x: 443.02, y: 97.92), controlPoint2: CGPoint(x: 411.4, y: 107.54))
        shape.addCurve(to: CGPoint(x: 353.34, y: 151.52), controlPoint1: CGPoint(x: 371.81, y: 131.38), controlPoint2: CGPoint(x: 361.56, y: 140.6))
        shape.addCurve(to: CGPoint(x: 333.84, y: 193.7), controlPoint1: CGPoint(x: 343.91, y: 164.23), controlPoint2: CGPoint(x: 338.99, y: 178.91))
        shape.addCurve(to: CGPoint(x: 298.14, y: 302.14), controlPoint1: CGPoint(x: 321.32, y: 229.63), controlPoint2: CGPoint(x: 309.23, y: 265.7))
        shape.addCurve(to: CGPoint(x: 248.28, y: 521.59), controlPoint1: CGPoint(x: 276.35, y: 373.68), controlPoint2: CGPoint(x: 256.6, y: 447.14))
        shape.addCurve(to: CGPoint(x: 247.59, y: 634.36), controlPoint1: CGPoint(x: 244.23, y: 559.06), controlPoint2: CGPoint(x: 244, y: 596.85))
        shape.addCurve(to: CGPoint(x: 258.17, y: 686.18), controlPoint1: CGPoint(x: 249.23, y: 651.94), controlPoint2: CGPoint(x: 251.91, y: 669.59))
        shape.addCurve(to: CGPoint(x: 281.44, y: 717.62), controlPoint1: CGPoint(x: 262.89, y: 698.7), controlPoint2: CGPoint(x: 270.03, y: 710.18))
        shape.addCurve(to: CGPoint(x: 376.44, y: 710.84), controlPoint1: CGPoint(x: 309.88, y: 736.1), controlPoint2: CGPoint(x: 348.28, y: 723.3))
        shape.addCurve(to: CGPoint(x: 423.27, y: 685.42), controlPoint1: CGPoint(x: 392.64, y: 703.5), controlPoint2: CGPoint(x: 408.29, y: 695))
        shape.addCurve(to: CGPoint(x: 465.66, y: 655.2), controlPoint1: CGPoint(x: 437.95, y: 676.22), controlPoint2: CGPoint(x: 452.71, y: 666.77))
        shape.addCurve(to: CGPoint(x: 493.74, y: 617.1), controlPoint1: CGPoint(x: 477.43, y: 644.7), controlPoint2: CGPoint(x: 488.04, y: 631.97))
        shape.addCurve(to: CGPoint(x: 493.55, y: 570.97), controlPoint1: CGPoint(x: 499.44, y: 602.23), controlPoint2: CGPoint(x: 499.09, y: 585.92))
        shape.addCurve(to: CGPoint(x: 470.05, y: 524.02), controlPoint1: CGPoint(x: 487.43, y: 554.48), controlPoint2: CGPoint(x: 476.44, y: 540.37))
        shape.addCurve(to: CGPoint(x: 474.22, y: 474.32), controlPoint1: CGPoint(x: 463.48, y: 507.2), controlPoint2: CGPoint(x: 464.1, y: 489.59))
        shape.addCurve(to: CGPoint(x: 511.41, y: 441.87), controlPoint1: CGPoint(x: 483.53, y: 460.32), controlPoint2: CGPoint(x: 496.96, y: 450.17))
        shape.addCurve(to: CGPoint(x: 558.26, y: 422.44), controlPoint1: CGPoint(x: 526.12, y: 433.39), controlPoint2: CGPoint(x: 541.87, y: 426.86))
        shape.addCurve(to: CGPoint(x: 655.45, y: 419.2), controlPoint1: CGPoint(x: 589.99, y: 413.99), controlPoint2: CGPoint(x: 623.23, y: 412.88))
        shape.addCurve(to: CGPoint(x: 809.58, y: 525.48), controlPoint1: CGPoint(x: 717.58, y: 431.54), controlPoint2: CGPoint(x: 775.84, y: 471.94))
        shape.addCurve(to: CGPoint(x: 830.68, y: 570.19), controlPoint1: CGPoint(x: 818.39, y: 539.48), controlPoint2: CGPoint(x: 825.82, y: 554.38))
        shape.addCurve(to: CGPoint(x: 836.89, y: 622.72), controlPoint1: CGPoint(x: 835.93, y: 587.3), controlPoint2: CGPoint(x: 837.68, y: 604.87))
        shape.addCurve(to: CGPoint(x: 833.66, y: 650.72), controlPoint1: CGPoint(x: 836.51, y: 632.12), controlPoint2: CGPoint(x: 835.43, y: 641.48))
        shape.addCurve(to: CGPoint(x: 830.51, y: 663.93), controlPoint1: CGPoint(x: 832.79, y: 655.15), controlPoint2: CGPoint(x: 831.81, y: 659.6))
        shape.addCurve(to: CGPoint(x: 824.51, y: 675.14), controlPoint1: CGPoint(x: 829.33, y: 667.84), controlPoint2: CGPoint(x: 826.63, y: 671.64))
        shape.addCurve(to: CGPoint(x: 807.98, y: 694), controlPoint1: CGPoint(x: 820.21, y: 682.14), controlPoint2: CGPoint(x: 813.67, y: 688.14))
        shape.addCurve(to: CGPoint(x: 791.53, y: 710.17), controlPoint1: CGPoint(x: 802.65, y: 699.53), controlPoint2: CGPoint(x: 797.17, y: 704.92))
        shape.addCurve(to: CGPoint(x: 632.82, y: 806.76), controlPoint1: CGPoint(x: 745.85, y: 752.87), controlPoint2: CGPoint(x: 691.53, y: 785.38))
        shape.addCurve(to: CGPoint(x: 416.02, y: 834.45), controlPoint1: CGPoint(x: 563.57, y: 832.02), controlPoint2: CGPoint(x: 489.33, y: 840.94))
        shape.addCurve(to: CGPoint(x: 219.8, y: 773.95), controlPoint1: CGPoint(x: 347.08, y: 828.38), controlPoint2: CGPoint(x: 280.2, y: 807.76))
        shape.addCurve(to: CGPoint(x: 77.58, y: 647.82), controlPoint1: CGPoint(x: 163.86, y: 742.65), controlPoint2: CGPoint(x: 115.35, y: 699.62))
        shape.addCurve(to: CGPoint(x: 5.02, y: 462.02), controlPoint1: CGPoint(x: 38.09, y: 593.34), controlPoint2: CGPoint(x: 12.47, y: 528.95))
        shape.addCurve(to: CGPoint(x: 33.4, y: 269.44), controlPoint1: CGPoint(x: -2.04, y: 396.46), controlPoint2: CGPoint(x: 7.73, y: 330.18))
        shape.addCurve(to: CGPoint(x: 141.01, y: 121.91), controlPoint1: CGPoint(x: 57.4, y: 212.86), controlPoint2: CGPoint(x: 95.4, y: 162.82))
        shape.addCurve(to: CGPoint(x: 305.46, y: 28.01), controlPoint1: CGPoint(x: 188.51, y: 79.35), controlPoint2: CGPoint(x: 245.01, y: 47.91))
        shape.addCurve(to: CGPoint(x: 524.02, y: 6.86), controlPoint1: CGPoint(x: 375.87, y: 4.96), controlPoint2: CGPoint(x: 450.5, y: -2.26))
        shape.addCurve(to: CGPoint(x: 712.02, y: 70.18), controlPoint1: CGPoint(x: 590.24, y: 15.02), controlPoint2: CGPoint(x: 654.48, y: 36.26))
        shape.addCurve(to: CGPoint(x: 753.34, y: 97.54), controlPoint1: CGPoint(x: 726.27, y: 78.56), controlPoint2: CGPoint(x: 740.07, y: 87.69))
        shape.addCurve(to: CGPoint(x: 774.69, y: 114.48), controlPoint1: CGPoint(x: 760.64, y: 102.96), controlPoint2: CGPoint(x: 767.75, y: 108.61))
        shape.addCurve(to: CGPoint(x: 783.97, y: 122.55), controlPoint1: CGPoint(x: 777.83, y: 117.15), controlPoint2: CGPoint(x: 780.92, y: 119.84))
        shape.addCurve(to: CGPoint(x: 789.1, y: 127.2), controlPoint1: CGPoint(x: 785.69, y: 124.09), controlPoint2: CGPoint(x: 787.4, y: 125.64))
        shape.addCurve(to: CGPoint(x: 793.76, y: 132.27), controlPoint1: CGPoint(x: 790.1, y: 128.2), controlPoint2: CGPoint(x: 793.83, y: 130.72))
        shape.addCurve(to: CGPoint(x: 796.76, y: 132.27), controlPoint1: CGPoint(x: 793.67, y: 134.2), controlPoint2: CGPoint(x: 796.67, y: 134.19))
        shape.addCurve(to: CGPoint(x: 791.22, y: 125.08), controlPoint1: CGPoint(x: 796.91, y: 129), controlPoint2: CGPoint(x: 793.45, y: 127.13))
        shape.addCurve(to: CGPoint(x: 780.31, y: 115.36), controlPoint1: CGPoint(x: 787.64, y: 121.78), controlPoint2: CGPoint(x: 784.01, y: 118.54))
        shape.addCurve(to: CGPoint(x: 760.97, y: 99.58), controlPoint1: CGPoint(x: 774.01, y: 109.92), controlPoint2: CGPoint(x: 767.57, y: 104.66))
        shape.addCurve(to: CGPoint(x: 717.25, y: 69.82), controlPoint1: CGPoint(x: 746.98, y: 88.83), controlPoint2: CGPoint(x: 732.38, y: 78.9))
        shape.addCurve(to: CGPoint(x: 626.83, y: 27.48), controlPoint1: CGPoint(x: 688.66, y: 52.61), controlPoint2: CGPoint(x: 658.36, y: 38.42))
        shape.addCurve(to: CGPoint(x: 419.2, y: 1.84), controlPoint1: CGPoint(x: 560.16, y: 4.57), controlPoint2: CGPoint(x: 489.44, y: -4.17))
        shape.addCurve(to: CGPoint(x: 223.83, y: 59.89), controlPoint1: CGPoint(x: 351.02, y: 7.63), controlPoint2: CGPoint(x: 284.02, y: 27.16))
        shape.addCurve(to: CGPoint(x: 81.64, y: 181.41), controlPoint1: CGPoint(x: 168.51, y: 90.08), controlPoint2: CGPoint(x: 120.08, y: 131.47))
        shape.addCurve(to: CGPoint(x: 7.44, y: 344.13), controlPoint1: CGPoint(x: 44.84, y: 229.26), controlPoint2: CGPoint(x: 19.1, y: 284.86))
        shape.addCurve(to: CGPoint(x: 22.08, y: 548.93), controlPoint1: CGPoint(x: -6.13, y: 412.48), controlPoint2: CGPoint(x: -1.07, y: 483.21))
        shape.addCurve(to: CGPoint(x: 127.23, y: 709.19), controlPoint1: CGPoint(x: 43.68, y: 609.93), controlPoint2: CGPoint(x: 80.63, y: 664.53))
        shape.addCurve(to: CGPoint(x: 287.42, y: 808.53), controlPoint1: CGPoint(x: 173.02, y: 753.07), controlPoint2: CGPoint(x: 228.09, y: 786.38))
        shape.addCurve(to: CGPoint(x: 502.53, y: 838.02), controlPoint1: CGPoint(x: 355.77, y: 834.02), controlPoint2: CGPoint(x: 429.85, y: 843.64))
        shape.addCurve(to: CGPoint(x: 698.26, y: 780.78), controlPoint1: CGPoint(x: 571.04, y: 832.74), controlPoint2: CGPoint(x: 637.7, y: 813.25))
        shape.addCurve(to: CGPoint(x: 809.1, y: 697.14), controlPoint1: CGPoint(x: 739.27, y: 758.73), controlPoint2: CGPoint(x: 776.65, y: 730.52))
        shape.addCurve(to: CGPoint(x: 824.27, y: 680.72), controlPoint1: CGPoint(x: 814.26, y: 691.85), controlPoint2: CGPoint(x: 819.68, y: 686.53))
        shape.addCurve(to: CGPoint(x: 834.81, y: 659.35), controlPoint1: CGPoint(x: 829.28, y: 674.44), controlPoint2: CGPoint(x: 832.87, y: 667.15))
        shape.addCurve(to: CGPoint(x: 829.16, y: 557), controlPoint1: CGPoint(x: 843.13, y: 625.62), controlPoint2: CGPoint(x: 842.07, y: 589.35))
        shape.addCurve(to: CGPoint(x: 776.04, y: 480), controlPoint1: CGPoint(x: 817.57, y: 527.91), controlPoint2: CGPoint(x: 798.69, y: 501.54))
        shape.addCurve(to: CGPoint(x: 605.89, y: 412.35), controlPoint1: CGPoint(x: 730.54, y: 436.83), controlPoint2: CGPoint(x: 669.09, y: 409.85))
        shape.addCurve(to: CGPoint(x: 511.76, y: 438.17), controlPoint1: CGPoint(x: 572.89, y: 413.64), controlPoint2: CGPoint(x: 540.59, y: 422.01))
        shape.addCurve(to: CGPoint(x: 463.06, y: 509.71), controlPoint1: CGPoint(x: 485.76, y: 452.77), controlPoint2: CGPoint(x: 458.32, y: 476.7))
        shape.addCurve(to: CGPoint(x: 484.06, y: 557.55), controlPoint1: CGPoint(x: 465.59, y: 527.33), controlPoint2: CGPoint(x: 476.06, y: 542.12))
        shape.addCurve(to: CGPoint(x: 493.06, y: 608.93), controlPoint1: CGPoint(x: 492.46, y: 573.62), controlPoint2: CGPoint(x: 497.68, y: 590.84))
        shape.addCurve(to: CGPoint(x: 419.67, y: 684.03), controlPoint1: CGPoint(x: 484.11, y: 644.31), controlPoint2: CGPoint(x: 448.55, y: 666.08))
        shape.addCurve(to: CGPoint(x: 372.02, y: 709.46), controlPoint1: CGPoint(x: 404.45, y: 693.7), controlPoint2: CGPoint(x: 388.53, y: 702.2))
        shape.addCurve(to: CGPoint(x: 318.02, y: 723.46), controlPoint1: CGPoint(x: 354.91, y: 716.79), controlPoint2: CGPoint(x: 336.77, y: 722.79))
        shape.addCurve(to: CGPoint(x: 272.95, y: 706.29), controlPoint1: CGPoint(x: 301.09, y: 724.1), controlPoint2: CGPoint(x: 284.41, y: 719.32))
        shape.addCurve(to: CGPoint(x: 254.02, y: 660.02), controlPoint1: CGPoint(x: 261.9, y: 693.71), controlPoint2: CGPoint(x: 257.14, y: 676.1))
        shape.addCurve(to: CGPoint(x: 248.62, y: 601.71), controlPoint1: CGPoint(x: 250.35, y: 640.84), controlPoint2: CGPoint(x: 249.26, y: 621.19))
        shape.addCurve(to: CGPoint(x: 249.17, y: 544.41), controlPoint1: CGPoint(x: 247.85, y: 582.61), controlPoint2: CGPoint(x: 248.03, y: 563.49))
        shape.addCurve(to: CGPoint(x: 267.11, y: 430.19), controlPoint1: CGPoint(x: 251.78, y: 505.94), controlPoint2: CGPoint(x: 258.84, y: 467.81))
        shape.addCurve(to: CGPoint(x: 331.31, y: 210.13), controlPoint1: CGPoint(x: 283.53, y: 355.46), controlPoint2: CGPoint(x: 306.67, y: 282.49))
        shape.addCurve(to: CGPoint(x: 350.76, y: 160.69), controlPoint1: CGPoint(x: 336.95, y: 193.55), controlPoint2: CGPoint(x: 341.68, y: 175.79))
        shape.addCurve(to: CGPoint(x: 381.76, y: 128.99), controlPoint1: CGPoint(x: 358.58, y: 147.92), controlPoint2: CGPoint(x: 369.17, y: 137.09))
        shape.addCurve(to: CGPoint(x: 478.37, y: 99.28), controlPoint1: CGPoint(x: 410.13, y: 110.48), controlPoint2: CGPoint(x: 444.62, y: 100.35))
        shape.addCurve(to: CGPoint(x: 529.2, y: 107.28), controlPoint1: CGPoint(x: 495.77, y: 98.73), controlPoint2: CGPoint(x: 512.98, y: 100.66))
        shape.addCurve(to: CGPoint(x: 554.45, y: 120.06), controlPoint1: CGPoint(x: 537.93, y: 110.86), controlPoint2: CGPoint(x: 546.05, y: 115.8))
        shape.addCurve(to: CGPoint(x: 578.74, y: 130.74), controlPoint1: CGPoint(x: 562.3, y: 124.16), controlPoint2: CGPoint(x: 570.42, y: 127.73))
        shape.addCurve(to: CGPoint(x: 687.48, y: 143.99), controlPoint1: CGPoint(x: 613.74, y: 142.89), controlPoint2: CGPoint(x: 650.88, y: 143.74))
        shape.addCurve(to: CGPoint(x: 742.78, y: 142.57), controlPoint1: CGPoint(x: 705.93, y: 144.14), controlPoint2: CGPoint(x: 724.38, y: 144.1))
        shape.addCurve(to: CGPoint(x: 795.57, y: 133.73), controlPoint1: CGPoint(x: 760.69, y: 141.07), controlPoint2: CGPoint(x: 778.03, y: 137.5))
        shape.addCurve(to: CGPoint(x: 794.83, y: 130.82), controlPoint1: CGPoint(x: 797.51, y: 133.31), controlPoint2: CGPoint(x: 796.71, y: 130.41))
        shape.close()
        return shape
        
    }
    
    static var dPad : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 510.65, y: 256.07))
        shape.addLine(to: CGPoint(x: 510.65, y: 293.16))
        shape.addLine(to: CGPoint(x: 472.91, y: 293.16))
        shape.addLine(to: CGPoint(x: 472.91, y: 331.16))
        shape.addLine(to: CGPoint(x: 435.62, y: 331.16))
        shape.addLine(to: CGPoint(x: 435.62, y: 293.36))
        shape.addLine(to: CGPoint(x: 397.62, y: 293.36))
        shape.addLine(to: CGPoint(x: 397.62, y: 256.45))
        shape.addLine(to: CGPoint(x: 435.21, y: 256.45))
        shape.addCurve(to: CGPoint(x: 435.47, y: 237.45), controlPoint1: CGPoint(x: 435.75, y: 249.89), controlPoint2: CGPoint(x: 435.41, y: 243.67))
        shape.addCurve(to: CGPoint(x: 435.47, y: 218.28), controlPoint1: CGPoint(x: 435.53, y: 231.23), controlPoint2: CGPoint(x: 435.47, y: 224.89))
        shape.addLine(to: CGPoint(x: 472.62, y: 218.28))
        shape.addLine(to: CGPoint(x: 472.62, y: 256.04))
        shape.addLine(to: CGPoint(x: 510.65, y: 256.07))
        shape.close()
        
        return shape
        
    }
    
    static var roundButton1 : UIBezierPath {
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 779.15, y: 243.42))
        shape.addCurve(to: CGPoint(x: 762.15, y: 231.79), controlPoint1: CGPoint(x: 771.65, y: 243.35), controlPoint2: CGPoint(x: 764.94, y: 238.76))
        shape.addCurve(to: CGPoint(x: 766.41, y: 211.64), controlPoint1: CGPoint(x: 759.35, y: 224.83), controlPoint2: CGPoint(x: 761.04, y: 216.87))
        shape.addCurve(to: CGPoint(x: 786.67, y: 207.9), controlPoint1: CGPoint(x: 771.78, y: 206.4), controlPoint2: CGPoint(x: 779.78, y: 204.93))
        shape.addCurve(to: CGPoint(x: 797.85, y: 225.2), controlPoint1: CGPoint(x: 793.56, y: 210.87), controlPoint2: CGPoint(x: 797.97, y: 217.7))
        shape.addCurve(to: CGPoint(x: 779.15, y: 243.42), controlPoint1: CGPoint(x: 797.63, y: 235.36), controlPoint2: CGPoint(x: 789.31, y: 243.46))
        shape.addLine(to: CGPoint(x: 779.15, y: 243.42))
        shape.close()
        return shape
    }
    
    
    static var roundButton2 : UIBezierPath {
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 779.14, y: 337.24))
        shape.addCurve(to: CGPoint(x: 762.14, y: 325.61), controlPoint1: CGPoint(x: 771.64, y: 337.16), controlPoint2: CGPoint(x: 764.93, y: 332.57))
        shape.addCurve(to: CGPoint(x: 766.42, y: 305.45), controlPoint1: CGPoint(x: 759.35, y: 318.64), controlPoint2: CGPoint(x: 761.04, y: 310.69))
        shape.addCurve(to: CGPoint(x: 786.67, y: 301.72), controlPoint1: CGPoint(x: 771.79, y: 300.22), controlPoint2: CGPoint(x: 779.79, y: 298.75))
        shape.addCurve(to: CGPoint(x: 797.85, y: 319.02), controlPoint1: CGPoint(x: 793.56, y: 304.69), controlPoint2: CGPoint(x: 797.97, y: 311.52))
        shape.addCurve(to: CGPoint(x: 779.14, y: 337.24), controlPoint1: CGPoint(x: 797.62, y: 329.18), controlPoint2: CGPoint(x: 789.3, y: 337.28))
        shape.addLine(to: CGPoint(x: 779.14, y: 337.24))
        shape.close()
        return shape
    }
    
    
    static var roundButton3 : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 750.8, y: 271.85))
        shape.addCurve(to: CGPoint(x: 739.41, y: 288.95), controlPoint1: CGPoint(x: 750.82, y: 279.33), controlPoint2: CGPoint(x: 746.33, y: 286.09))
        shape.addCurve(to: CGPoint(x: 719.27, y: 284.93), controlPoint1: CGPoint(x: 732.5, y: 291.82), controlPoint2: CGPoint(x: 724.55, y: 290.23))
        shape.addCurve(to: CGPoint(x: 715.32, y: 264.76), controlPoint1: CGPoint(x: 713.99, y: 279.63), controlPoint2: CGPoint(x: 712.43, y: 271.67))
        shape.addCurve(to: CGPoint(x: 732.46, y: 253.44), controlPoint1: CGPoint(x: 718.21, y: 257.86), controlPoint2: CGPoint(x: 724.98, y: 253.39))
        shape.addCurve(to: CGPoint(x: 750.8, y: 271.85), controlPoint1: CGPoint(x: 742.59, y: 253.5), controlPoint2: CGPoint(x: 750.78, y: 261.72))
        shape.addLine(to: CGPoint(x: 750.8, y: 271.85))
        shape.close()
        return shape
        
        
    }
    
    static var roundButton4 : UIBezierPath {
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 807.76, y: 271.83))
        shape.addCurve(to: CGPoint(x: 817.12, y: 255.93), controlPoint1: CGPoint(x: 807.82, y: 265.24), controlPoint2: CGPoint(x: 811.38, y: 259.18))
        shape.addCurve(to: CGPoint(x: 835.57, y: 256.08), controlPoint1: CGPoint(x: 822.85, y: 252.68), controlPoint2: CGPoint(x: 829.89, y: 252.74))
        shape.addCurve(to: CGPoint(x: 844.66, y: 272.13), controlPoint1: CGPoint(x: 841.25, y: 259.42), controlPoint2: CGPoint(x: 844.72, y: 265.54))
        shape.addCurve(to: CGPoint(x: 826.06, y: 290.43), controlPoint1: CGPoint(x: 844.58, y: 282.32), controlPoint2: CGPoint(x: 836.25, y: 290.51))
        shape.addCurve(to: CGPoint(x: 807.76, y: 271.83), controlPoint1: CGPoint(x: 815.87, y: 290.35), controlPoint2: CGPoint(x: 807.68, y: 282.02))
        shape.close()
        return shape
    }
    
    
    
    static var gFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 94.49, y: 44.07))
        shape.addCurve(to: CGPoint(x: 89.17, y: 41.84), controlPoint1: CGPoint(x: 93.05, y: 42.59), controlPoint2: CGPoint(x: 91.28, y: 41.84))
        shape.addLine(to: CGPoint(x: 89.1, y: 41.84))
        shape.addLine(to: CGPoint(x: 46.24, y: 41.91))
        shape.addCurve(to: CGPoint(x: 40.92, y: 44.14), controlPoint1: CGPoint(x: 44.13, y: 41.96), controlPoint2: CGPoint(x: 42.36, y: 42.7))
        shape.addCurve(to: CGPoint(x: 38.7, y: 49.53), controlPoint1: CGPoint(x: 39.44, y: 45.62), controlPoint2: CGPoint(x: 38.7, y: 47.42))
        shape.addCurve(to: CGPoint(x: 40.92, y: 54.78), controlPoint1: CGPoint(x: 38.7, y: 51.59), controlPoint2: CGPoint(x: 39.44, y: 53.34))
        shape.addCurve(to: CGPoint(x: 46.24, y: 57.01), controlPoint1: CGPoint(x: 42.4, y: 56.26), controlPoint2: CGPoint(x: 44.18, y: 57.01))
        shape.addLine(to: CGPoint(x: 46.24, y: 57.01))
        shape.addLine(to: CGPoint(x: 80.47, y: 56.87))
        shape.addCurve(to: CGPoint(x: 63.49, y: 77.96), controlPoint1: CGPoint(x: 77.96, y: 66.44), controlPoint2: CGPoint(x: 72.3, y: 73.47))
        shape.addCurve(to: CGPoint(x: 38.16, y: 79.92), controlPoint1: CGPoint(x: 55.32, y: 82.09), controlPoint2: CGPoint(x: 46.87, y: 82.75))
        shape.addCurve(to: CGPoint(x: 18.82, y: 63.41), controlPoint1: CGPoint(x: 29.4, y: 77.09), controlPoint2: CGPoint(x: 22.95, y: 71.58))
        shape.addCurve(to: CGPoint(x: 16.86, y: 38.07), controlPoint1: CGPoint(x: 14.64, y: 55.28), controlPoint2: CGPoint(x: 13.99, y: 46.83))
        shape.addCurve(to: CGPoint(x: 33.37, y: 18.8), controlPoint1: CGPoint(x: 19.7, y: 29.36), controlPoint2: CGPoint(x: 25.2, y: 22.93))
        shape.addCurve(to: CGPoint(x: 50.62, y: 15.23), controlPoint1: CGPoint(x: 38.81, y: 16.01), controlPoint2: CGPoint(x: 44.56, y: 14.82))
        shape.addCurve(to: CGPoint(x: 67.33, y: 21.02), controlPoint1: CGPoint(x: 56.73, y: 15.63), controlPoint2: CGPoint(x: 62.3, y: 17.56))
        shape.addCurve(to: CGPoint(x: 72.93, y: 22.24), controlPoint1: CGPoint(x: 69.04, y: 22.24), controlPoint2: CGPoint(x: 70.91, y: 22.64))
        shape.addCurve(to: CGPoint(x: 77.78, y: 19.14), controlPoint1: CGPoint(x: 74.99, y: 21.88), controlPoint2: CGPoint(x: 76.61, y: 20.84))
        shape.addCurve(to: CGPoint(x: 78.99, y: 13.48), controlPoint1: CGPoint(x: 78.95, y: 17.43), controlPoint2: CGPoint(x: 79.35, y: 15.54))
        shape.addCurve(to: CGPoint(x: 75.89, y: 8.69), controlPoint1: CGPoint(x: 78.63, y: 11.46), controlPoint2: CGPoint(x: 77.6, y: 9.86))
        shape.addCurve(to: CGPoint(x: 51.63, y: 0.2), controlPoint1: CGPoint(x: 68.57, y: 3.62), controlPoint2: CGPoint(x: 60.48, y: 0.79))
        shape.addCurve(to: CGPoint(x: 26.5, y: 5.32), controlPoint1: CGPoint(x: 42.78, y: -0.38), controlPoint2: CGPoint(x: 34.41, y: 1.33))
        shape.addCurve(to: CGPoint(x: 2.51, y: 33.42), controlPoint1: CGPoint(x: 14.64, y: 11.39), controlPoint2: CGPoint(x: 6.65, y: 20.75))
        shape.addCurve(to: CGPoint(x: 5.41, y: 70.28), controlPoint1: CGPoint(x: -1.62, y: 46.13), controlPoint2: CGPoint(x: -0.65, y: 58.42))
        shape.addCurve(to: CGPoint(x: 23.54, y: 89.69), controlPoint1: CGPoint(x: 9.59, y: 78.5), controlPoint2: CGPoint(x: 15.63, y: 84.97))
        shape.addCurve(to: CGPoint(x: 48.47, y: 96.63), controlPoint1: CGPoint(x: 31.22, y: 94.31), controlPoint2: CGPoint(x: 39.53, y: 96.63))
        shape.addCurve(to: CGPoint(x: 70.3, y: 91.37), controlPoint1: CGPoint(x: 56.15, y: 96.63), controlPoint2: CGPoint(x: 63.43, y: 94.88))
        shape.addCurve(to: CGPoint(x: 89.23, y: 74.12), controlPoint1: CGPoint(x: 78.21, y: 87.37), controlPoint2: CGPoint(x: 84.52, y: 81.62))
        shape.addCurve(to: CGPoint(x: 96.65, y: 49.53), controlPoint1: CGPoint(x: 93.95, y: 66.62), controlPoint2: CGPoint(x: 96.42, y: 58.42))
        shape.addCurve(to: CGPoint(x: 94.49, y: 44.07), controlPoint1: CGPoint(x: 96.69, y: 47.42), controlPoint2: CGPoint(x: 95.97, y: 45.6))
        shape.close()
        return shape
    }
    
    static var aFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 199.74, y: 59.09))
        shape.addCurve(to: CGPoint(x: 199.67, y: 59.03), controlPoint1: CGPoint(x: 199.74, y: 59.05), controlPoint2: CGPoint(x: 199.72, y: 59.03))
        shape.addCurve(to: CGPoint(x: 199.67, y: 58.96), controlPoint1: CGPoint(x: 199.67, y: 59.03), controlPoint2: CGPoint(x: 199.67, y: 59))
        shape.addCurve(to: CGPoint(x: 199.47, y: 58.56), controlPoint1: CGPoint(x: 199.63, y: 58.87), controlPoint2: CGPoint(x: 199.56, y: 58.74))
        shape.addCurve(to: CGPoint(x: 199.27, y: 58.29), controlPoint1: CGPoint(x: 199.38, y: 58.47), controlPoint2: CGPoint(x: 199.32, y: 58.38))
        shape.addCurve(to: CGPoint(x: 199.07, y: 58.02), controlPoint1: CGPoint(x: 199.23, y: 58.24), controlPoint2: CGPoint(x: 199.16, y: 58.15))
        shape.addCurve(to: CGPoint(x: 198.87, y: 57.68), controlPoint1: CGPoint(x: 198.98, y: 57.88), controlPoint2: CGPoint(x: 198.91, y: 57.77))
        shape.addCurve(to: CGPoint(x: 198.66, y: 57.48), controlPoint1: CGPoint(x: 198.82, y: 57.68), controlPoint2: CGPoint(x: 198.75, y: 57.61))
        shape.addCurve(to: CGPoint(x: 198.33, y: 57.14), controlPoint1: CGPoint(x: 198.53, y: 57.3), controlPoint2: CGPoint(x: 198.42, y: 57.19))
        shape.addLine(to: CGPoint(x: 198.12, y: 56.94))
        shape.addCurve(to: CGPoint(x: 197.79, y: 56.67), controlPoint1: CGPoint(x: 197.99, y: 56.8), controlPoint2: CGPoint(x: 197.88, y: 56.71))
        shape.addLine(to: CGPoint(x: 197.59, y: 56.47))
        shape.addCurve(to: CGPoint(x: 197.25, y: 56.2), controlPoint1: CGPoint(x: 197.41, y: 56.33), controlPoint2: CGPoint(x: 197.29, y: 56.24))
        shape.addCurve(to: CGPoint(x: 196.91, y: 56), controlPoint1: CGPoint(x: 197.2, y: 56.2), controlPoint2: CGPoint(x: 197.09, y: 56.13))
        shape.addCurve(to: CGPoint(x: 196.64, y: 55.86), controlPoint1: CGPoint(x: 196.78, y: 55.91), controlPoint2: CGPoint(x: 196.69, y: 55.86))
        shape.addCurve(to: CGPoint(x: 196.24, y: 55.66), controlPoint1: CGPoint(x: 196.6, y: 55.82), controlPoint2: CGPoint(x: 196.46, y: 55.75))
        shape.addCurve(to: CGPoint(x: 196.04, y: 55.52), controlPoint1: CGPoint(x: 196.06, y: 55.57), controlPoint2: CGPoint(x: 195.99, y: 55.52))
        shape.addCurve(to: CGPoint(x: 195.56, y: 55.32), controlPoint1: CGPoint(x: 195.9, y: 55.48), controlPoint2: CGPoint(x: 195.74, y: 55.41))
        shape.addCurve(to: CGPoint(x: 195.36, y: 55.25), controlPoint1: CGPoint(x: 195.29, y: 55.23), controlPoint2: CGPoint(x: 195.23, y: 55.21))
        shape.addCurve(to: CGPoint(x: 194.89, y: 55.12), controlPoint1: CGPoint(x: 195.23, y: 55.21), controlPoint2: CGPoint(x: 195.07, y: 55.16))
        shape.addCurve(to: CGPoint(x: 194.62, y: 55.05), controlPoint1: CGPoint(x: 194.71, y: 55.07), controlPoint2: CGPoint(x: 194.62, y: 55.05))
        shape.addCurve(to: CGPoint(x: 194.22, y: 54.98), controlPoint1: CGPoint(x: 194.53, y: 55.05), controlPoint2: CGPoint(x: 194.4, y: 55.03))
        shape.addCurve(to: CGPoint(x: 193.88, y: 54.92), controlPoint1: CGPoint(x: 194.04, y: 54.98), controlPoint2: CGPoint(x: 193.92, y: 54.96))
        shape.addCurve(to: CGPoint(x: 193.54, y: 54.92), controlPoint1: CGPoint(x: 193.79, y: 54.92), controlPoint2: CGPoint(x: 193.68, y: 54.92))
        shape.addCurve(to: CGPoint(x: 193.07, y: 54.92), controlPoint1: CGPoint(x: 193.36, y: 54.92), controlPoint2: CGPoint(x: 193.21, y: 54.92))
        shape.addLine(to: CGPoint(x: 193, y: 54.92))
        shape.addCurve(to: CGPoint(x: 145.09, y: 66.1), controlPoint1: CGPoint(x: 176.07, y: 54.92), controlPoint2: CGPoint(x: 160.1, y: 58.65))
        shape.addLine(to: CGPoint(x: 165.78, y: 24.53))
        shape.addLine(to: CGPoint(x: 175.21, y: 43.66))
        shape.addCurve(to: CGPoint(x: 179.59, y: 47.44), controlPoint1: CGPoint(x: 176.16, y: 45.51), controlPoint2: CGPoint(x: 177.62, y: 46.76))
        shape.addCurve(to: CGPoint(x: 185.32, y: 47.03), controlPoint1: CGPoint(x: 181.57, y: 48.11), controlPoint2: CGPoint(x: 183.48, y: 47.98))
        shape.addCurve(to: CGPoint(x: 189.1, y: 42.65), controlPoint1: CGPoint(x: 187.21, y: 46.09), controlPoint2: CGPoint(x: 188.47, y: 44.63))
        shape.addCurve(to: CGPoint(x: 188.76, y: 36.93), controlPoint1: CGPoint(x: 189.77, y: 40.72), controlPoint2: CGPoint(x: 189.66, y: 38.81))
        shape.addLine(to: CGPoint(x: 172.52, y: 4.25))
        shape.addCurve(to: CGPoint(x: 165.78, y: 0.07), controlPoint1: CGPoint(x: 171.13, y: 1.46), controlPoint2: CGPoint(x: 168.88, y: 0.07))
        shape.addCurve(to: CGPoint(x: 159.04, y: 4.25), controlPoint1: CGPoint(x: 162.64, y: 0.07), controlPoint2: CGPoint(x: 160.39, y: 1.46))
        shape.addLine(to: CGPoint(x: 118.55, y: 85.78))
        shape.addCurve(to: CGPoint(x: 118.01, y: 90.97), controlPoint1: CGPoint(x: 117.69, y: 87.44), controlPoint2: CGPoint(x: 117.51, y: 89.17))
        shape.addCurve(to: CGPoint(x: 120.97, y: 95.28), controlPoint1: CGPoint(x: 118.46, y: 92.76), controlPoint2: CGPoint(x: 119.44, y: 94.2))
        shape.addCurve(to: CGPoint(x: 125.28, y: 96.63), controlPoint1: CGPoint(x: 122.27, y: 96.18), controlPoint2: CGPoint(x: 123.71, y: 96.63))
        shape.addCurve(to: CGPoint(x: 130.81, y: 94.2), controlPoint1: CGPoint(x: 127.49, y: 96.63), controlPoint2: CGPoint(x: 129.33, y: 95.82))
        shape.addCurve(to: CGPoint(x: 146.04, y: 82.75), controlPoint1: CGPoint(x: 134.27, y: 90.47), controlPoint2: CGPoint(x: 139.34, y: 86.65))
        shape.addCurve(to: CGPoint(x: 188.35, y: 70.08), controlPoint1: CGPoint(x: 159.11, y: 75.02), controlPoint2: CGPoint(x: 173.22, y: 70.8))
        shape.addLine(to: CGPoint(x: 199.47, y: 92.45))
        shape.addCurve(to: CGPoint(x: 206.21, y: 96.63), controlPoint1: CGPoint(x: 200.86, y: 95.23), controlPoint2: CGPoint(x: 203.11, y: 96.63))
        shape.addCurve(to: CGPoint(x: 209.58, y: 95.82), controlPoint1: CGPoint(x: 207.38, y: 96.63), controlPoint2: CGPoint(x: 208.5, y: 96.36))
        shape.addCurve(to: CGPoint(x: 213.35, y: 91.51), controlPoint1: CGPoint(x: 211.42, y: 94.92), controlPoint2: CGPoint(x: 212.68, y: 93.48))
        shape.addCurve(to: CGPoint(x: 212.95, y: 85.78), controlPoint1: CGPoint(x: 214.03, y: 89.53), controlPoint2: CGPoint(x: 213.89, y: 87.62))
        shape.addLine(to: CGPoint(x: 199.74, y: 59.09))
        shape.close()
        return shape
        
    }
    
    static var mFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 324.33, y: 96.63))
        shape.addCurve(to: CGPoint(x: 319.01, y: 94.4), controlPoint1: CGPoint(x: 322.27, y: 96.63), controlPoint2: CGPoint(x: 320.49, y: 95.89))
        shape.addCurve(to: CGPoint(x: 316.79, y: 89.08), controlPoint1: CGPoint(x: 317.53, y: 92.97), controlPoint2: CGPoint(x: 316.79, y: 91.19))
        shape.addLine(to: CGPoint(x: 316.79, y: 7.68))
        shape.addCurve(to: CGPoint(x: 319.01, y: 2.36), controlPoint1: CGPoint(x: 316.79, y: 5.62), controlPoint2: CGPoint(x: 317.53, y: 3.84))
        shape.addCurve(to: CGPoint(x: 324.33, y: 0.13), controlPoint1: CGPoint(x: 320.49, y: 0.88), controlPoint2: CGPoint(x: 322.27, y: 0.13))
        shape.addCurve(to: CGPoint(x: 329.66, y: 2.36), controlPoint1: CGPoint(x: 326.4, y: 0.13), controlPoint2: CGPoint(x: 328.17, y: 0.88))
        shape.addCurve(to: CGPoint(x: 331.88, y: 7.68), controlPoint1: CGPoint(x: 331.14, y: 3.84), controlPoint2: CGPoint(x: 331.88, y: 5.62))
        shape.addLine(to: CGPoint(x: 331.88, y: 89.08))
        shape.addCurve(to: CGPoint(x: 329.66, y: 94.4), controlPoint1: CGPoint(x: 331.88, y: 91.19), controlPoint2: CGPoint(x: 331.14, y: 92.97))
        shape.addCurve(to: CGPoint(x: 324.33, y: 96.63), controlPoint1: CGPoint(x: 328.17, y: 95.89), controlPoint2: CGPoint(x: 326.4, y: 96.63))
        shape.close()
        shape.move(to: CGPoint(x: 243.07, y: 96.63))
        shape.addCurve(to: CGPoint(x: 237.75, y: 94.4), controlPoint1: CGPoint(x: 240.96, y: 96.63), controlPoint2: CGPoint(x: 239.18, y: 95.89))
        shape.addCurve(to: CGPoint(x: 235.52, y: 89.08), controlPoint1: CGPoint(x: 236.26, y: 92.97), controlPoint2: CGPoint(x: 235.52, y: 91.19))
        shape.addLine(to: CGPoint(x: 235.52, y: 7.68))
        shape.addCurve(to: CGPoint(x: 236.87, y: 3.37), controlPoint1: CGPoint(x: 235.52, y: 6.11), controlPoint2: CGPoint(x: 235.97, y: 4.67))
        shape.addCurve(to: CGPoint(x: 240.51, y: 0.61), controlPoint1: CGPoint(x: 237.81, y: 2.07), controlPoint2: CGPoint(x: 239.03, y: 1.15))
        shape.addCurve(to: CGPoint(x: 245.02, y: 0.4), controlPoint1: CGPoint(x: 241.99, y: 0.07), controlPoint2: CGPoint(x: 243.5, y: 0))
        shape.addCurve(to: CGPoint(x: 248.86, y: 2.9), controlPoint1: CGPoint(x: 246.55, y: 0.85), controlPoint2: CGPoint(x: 247.83, y: 1.68))
        shape.addLine(to: CGPoint(x: 284.31, y: 45.48))
        shape.addLine(to: CGPoint(x: 294.55, y: 35.44))
        shape.addCurve(to: CGPoint(x: 299.94, y: 33.35), controlPoint1: CGPoint(x: 296.08, y: 34.01), controlPoint2: CGPoint(x: 297.87, y: 33.31))
        shape.addCurve(to: CGPoint(x: 305.2, y: 35.65), controlPoint1: CGPoint(x: 302.01, y: 33.4), controlPoint2: CGPoint(x: 303.76, y: 34.16))
        shape.addCurve(to: CGPoint(x: 307.35, y: 40.97), controlPoint1: CGPoint(x: 306.68, y: 37.13), controlPoint2: CGPoint(x: 307.4, y: 38.9))
        shape.addCurve(to: CGPoint(x: 305.06, y: 46.29), controlPoint1: CGPoint(x: 307.31, y: 43.08), controlPoint2: CGPoint(x: 306.54, y: 44.85))
        shape.addLine(to: CGPoint(x: 288.96, y: 61.92))
        shape.addCurve(to: CGPoint(x: 283.3, y: 64.08), controlPoint1: CGPoint(x: 287.38, y: 63.45), controlPoint2: CGPoint(x: 285.5, y: 64.17))
        shape.addCurve(to: CGPoint(x: 277.91, y: 61.32), controlPoint1: CGPoint(x: 281.1, y: 63.95), controlPoint2: CGPoint(x: 279.3, y: 63.03))
        shape.addLine(to: CGPoint(x: 250.55, y: 28.5))
        shape.addLine(to: CGPoint(x: 250.55, y: 89.08))
        shape.addCurve(to: CGPoint(x: 248.39, y: 94.4), controlPoint1: CGPoint(x: 250.55, y: 91.19), controlPoint2: CGPoint(x: 249.83, y: 92.97))
        shape.addCurve(to: CGPoint(x: 243.07, y: 96.63), controlPoint1: CGPoint(x: 246.91, y: 95.89), controlPoint2: CGPoint(x: 245.14, y: 96.63))
        shape.close()
        return shape
        
    }
    
    static var eFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 381.27, y: 81.53))
        shape.addCurve(to: CGPoint(x: 372.17, y: 77.76), controlPoint1: CGPoint(x: 377.72, y: 81.53), controlPoint2: CGPoint(x: 374.69, y: 80.28))
        shape.addCurve(to: CGPoint(x: 368.4, y: 68.66), controlPoint1: CGPoint(x: 369.66, y: 75.24), controlPoint2: CGPoint(x: 368.4, y: 72.21))
        shape.addLine(to: CGPoint(x: 368.4, y: 55.86))
        shape.addLine(to: CGPoint(x: 422.71, y: 55.86))
        shape.addCurve(to: CGPoint(x: 428.03, y: 53.7), controlPoint1: CGPoint(x: 424.82, y: 55.86), controlPoint2: CGPoint(x: 426.6, y: 55.14))
        shape.addCurve(to: CGPoint(x: 430.26, y: 48.38), controlPoint1: CGPoint(x: 429.52, y: 52.22), controlPoint2: CGPoint(x: 430.26, y: 50.45))
        shape.addCurve(to: CGPoint(x: 428.03, y: 43.06), controlPoint1: CGPoint(x: 430.26, y: 46.27), controlPoint2: CGPoint(x: 429.52, y: 44.5))
        shape.addCurve(to: CGPoint(x: 422.71, y: 40.83), controlPoint1: CGPoint(x: 426.6, y: 41.58), controlPoint2: CGPoint(x: 424.82, y: 40.83))
        shape.addLine(to: CGPoint(x: 360.85, y: 40.83))
        shape.addCurve(to: CGPoint(x: 355.53, y: 43.06), controlPoint1: CGPoint(x: 358.74, y: 40.83), controlPoint2: CGPoint(x: 356.97, y: 41.58))
        shape.addCurve(to: CGPoint(x: 353.31, y: 48.38), controlPoint1: CGPoint(x: 354.05, y: 44.5), controlPoint2: CGPoint(x: 353.31, y: 46.27))
        shape.addLine(to: CGPoint(x: 353.31, y: 68.66))
        shape.addCurve(to: CGPoint(x: 361.53, y: 88.41), controlPoint1: CGPoint(x: 353.31, y: 76.39), controlPoint2: CGPoint(x: 356.05, y: 82.97))
        shape.addCurve(to: CGPoint(x: 381.27, y: 96.63), controlPoint1: CGPoint(x: 366.96, y: 93.89), controlPoint2: CGPoint(x: 373.54, y: 96.63))
        shape.addLine(to: CGPoint(x: 442.19, y: 96.63))
        shape.addCurve(to: CGPoint(x: 447.51, y: 94.4), controlPoint1: CGPoint(x: 444.25, y: 96.63), controlPoint2: CGPoint(x: 446.03, y: 95.89))
        shape.addCurve(to: CGPoint(x: 449.66, y: 89.08), controlPoint1: CGPoint(x: 448.95, y: 92.97), controlPoint2: CGPoint(x: 449.66, y: 91.19))
        shape.addCurve(to: CGPoint(x: 447.51, y: 83.76), controlPoint1: CGPoint(x: 449.66, y: 87.01), controlPoint2: CGPoint(x: 448.95, y: 85.24))
        shape.addCurve(to: CGPoint(x: 442.19, y: 81.53), controlPoint1: CGPoint(x: 446.03, y: 82.27), controlPoint2: CGPoint(x: 444.25, y: 81.53))
        shape.addLine(to: CGPoint(x: 381.27, y: 81.53))
        shape.close()
        shape.move(to: CGPoint(x: 442.19, y: 15.16))
        shape.addCurve(to: CGPoint(x: 447.51, y: 12.94), controlPoint1: CGPoint(x: 444.25, y: 15.16), controlPoint2: CGPoint(x: 446.03, y: 14.42))
        shape.addCurve(to: CGPoint(x: 449.66, y: 7.61), controlPoint1: CGPoint(x: 448.95, y: 11.46), controlPoint2: CGPoint(x: 449.66, y: 9.68))
        shape.addCurve(to: CGPoint(x: 447.51, y: 2.29), controlPoint1: CGPoint(x: 449.66, y: 5.55), controlPoint2: CGPoint(x: 448.95, y: 3.77))
        shape.addCurve(to: CGPoint(x: 442.19, y: 0.07), controlPoint1: CGPoint(x: 446.03, y: 0.81), controlPoint2: CGPoint(x: 444.25, y: 0.07))
        shape.addLine(to: CGPoint(x: 360.85, y: 0.07))
        shape.addCurve(to: CGPoint(x: 355.53, y: 2.29), controlPoint1: CGPoint(x: 358.74, y: 0.07), controlPoint2: CGPoint(x: 356.97, y: 0.81))
        shape.addCurve(to: CGPoint(x: 353.31, y: 7.61), controlPoint1: CGPoint(x: 354.05, y: 3.77), controlPoint2: CGPoint(x: 353.31, y: 5.55))
        shape.addCurve(to: CGPoint(x: 355.53, y: 12.94), controlPoint1: CGPoint(x: 353.31, y: 9.68), controlPoint2: CGPoint(x: 354.05, y: 11.46))
        shape.addCurve(to: CGPoint(x: 360.85, y: 15.16), controlPoint1: CGPoint(x: 356.97, y: 14.42), controlPoint2: CGPoint(x: 358.74, y: 15.16))
        shape.addLine(to: CGPoint(x: 442.19, y: 15.16))
        shape.close()
        return shape
        
    }
    
    static var oFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 519.34, y: 15.16))
        shape.addCurve(to: CGPoint(x: 495.89, y: 24.86), controlPoint1: CGPoint(x: 510.22, y: 15.16), controlPoint2: CGPoint(x: 502.4, y: 18.4))
        shape.addCurve(to: CGPoint(x: 486.19, y: 48.38), controlPoint1: CGPoint(x: 489.42, y: 31.38), controlPoint2: CGPoint(x: 486.19, y: 39.22))
        shape.addCurve(to: CGPoint(x: 495.89, y: 71.83), controlPoint1: CGPoint(x: 486.19, y: 57.5), controlPoint2: CGPoint(x: 489.42, y: 65.32))
        shape.addCurve(to: CGPoint(x: 519.34, y: 81.53), controlPoint1: CGPoint(x: 502.4, y: 78.3), controlPoint2: CGPoint(x: 510.22, y: 81.53))
        shape.addCurve(to: CGPoint(x: 542.86, y: 71.83), controlPoint1: CGPoint(x: 528.5, y: 81.53), controlPoint2: CGPoint(x: 536.34, y: 78.3))
        
        shape.addCurve(to: CGPoint(x: 552.56, y: 48.38), controlPoint1: CGPoint(x: 549.32, y: 65.32), controlPoint2: CGPoint(x: 552.56, y: 57.5))
        shape.addCurve(to: CGPoint(x: 542.86, y: 24.86), controlPoint1: CGPoint(x: 552.56, y: 39.22), controlPoint2: CGPoint(x: 549.32, y: 31.38))
        shape.addCurve(to: CGPoint(x: 519.34, y: 15.16), controlPoint1: CGPoint(x: 536.34, y: 18.4), controlPoint2: CGPoint(x: 528.5, y: 15.16))
        shape.close()
        shape.move(to: CGPoint(x: 519.34, y: 96.63))
        shape.addCurve(to: CGPoint(x: 485.24, y: 82.48), controlPoint1: CGPoint(x: 506.04, y: 96.63), controlPoint2: CGPoint(x: 494.68, y: 91.91))
        shape.addCurve(to: CGPoint(x: 471.09, y: 48.38), controlPoint1: CGPoint(x: 475.81, y: 73.04), controlPoint2: CGPoint(x: 471.09, y: 61.68))
        shape.addCurve(to: CGPoint(x: 485.24, y: 14.22), controlPoint1: CGPoint(x: 471.09, y: 35.04), controlPoint2: CGPoint(x: 475.81, y: 23.65))
        shape.addCurve(to: CGPoint(x: 519.34, y: 0.07), controlPoint1: CGPoint(x: 494.68, y: 4.78), controlPoint2: CGPoint(x: 506.04, y: 0.07))
        shape.addCurve(to: CGPoint(x: 553.5, y: 14.22), controlPoint1: CGPoint(x: 532.68, y: 0.07), controlPoint2: CGPoint(x: 544.07, y: 4.78))
        shape.addCurve(to: CGPoint(x: 567.65, y: 48.38), controlPoint1: CGPoint(x: 562.94, y: 23.65), controlPoint2: CGPoint(x: 567.65, y: 35.04))
        shape.addCurve(to: CGPoint(x: 553.5, y: 82.48), controlPoint1: CGPoint(x: 567.65, y: 61.68), controlPoint2: CGPoint(x: 562.94, y: 73.04))
        shape.addCurve(to: CGPoint(x: 519.34, y: 96.63), controlPoint1: CGPoint(x: 544.07, y: 91.91), controlPoint2: CGPoint(x: 532.68, y: 96.63))
        shape.close()
        return shape
        
    }
    
    static var lFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 616.84, y: 96.63))
        shape.addCurve(to: CGPoint(x: 597.03, y: 88.41), controlPoint1: CGPoint(x: 609.11, y: 96.63), controlPoint2: CGPoint(x: 602.51, y: 93.89))
        shape.addCurve(to: CGPoint(x: 588.88, y: 68.66), controlPoint1: CGPoint(x: 591.6, y: 82.97), controlPoint2: CGPoint(x: 588.88, y: 76.39))
        shape.addLine(to: CGPoint(x: 588.95, y: 7.75))
        shape.addCurve(to: CGPoint(x: 591.17, y: 2.43), controlPoint1: CGPoint(x: 588.95, y: 5.64), controlPoint2: CGPoint(x: 589.69, y: 3.86))
        shape.addCurve(to: CGPoint(x: 596.49, y: 0.2), controlPoint1: CGPoint(x: 592.61, y: 0.94), controlPoint2: CGPoint(x: 594.38, y: 0.2))
        shape.addLine(to: CGPoint(x: 596.49, y: 0.2))
        shape.addCurve(to: CGPoint(x: 601.82, y: 2.43), controlPoint1: CGPoint(x: 598.56, y: 0.2), controlPoint2: CGPoint(x: 600.33, y: 0.94))
        shape.addCurve(to: CGPoint(x: 603.97, y: 7.75), controlPoint1: CGPoint(x: 603.25, y: 3.91), controlPoint2: CGPoint(x: 603.97, y: 5.68))
        shape.addLine(to: CGPoint(x: 603.9, y: 68.66))
        shape.addCurve(to: CGPoint(x: 607.68, y: 77.83), controlPoint1: CGPoint(x: 603.9, y: 72.21), controlPoint2: CGPoint(x: 605.16, y: 75.27))
        shape.addCurve(to: CGPoint(x: 616.84, y: 81.6), controlPoint1: CGPoint(x: 610.19, y: 80.34), controlPoint2: CGPoint(x: 613.25, y: 81.6))
        shape.addLine(to: CGPoint(x: 677.69, y: 81.6))
        shape.addCurve(to: CGPoint(x: 683.01, y: 83.76), controlPoint1: CGPoint(x: 679.8, y: 81.6), controlPoint2: CGPoint(x: 681.57, y: 82.32))
        shape.addCurve(to: CGPoint(x: 685.24, y: 89.08), controlPoint1: CGPoint(x: 684.49, y: 85.24), controlPoint2: CGPoint(x: 685.24, y: 87.01))
        shape.addCurve(to: CGPoint(x: 683.01, y: 94.4), controlPoint1: CGPoint(x: 685.24, y: 91.19), controlPoint2: CGPoint(x: 684.49, y: 92.97))
        shape.addCurve(to: CGPoint(x: 677.69, y: 96.63), controlPoint1: CGPoint(x: 681.57, y: 95.89), controlPoint2: CGPoint(x: 679.8, y: 96.63))
        shape.addLine(to: CGPoint(x: 616.84, y: 96.63))
        shape.close()
        return shape
        
    }
    
    static var oFont2 : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 754.91, y: 15.16))
        shape.addCurve(to: CGPoint(x: 731.46, y: 24.86), controlPoint1: CGPoint(x: 745.79, y: 15.16), controlPoint2: CGPoint(x: 737.97, y: 18.4))
        shape.addCurve(to: CGPoint(x: 721.76, y: 48.38), controlPoint1: CGPoint(x: 724.99, y: 31.38), controlPoint2: CGPoint(x: 721.76, y: 39.22))
        shape.addCurve(to: CGPoint(x: 731.46, y: 71.83), controlPoint1: CGPoint(x: 721.76, y: 57.5), controlPoint2: CGPoint(x: 724.99, y: 65.32))
        shape.addCurve(to: CGPoint(x: 754.91, y: 81.53), controlPoint1: CGPoint(x: 737.97, y: 78.3), controlPoint2: CGPoint(x: 745.79, y: 81.53))
        shape.addCurve(to: CGPoint(x: 778.43, y: 71.83), controlPoint1: CGPoint(x: 764.07, y: 81.53), controlPoint2: CGPoint(x: 771.91, y: 78.3))
        shape.addCurve(to: CGPoint(x: 788.13, y: 48.38), controlPoint1: CGPoint(x: 784.89, y: 65.32), controlPoint2: CGPoint(x: 788.13, y: 57.5))
        shape.addCurve(to: CGPoint(x: 778.43, y: 24.86), controlPoint1: CGPoint(x: 788.13, y: 39.22), controlPoint2: CGPoint(x: 784.89, y: 31.38))
        shape.addCurve(to: CGPoint(x: 754.91, y: 15.16), controlPoint1: CGPoint(x: 771.91, y: 18.4), controlPoint2: CGPoint(x: 764.07, y: 15.16))
        shape.close()
        shape.move(to: CGPoint(x: 754.91, y: 96.63))
        shape.addCurve(to: CGPoint(x: 720.81, y: 82.48), controlPoint1: CGPoint(x: 741.61, y: 96.63), controlPoint2: CGPoint(x: 730.25, y: 91.91))
        shape.addCurve(to: CGPoint(x: 706.66, y: 48.38), controlPoint1: CGPoint(x: 711.38, y: 73.04), controlPoint2: CGPoint(x: 706.66, y: 61.68))
        shape.addCurve(to: CGPoint(x: 720.81, y: 14.22), controlPoint1: CGPoint(x: 706.66, y: 35.04), controlPoint2: CGPoint(x: 711.38, y: 23.65))
        shape.addCurve(to: CGPoint(x: 754.91, y: 0.07), controlPoint1: CGPoint(x: 730.25, y: 4.78), controlPoint2: CGPoint(x: 741.61, y: 0.07))
        shape.addCurve(to: CGPoint(x: 789.07, y: 14.22), controlPoint1: CGPoint(x: 768.25, y: 0.07), controlPoint2: CGPoint(x: 779.64, y: 4.78))
        shape.addCurve(to: CGPoint(x: 803.22, y: 48.38), controlPoint1: CGPoint(x: 798.51, y: 23.65), controlPoint2: CGPoint(x: 803.22, y: 35.04))
        shape.addCurve(to: CGPoint(x: 789.07, y: 82.48), controlPoint1: CGPoint(x: 803.22, y: 61.68), controlPoint2: CGPoint(x: 798.51, y: 73.04))
        shape.addCurve(to: CGPoint(x: 754.91, y: 96.63), controlPoint1: CGPoint(x: 779.64, y: 91.91), controlPoint2: CGPoint(x: 768.25, y: 96.63))
        shape.close()
        return shape
        
    }
    
    static var gFont2 : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 918.99, y: 44.07))
        shape.addCurve(to: CGPoint(x: 913.66, y: 41.84), controlPoint1: CGPoint(x: 917.55, y: 42.59), controlPoint2: CGPoint(x: 915.77, y: 41.84))
        shape.addLine(to: CGPoint(x: 913.6, y: 41.84))
        shape.addLine(to: CGPoint(x: 870.74, y: 41.91))
        shape.addCurve(to: CGPoint(x: 865.42, y: 44.14), controlPoint1: CGPoint(x: 868.63, y: 41.96), controlPoint2: CGPoint(x: 866.85, y: 42.7))
        shape.addCurve(to: CGPoint(x: 863.19, y: 49.53), controlPoint1: CGPoint(x: 863.93, y: 45.62), controlPoint2: CGPoint(x: 863.19, y: 47.42))
        shape.addCurve(to: CGPoint(x: 865.42, y: 54.78), controlPoint1: CGPoint(x: 863.19, y: 51.59), controlPoint2: CGPoint(x: 863.93, y: 53.34))
        shape.addCurve(to: CGPoint(x: 870.74, y: 57.01), controlPoint1: CGPoint(x: 866.9, y: 56.26), controlPoint2: CGPoint(x: 868.67, y: 57.01))
        shape.addLine(to: CGPoint(x: 870.74, y: 57.01))
        shape.addLine(to: CGPoint(x: 904.97, y: 56.87))
        shape.addCurve(to: CGPoint(x: 887.99, y: 77.96), controlPoint1: CGPoint(x: 902.45, y: 66.44), controlPoint2: CGPoint(x: 896.79, y: 73.47))
        shape.addCurve(to: CGPoint(x: 862.65, y: 79.92), controlPoint1: CGPoint(x: 879.81, y: 82.09), controlPoint2: CGPoint(x: 871.37, y: 82.75))
        shape.addCurve(to: CGPoint(x: 843.32, y: 63.41), controlPoint1: CGPoint(x: 853.89, y: 77.09), controlPoint2: CGPoint(x: 847.45, y: 71.58))
        shape.addCurve(to: CGPoint(x: 841.36, y: 38.07), controlPoint1: CGPoint(x: 839.14, y: 55.28), controlPoint2: CGPoint(x: 838.49, y: 46.83))
        shape.addCurve(to: CGPoint(x: 857.87, y: 18.8), controlPoint1: CGPoint(x: 844.19, y: 29.36), controlPoint2: CGPoint(x: 849.69, y: 22.93))
        shape.addCurve(to: CGPoint(x: 875.12, y: 15.23), controlPoint1: CGPoint(x: 863.31, y: 16.01), controlPoint2: CGPoint(x: 869.06, y: 14.82))
        shape.addCurve(to: CGPoint(x: 891.83, y: 21.02), controlPoint1: CGPoint(x: 881.23, y: 15.63), controlPoint2: CGPoint(x: 886.8, y: 17.56))
        shape.addCurve(to: CGPoint(x: 897.42, y: 22.24), controlPoint1: CGPoint(x: 893.54, y: 22.24), controlPoint2: CGPoint(x: 895.4, y: 22.64))
        shape.addCurve(to: CGPoint(x: 902.28, y: 19.14), controlPoint1: CGPoint(x: 899.49, y: 21.88), controlPoint2: CGPoint(x: 901.11, y: 20.84))
        shape.addCurve(to: CGPoint(x: 903.49, y: 13.48), controlPoint1: CGPoint(x: 903.44, y: 17.43), controlPoint2: CGPoint(x: 903.85, y: 15.54))
        shape.addCurve(to: CGPoint(x: 900.39, y: 8.69), controlPoint1: CGPoint(x: 903.13, y: 11.46), controlPoint2: CGPoint(x: 902.1, y: 9.86))
        shape.addCurve(to: CGPoint(x: 876.13, y: 0.2), controlPoint1: CGPoint(x: 893.07, y: 3.62), controlPoint2: CGPoint(x: 884.98, y: 0.79))
        shape.addCurve(to: CGPoint(x: 851, y: 5.32), controlPoint1: CGPoint(x: 867.28, y: -0.38), controlPoint2: CGPoint(x: 858.9, y: 1.33))
        shape.addCurve(to: CGPoint(x: 827.01, y: 33.42), controlPoint1: CGPoint(x: 839.14, y: 11.39), controlPoint2: CGPoint(x: 831.14, y: 20.75))
        shape.addCurve(to: CGPoint(x: 829.91, y: 70.28), controlPoint1: CGPoint(x: 822.88, y: 46.13), controlPoint2: CGPoint(x: 823.84, y: 58.42))
        shape.addCurve(to: CGPoint(x: 848.03, y: 89.69), controlPoint1: CGPoint(x: 834.08, y: 78.5), controlPoint2: CGPoint(x: 840.13, y: 84.97))
        shape.addCurve(to: CGPoint(x: 872.96, y: 96.63), controlPoint1: CGPoint(x: 855.71, y: 94.31), controlPoint2: CGPoint(x: 864.02, y: 96.63))
        shape.addCurve(to: CGPoint(x: 894.8, y: 91.37), controlPoint1: CGPoint(x: 880.65, y: 96.63), controlPoint2: CGPoint(x: 887.92, y: 94.88))
        shape.addCurve(to: CGPoint(x: 913.73, y: 74.12), controlPoint1: CGPoint(x: 902.7, y: 87.37), controlPoint2: CGPoint(x: 909.01, y: 81.62))
        shape.addCurve(to: CGPoint(x: 921.14, y: 49.53), controlPoint1: CGPoint(x: 918.45, y: 66.62), controlPoint2: CGPoint(x: 920.92, y: 58.42))
        shape.addCurve(to: CGPoint(x: 918.99, y: 44.07), controlPoint1: CGPoint(x: 921.19, y: 47.42), controlPoint2: CGPoint(x: 920.47, y: 45.6))
        shape.close()
        return shape
        
    }
    
    static var yFont : UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 1036.5, y: 2.22))
        shape.addCurve(to: CGPoint(x: 1031.18, y: 0), controlPoint1: CGPoint(x: 1035.02, y: 0.74), controlPoint2: CGPoint(x: 1033.24, y: 0))
        shape.addCurve(to: CGPoint(x: 1025.86, y: 2.22), controlPoint1: CGPoint(x: 1029.11, y: 0), controlPoint2: CGPoint(x: 1027.34, y: 0.74))
        shape.addLine(to: CGPoint(x: 1002.41, y: 25.74))
        shape.addCurve(to: CGPoint(x: 1000.18, y: 31.06), controlPoint1: CGPoint(x: 1000.92, y: 27.18), controlPoint2: CGPoint(x: 1000.18, y: 28.95))
        shape.addCurve(to: CGPoint(x: 1002.41, y: 36.39), controlPoint1: CGPoint(x: 1000.18, y: 33.13), controlPoint2: CGPoint(x: 1000.92, y: 34.9))
        shape.addCurve(to: CGPoint(x: 1007.73, y: 38.61), controlPoint1: CGPoint(x: 1003.89, y: 37.87), controlPoint2: CGPoint(x: 1005.66, y: 38.61))
        shape.addCurve(to: CGPoint(x: 1013.05, y: 36.39), controlPoint1: CGPoint(x: 1009.8, y: 38.61), controlPoint2: CGPoint(x: 1011.57, y: 37.87))
        shape.addLine(to: CGPoint(x: 1036.5, y: 12.87))
        shape.addCurve(to: CGPoint(x: 1038.73, y: 7.55), controlPoint1: CGPoint(x: 1037.98, y: 11.43), controlPoint2: CGPoint(x: 1038.73, y: 9.66))
        shape.addCurve(to: CGPoint(x: 1036.5, y: 2.22), controlPoint1: CGPoint(x: 1038.73, y: 5.48), controlPoint2: CGPoint(x: 1037.98, y: 3.71))
        shape.close()
        shape.move(to: CGPoint(x: 998.03, y: 48.25))
        shape.addCurve(to: CGPoint(x: 997.89, y: 46.9), controlPoint1: CGPoint(x: 998.03, y: 47.8), controlPoint2: CGPoint(x: 997.98, y: 47.35))
        shape.addCurve(to: CGPoint(x: 997.49, y: 45.55), controlPoint1: CGPoint(x: 997.8, y: 46.45), controlPoint2: CGPoint(x: 997.67, y: 46))
        shape.addCurve(to: CGPoint(x: 997.49, y: 45.48), controlPoint1: CGPoint(x: 997.49, y: 45.51), controlPoint2: CGPoint(x: 997.49, y: 45.48))
        shape.addCurve(to: CGPoint(x: 996.81, y: 44.2), controlPoint1: CGPoint(x: 997.31, y: 45.03), controlPoint2: CGPoint(x: 997.08, y: 44.61))
        shape.addCurve(to: CGPoint(x: 996.75, y: 44.2), controlPoint1: CGPoint(x: 996.81, y: 44.2), controlPoint2: CGPoint(x: 996.79, y: 44.2))
        shape.addCurve(to: CGPoint(x: 995.8, y: 42.99), controlPoint1: CGPoint(x: 996.48, y: 43.75), controlPoint2: CGPoint(x: 996.16, y: 43.35))
        shape.addCurve(to: CGPoint(x: 995.8, y: 42.99), controlPoint1: CGPoint(x: 995.8, y: 42.99), controlPoint2: CGPoint(x: 995.8, y: 42.99))
        shape.addLine(to: CGPoint(x: 955.1, y: 2.22))
        shape.addCurve(to: CGPoint(x: 949.78, y: 0), controlPoint1: CGPoint(x: 953.62, y: 0.74), controlPoint2: CGPoint(x: 951.85, y: 0))
        shape.addCurve(to: CGPoint(x: 944.46, y: 2.22), controlPoint1: CGPoint(x: 947.71, y: 0), controlPoint2: CGPoint(x: 945.94, y: 0.74))
        shape.addCurve(to: CGPoint(x: 942.23, y: 7.55), controlPoint1: CGPoint(x: 942.97, y: 3.71), controlPoint2: CGPoint(x: 942.23, y: 5.48))
        shape.addCurve(to: CGPoint(x: 944.46, y: 12.87), controlPoint1: CGPoint(x: 942.23, y: 9.66), controlPoint2: CGPoint(x: 942.97, y: 11.43))
        shape.addLine(to: CGPoint(x: 982.93, y: 51.41))
        shape.addLine(to: CGPoint(x: 982.53, y: 89.01))
        shape.addCurve(to: CGPoint(x: 984.68, y: 94.34), controlPoint1: CGPoint(x: 982.53, y: 91.08), controlPoint2: CGPoint(x: 983.25, y: 92.85))
        shape.addCurve(to: CGPoint(x: 990.01, y: 96.63), controlPoint1: CGPoint(x: 986.12, y: 95.86), controlPoint2: CGPoint(x: 987.9, y: 96.63))
        shape.addLine(to: CGPoint(x: 990.07, y: 96.63))
        shape.addCurve(to: CGPoint(x: 995.4, y: 94.47), controlPoint1: CGPoint(x: 992.14, y: 96.63), controlPoint2: CGPoint(x: 993.92, y: 95.91))
        shape.addCurve(to: CGPoint(x: 997.62, y: 89.15), controlPoint1: CGPoint(x: 996.84, y: 92.99), controlPoint2: CGPoint(x: 997.58, y: 91.21))
        shape.addLine(to: CGPoint(x: 998.03, y: 48.38))
        shape.addCurve(to: CGPoint(x: 998.03, y: 48.38), controlPoint1: CGPoint(x: 998.03, y: 48.38), controlPoint2: CGPoint(x: 998.03, y: 48.38))
        shape.addLine(to: CGPoint(x: 998.03, y: 48.25))
        shape.close()
        
        return shape
        
    }
    
    
}



extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension UICollectionViewCell {
    
    
    
    
}

extension UIViewController {
    //    let platforms = ["3DO Interactive Multiplayer", "Amiga CD32", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", "Atari Lynx", "ColecoVision", "Fairchild Channel F", "Intellivision", "Magnavox Odyssey", "Microsoft Xbox", "Microsoft Xbox 360", "Microsoft Xbox One", "Microsoft Xbox Series S|X", "Neo Geo AES", "Neo Geo CD", "Neo Geo Pocket", "Neo Geo Pocket Color", "Nintendo Game & Watch", "Nintendo Entertainment System (NES)", "Super Nintendo Entertainment System (SNES)", "Nintendo Virtual Boy", "Nintendo 64", "Nintendo GameCube", "Nintendo Wii", "Nintendo Wii U", "Nintendo Switch", "Nintendo Game Boy", "Nintendo Game Boy Advance", "Nintendo DS", "Nintendo DSi", "Nintendo 3DS", "New Nintendo 3DS", "Nintendo Pokémon Mini", "Nokia N-Gage", "Nuon", "TurboGrafx-16/PC Engine", "PC Engine SuperGrafx","Philips CD-i", "Sega SG-1000", "Sega Master System", "Sega Genesis/Mega Drive", "Sega CD", "Sega 32X", "Sega Saturn", "Sega Dreamcast", "Sega Game Gear", "Sega Pico", "Sony PlayStation", "Sony PlayStation 2", "Sony PlayStation 3", "Sony PlayStation 4", "Sony PlayStation 5", "Sony PlayStation Portable (PSP)", "Sony PlayStation Vita", "Vectrex", "WonderSwan", "WonderSwan Color", "Zeebo"]
    
    
    
    func formatPlatformIDToPrettyPlatformName(ID: Int) -> String {
        
        switch ID {
        case 50     :   return "3DO Interactive Multiplayer"
        case 114    :   return "Amiga CD32"
        case 59     :   return "Atari 2600"
        case 66     :   return "Atari 5200"
        case 60     :   return "Atari 7800"
        case 62     :   return "Atari Jaguar"
        case 61     :   return "Atari Lynx"
        case 68     :   return "ColecoVision"
        case 127    :   return "Fairchild Channel F"
        case 67     :   return "Intellivision"
        case 88     :   return "Magnavox Odyssey"
        case 11     :   return "Microsoft Xbox"
        case 12     :   return "Microsoft Xbox 360"
        case 49     :   return "Microsoft Xbox One"
        case 169    :   return "Microsoft Xbox Series S|X"
        case 80     :   return "Neo Geo AES"
        case 136    :   return "Neo Geo CD"
        case 119    :   return "Neo Geo Pocket"
        case 120    :   return "Neo Geo Pocket Color"
        case 307    :   return "Nintendo Game & Watch"
        case 18     :   return "Nintendo Entertainment System (NES)"
        case 19     :   return "Super Nintendo Entertainment System (SNES)"
        case 87     :   return "Nintendo Virtual Boy"
        case 4      :   return "Nintendo 64"
        case 21     :   return "Nintendo GameCube"
        case 5      :   return "Nintendo Wii"
        case 41     :   return "Nintendo Wii U"
        case 130    :   return "Nintendo Switch"
        case 33     :   return "Nintendo Game Boy"
        case 22     :   return "Nintendo Game Boy Color"
        case 24     :   return "Nintendo Game Boy Advance"
        case 20     :   return "Nintendo DS"
        case 159    :   return "Nintendo DSi"
        case 37     :   return "Nintendo 3DS"
        case 137    :   return "New Nintendo 3DS"
        case 166    :   return "Nintendo Pokémon Mini"
        case 42     :   return "Nokia N-Gage"
        case 122    :   return "Nuon"
        case 86     :   return "TurboGrafx-16/PC Engine"
        case 128    :   return "PC Engine SuperGrafx"
        case 117    :   return "Philips CD-i"
        case 84     :   return "Sega SG-1000"
        case 64     :   return "Sega Master System"
        case 29     :   return "Sega Genesis/Mega Drive"
        case 78     :   return "Sega CD"
        case 30     :   return "Sega 32X"
        case 32     :   return "Sega Saturn"
        case 23     :   return "Sega Dreamcast"
        case 35     :   return "Sega Game Gear"
        case 339    :   return "Sega Pico"
        case 7      :   return "Sony PlayStation"
        case 8      :   return "Sony PlayStation 2"
        case 9      :   return "Sony PlayStation 3"
        case 48     :   return "Sony PlayStation 4"
        case 167    :   return "Sony PlayStation 5"
        case 38     :   return "Sony PlayStation Portable (PSP)"
        case 46     :   return "Sony PlayStation Vita"
        case 70     :   return "Vectrex"
        case 57     :   return "WonderSwan"
        case 123    :   return "WonderSwan Color"
        case 240    :   return "Zeebo"
        default     :
            return "Unknown Platform, platform ID is \(ID)"
        }
        
    }
    
    func formatPrettyPlatformNameToID(platformName: String) -> Int {
        
        switch platformName {
        case "3DO Interactive Multiplayer"                  :   return 50
        case "Amiga CD32"                                   :   return 114
        case "Atari 2600"                                   :   return 59
        case "Atari 5200"                                   :   return 66
        case "Atari 7800"                                   :   return 60
        case "Atari Jaguar"                                 :   return 62
        case "Atari Lynx"                                   :   return 61
        case "ColecoVision"                                 :   return 68
        case "Fairchild Channel F"                          :   return 127
        case "Intellivision"                                :   return 67
        case "Magnavox Odyssey"                             :   return 88
        case "Microsoft Xbox"                               :   return 11
        case "Microsoft Xbox 360"                           :   return 12
        case "Microsoft Xbox One"                           :   return 49
        case "Microsoft Xbox Series S|X"                    :   return 169
        case "Neo Geo AES"                                  :   return 80
        case "Neo Geo CD"                                   :   return 136
        case "Neo Geo Pocket"                               :   return 119
        case "Neo Geo Pocket Color"                         :   return 120
        case "Nintendo Game & Watch"                        :   return 307
        case "Nintendo Entertainment System (NES)"          :   return 18
        case "Super Nintendo Entertainment System (SNES)"   :   return 19
        case "Nintendo Virtual Boy"                         :   return 87
        case "Nintendo 64"                                  :   return 4
        case "Nintendo GameCube"                            :   return 21
        case "Nintendo Wii"                                 :   return 5
        case "Nintendo Wii U"                               :   return 41
        case "Nintendo Switch"                              :   return 130
        case "Nintendo Game Boy"                            :   return 33
        case "Nintendo Game Boy Color"                      :   return 22
        case "Nintendo Game Boy Advance"                    :   return 24
        case "Nintendo DS"                                  :   return 20
        case "Nintendo DSi"                                 :   return 159
        case "Nintendo 3DS"                                 :   return 37
        case "New Nintendo 3DS"                             :   return 137
        case "Nintendo Pokémon Mini"                        :   return 166
        case "Nokia N-Gage"                                 :   return 42
        case "Nuon"                                         :   return 122
        case "TurboGrafx-16/PC Engine"                      :   return 86
        case "PC Engine SuperGrafx"                         :   return 128
        case "Philips CD-i"                                 :   return 117
        case "Sega SG-1000"                                 :   return 84
        case "Sega Master System"                           :   return 64
        case "Sega Genesis/Mega Drive"                      :   return 29
        case "Sega CD"                                      :   return 78
        case "Sega 32X"                                     :   return 30
        case "Sega Saturn"                                  :   return 32
        case "Sega Dreamcast"                               :   return 23
        case "Sega Game Gear"                               :   return 35
        case "Sega Pico"                                    :   return 339
        case "Sony PlayStation"                             :   return 7
        case "Sony PlayStation 2"                           :   return 8
        case "Sony PlayStation 3"                           :   return 9
        case "Sony PlayStation 4"                           :   return 48
        case "Sony PlayStation 5"                           :   return 167
        case "Sony PlayStation Portable (PSP)"              :   return 38
        case "Sony PlayStation Vita"                        :   return 46
        case "Vectrex"                                      :   return 70
        case "WonderSwan"                                   :   return 57
        case "WonderSwan Color"                             :   return 123
        case "Zeebo"                                        :   return 240
        default                                             :   return 18
        }
        
    }
    
    func formatIGDBToPrettyTitle(platformName: String) -> String {
        
        var title = ""
        
        switch platformName {
            
            
        case "Odyssey":
            title = "Magnavox Odyssey"
            
        case "Xbox":
            title = "Microsoft Xbox"
            
        case "Xbox 360":
            title = "Microsoft Xbox 360"
            
        case "Xbox One":
            title = "Microsoft Xbox One"
            
        case "Xbox Series X|S":
            title = "Microsoft Xbox Series S|X"
            
        case "Game & Watch":
            title = "Nintendo Game & Watch"
            
        case "Virtual Boy":
            title = "Nintendo Virtual Boy"
            
        case "Game Boy":
            title = "Nintendo Game Boy"
        case "Game Boy Color":
            title = "Nintendo Game Boy Color"
            
        case "Game Boy Advance":
            title = "Nintendo Game Boy Advance"
            
        case "Pokémon Mini":
            title = "Nintendo Pokémon mini"
            
        case "Wii":
            title = "Nintendo Wii"
            
        case "Wii U":
            title = "Nintendo Wii U"
            
        case "SG-1000":
            title = "Sega SG-1000"
            
        case "Sega Mega Drive/Genesis":
            title = "Sega Genesis/Mega Drive"
            
        case "Dreamcast":
            title = "Sega Dreamcast"
            
        case "N-Gage":
            title = "Nokia N-Gage"
            
        case "PlayStation":
            title = "Sony PlayStation"
            
        case "PlayStation 2":
            title = "Sony PlayStation 2"
            
        case "PlayStation 3":
            title = "Sony PlayStation 3"
            
        case "PlayStation 4":
            title = "Sony PlayStation 4"
            
        case "PlayStation 5":
            title = "Sony PlayStation 5"
            
        case "PlayStation Portable":
            title = "Sony PlayStation Portable (PSP)"
            
        case "PlayStation Vita":
            title = "Sony PlayStation Vita"
            
        default:
            title = platformName
            
        }
        
        return title
        
        
    }
    
    
    func formatPrettyTitleToIGDB(platformName: String) -> String {
        
        var title = ""
        
        switch platformName {
            
            
        case "Magnavox Odyssey"                 :   title = "Odyssey"
        case "Microsoft Xbox"                   :   title = "Xbox"
        case "Microsoft Xbox 360"               :   title = "Xbox 360"
        case "Microsoft Xbox One"               :   title = "Xbox One"
        case "Microsoft Xbox Series S|X"        :   title = "Xbox Series X|S"
        case "Nintendo Game & Watch"            :   title = "Game & Watch"
        case "Nintendo Virtual Boy"             :   title = "Virtual Boy"
        case "Nintendo Game Boy"                :   title = "Game Boy"
        case "Nintendo Game Boy Color"          :   title = "Game Boy Color"
        case "Nintendo Game Boy Advance"        :   title = "Game Boy Advance"
        case "Nintendo Pokémon Mini"            :   title = "Pokémon mini"
        case "Nintendo Wii"                     :   title = "Wii"
        case "Nintendo Wii U"                   :   title = "Wii U"
        case "Sega SG-1000"                     :   title = "SG-1000"
        case "Sega Genesis/Mega Drive"          :   title = "Sega Mega Drive/Genesis"
        case "Sega Dreamcast"                   :   title = "Dreamcast"
        case "Nokia N-Gage"                     :   title = "N-Gage"
        case "Sony PlayStation"                 :   title = "PlayStation"
        case "Sony PlayStation 2"               :   title = "PlayStation 2"
        case "Sony PlayStation 3"               :   title = "PlayStation 3"
        case "Sony PlayStation 4"               :   title = "PlayStation 4"
        case "Sony PlayStation 5"               :   title = "PlayStation 5"
        case "Sony PlayStation Portable (PSP)"  :   title = "PlayStation Portable"
        case "Sony PlayStation Vita"            :   title = "PlayStation Vita"
        default                                 :   title = platformName
            
        }
        
        return title
        
        
        
    }
    
    
    func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else
        {

            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {

            return nil
        }
        
        return UIImage(ciImage: outputImage)
        
        
    }
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    
    
    
    func showSpinner(onView : UIView, userInterfaceStyle: UIUserInterfaceStyle) {
        onView.isHidden = false
        var spinnerView = NVActivityIndicatorView(frame: .zero, type: nil, color: nil, padding: nil)
        
        
        if userInterfaceStyle == .light {

            
            spinnerView = NVActivityIndicatorView(frame: onView.bounds, type: .ballSpinFadeLoader, color: .black, padding: 20)
            
        } else {

            spinnerView = NVActivityIndicatorView(frame: onView.bounds, type: .ballSpinFadeLoader, color: .white, padding: 20)
            
        }
        spinnerView.alpha = 0.75
        spinnerView.backgroundColor = .clear
        onView.backgroundColor = .clear
        onView.layer.cornerRadius = 15
        spinnerView.startAnimating()
        spinnerView.center = spinnerView.center
        
        DispatchQueue.main.async {
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
        
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    
    func fetchAddToButtonIcon(platformID: Int, owned: Bool) -> String {

        var imageName: String = ""
        
        switch platformID {
            
        case 240                :   if owned {
            imageName = "hdd-minus-inversed"}
            else {
                imageName = "hdd-plus-inversed"}
            
        case 57, 123            :   if owned {
            imageName = "wonderswan-minus-inversed"}
            else {
                imageName = "wonderswan-plus-inversed"}
            
        case 70                 :   if owned {
            imageName = "vectrex-minus-inversed"}
            else {
                imageName = "vectrex-plus-inversed"}
            
        case 86, 128            :   if owned {
            imageName = "turbografx-minus-inversed"}
            else {
                imageName = "turbografx-plus-inversed"}
            
        case 42                 :   if owned {
            imageName = "ngage-minus-inversed"}
            else {
                imageName = "ngage-plus-inversed"}
            
        case 61                 :   if owned {
            imageName = "atarilynx-minus-inversed"}
            else {
                imageName = "atarilynx-plus-inversed"}
            
        case 66                 :   if owned {
            imageName = "atari5200-minus-inversed"}
            else {
                imageName = "atari5200-plus-inversed"}
            
        case 59, 60             :   if owned {
            imageName = "atari2600-minus-inversed"}
            else {
                imageName = "atari2600-plus-inversed"}
            
        case 307                :   if owned {
            imageName = "gameandwatch-minus-inversed"}
            else {
                imageName = "gameandwatch-plus-inversed"}
            
        case 18                 :   if owned {
            imageName = "nes-minus-inversed"}
            else {
                imageName = "nes-plus-button"}
            
        case 19                 :   if owned {
            imageName = "snes-minus-inversed"}
            else {
                imageName = "snes-plus-inversed"}
            
        case 4                  :   if owned {
            imageName = "n64-minus-inversed"}
            else {
                imageName = "n64-plus-inversed"}
            
        case 87                 :   if owned {
            imageName = "nvb-minus-inversed"}
            else {
                imageName = "nvb-plus-inversed"}
            
        case 20, 159, 37, 137   :   if owned {
            imageName = "nds-minus-inversed"}
            else {
                imageName = "nds-plus-inversed"}
            
        case 21                 :   if owned {
            imageName = "gc-minus-inversed"}
            else {
                imageName = "gc-plus-inversed"}
            
        case 33, 22             :   if owned {
            imageName = "gb-minus-inversed"}
            else {
                imageName = "gb-plus-inversed"}
            
        case 24                 :   if owned {
            imageName = "gba-minus-inversed"}
            else {
                imageName = "gba-plus-inversed"}
            
        case 166                :   if owned {
            imageName = "nintendopokemonmini-minus-inversed"}
            else {
                imageName = "nintendopokemonmini-plus-inversed"}
            
        case 130                :   if owned {
            imageName = "switch-minus-inversed"}
            else {
                imageName = "switch-plus-inversed"}
            
        case 64                 :   if owned {
            imageName = "sms-minus-inversed"}
            else {
                imageName = "sms-plus-inversed"}
            
        case 35                 :   if owned {
            imageName = "gamegear-minus-inversed"}
            else {
                imageName = "gamegear-plus-inversed"}
            
        case 30                 :   if owned {
            imageName = "32x-minus-inversed"}
            else {
                imageName = "32x-plus-inversed"}
            
        case 62                 :   if owned {
            imageName = "atarijaguar-minus-inversed"}
            else {
                imageName = "atarijaguar-plus-inversed"}
            
        case 29                 :   if owned {
            imageName = "genesis-minus-inversed"}
            else {
                imageName = "genesis-plus-inversed"}
            
        case 80                 :   if owned {
            imageName = "neogeo-minus-inversed"}
            else {
                imageName = "neogeo-plus-inversed"}
        case 78, 7, 167, 12,
            49, 48, 9, 32,
            117, 114, 50, 11,
            23, 136, 8, 169,
            5, 122, 41         :   if owned {
                imageName = "cd-minus-inversed"}
            else {
                imageName = "cd-plus-inversed"}
            
        case 84                 :   if owned {
            imageName = "segasg1000-minus-inversed"}
            else {
                imageName = "segasg1000-plus-inversed"}
            
        case 339                :   if owned {
            imageName = "segapico-minus-inversed"}
            else {
                imageName = "segapico-plus-inversed"}
            
        case 38                 :   if owned {
            imageName = "sonypsp-minus-inversed"}
            else {
                imageName = "sonypsp-plus-inversed"}
            
        case 46                 :   if owned {
            imageName = "psvita-minus-inversed"}
            else {
                imageName = "psvita-plus-inversed"}
            
        case 68                 :   if owned {
            imageName = "colecovision-minus-inversed"}
            else {
                imageName = "colecovision-plus-inversed"}
            
        case 127                :   if owned {
            imageName = "fairchild-minus-inversed"}
            else {
                imageName = "fairchild-plus-inversed"}
            
        case 67                 :   if owned {
            imageName = "intellivision-minus-inversed"}
            else {
                imageName = "intellivision-plus-inversed"}
            
        case 88                 :   if owned {
            imageName = "odyssey-minus-inversed"}
            else {
                imageName = "odyssey-plus-inversed"}
            
        case 119, 120           :   if owned {
            imageName = "neogeopocket-minus-inversed"}
            else {
                imageName = "neogeopocket-plus-inversed"}
            
        default                 :   print("Invalid Platform")
            
        }
        
        return imageName
        
    }
    
    
    func changePlatformNameToID(platformName: String) -> Int {
        
        let network = Networking.shared
        let platforms = network.platforms
        
        for platform in platforms {
            if platform.name == platformName {
                return platform.id
            }
            
        }
        
        return 0
        
        
    }
    
    
    func setPlatformIcon(platformID: Int, mode: UIUserInterfaceStyle?) -> String {
        
        var platformImageName: String = ""

        switch platformID {
        case 18:
            
            if mode == .light {
                //Light Mode
                platformImageName = "NESLogo"
            } else {
                //Dark Mode
                platformImageName = "NESLogoInverse"
                
            }
            
        case 19:
            if mode == .light {
                //Light Mode
                platformImageName = "SNESLogo"
            } else {
                //Dark Mode
                platformImageName = "SNESLogoInverse"
                
            }
        case 4:
            if mode == .light {
                //Light Mode
                platformImageName = "N64Logo"
            } else {
                //Dark Mode
                platformImageName = "N64LogoInverse"
                
            }
        case 21:
            if mode == .light {
                //Light Mode
                platformImageName = "GCLogo"
            } else {
                //Dark Mode
                platformImageName = "GCLogoInverse"
                
            }
        case 33:
            if mode == .light {
                //Light Mode
                platformImageName = "GBLogo"
            } else {
                //Dark Mode
                platformImageName = "GBLogoInverse"
                
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
            
        case 24:
            if mode == .light {
                //Light Mode
                platformImageName = "GBALogo"
            } else {
                //Dark Mode
                platformImageName = "gbaLogoInverse"
                
            }
        case 29:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaGenesisLogoInverse"
                
            }
        case 78:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaCDLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaCDLogoInverse"
                
            }
            
        case 339:
            platformImageName = "SegaPicoLogo"
            
        case 8:
            if mode == .light {
                platformImageName = "SonyPlaystation2Logo"
            } else {
                
                platformImageName = "SonyPlaystation2LogoInverse"
            }
            
        case 88:
            platformImageName = "OdysseyLogo"
            
        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            if mode == .light {
                platformImageName = "SegaGameGearLogo"
            } else {
                platformImageName = "SegaGameGearLogoInverse"
            }
        case 123:
            if mode == .light {
                platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"
                
            }
            
        case 62:
            platformImageName = "AtariJaguarLogo"
            
        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
            
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 23:
            if mode == .light {
                platformImageName = "SegaDreamcastLogo"
            } else {
                platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }
            
        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }
            
        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
                platformImageName = "FairchildChannelFLogo"
            } else {
                platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"
                
            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
            
            
        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            if mode == .light {
                platformImageName = "PhilipsCDiLogo"
            }
            else {
                platformImageName = "PhilipsCDiLogoInverse"
            }
        case 122:
            if mode == .light {
                platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"
                
            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"
                
            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"
                
            }
        case 307:
            if mode == .light {
                platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"
                
            }
            
        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
                platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"
                
            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"
                
            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"
                
            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"
                
            }
            
        case 7:
            if mode == .light {
                platformImageName = "SonyPlaystationLogo"
            } else {
                platformImageName = "SonyPlayStationLogoInverse"
            }
        case 80:
            if mode == .light {
                platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"
                
            }
        case 84:
            platformImageName = "SegaSG1000Logo"
            
            
            
        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"
                
            }
            
        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"
                
            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"
            
        case 0:
            
            if mode == .light {
                //Light Mode
                platformImageName = "allPlatformLogo"
            } else {
                //Dark Mode
                platformImageName = "allPlatformLogoInverse"
                
            }
            
        default:
            print("Invalid Platform")
            
            
        }
        return platformImageName
        
    }
    
    
//    func getImageFileName(imageType: String, imageData: [GameImages.Inner]) -> String {
//        print("outside imageData \(imageData)")
//        
//        let images = imageData
//        
//        var imageFileName : String = ""
//        
//        let testArray = images.filter({$0.type == "\(imageType)"})
//        print("testArray = \(testArray)")
//        
//        if testArray.count > 0 && imageType == "fanart"{
//            imageFileName = (testArray.randomElement()?.fileName)!
//            
//        } else if testArray.count > 0 {
//            imageFileName = (testArray[0].fileName) 
//        }
//        return imageFileName
//    }
    
    
    
}


extension String {
    
    func removing(charactersOf string: String) -> String {
        let characterSet = CharacterSet(charactersIn: string)
        let components = self.components(separatedBy: characterSet)
        return components.joined(separator: "")
    }
    
    
    func levenshteinDistanceScore(to string: String, ignoreCase: Bool = true, trimWhiteSpacesAndNewLines: Bool = true) -> Double {
        
        var firstString = self
        var secondString = string
        
        if ignoreCase {
            firstString = firstString.lowercased()
            secondString = secondString.lowercased()
        }
        if trimWhiteSpacesAndNewLines {
            firstString = firstString.trimmingCharacters(in: .whitespacesAndNewlines)
            secondString = secondString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        let empty = [Int](repeating:0, count: secondString.count)
        var last = [Int](0...secondString.count)
        
        for (i, tLett) in firstString.enumerated() {
            var cur = [i + 1] + empty
            for (j, sLett) in secondString.enumerated() {
                cur[j + 1] = tLett == sLett ? last[j] : Swift.min(last[j], last[j + 1], cur[j])+1
            }
            last = cur
        }
        
        // maximum string length between the two
        let lowestScore = max(firstString.count, secondString.count)
        
        if let validDistance = last.last {
            return  1 - (Double(validDistance) / Double(lowestScore))
        }
        
        return 0.0
    }
    
    
}



extension UIImageView {
    
    //// Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    func setImageAnimated(imageUrl:URL, placeholderImage:UIImage?, completed: @escaping () -> ()) {
        
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: imageUrl, placeholderImage: placeholderImage , completed: { (image, error, cacheType, url) in
            if error == nil {
                
                    if let superview = self.superview {
                        UIView.transition(with: superview, duration: 0.2, options:  [.transitionCrossDissolve ,.allowUserInteraction, .curveEaseIn], animations: {
                            self.image = image
                            
                            
                        }, completion: { (complete) in
                            completed()
                            
                        })
                    }
            
            }
            
            if error != nil {
                print("error = (\(String(describing: error))")
            }
            
            
        })
        
    }
    
    func loadImage(from urlString: String, completed: @escaping () -> ()) {
        let activityIndicator = self.activityIndicator
        
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) {
            
            self.image = cacheImage
            
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {

                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)

            imageCache.setObject(image!, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                
                self.image = image
                
            }
            
        }.resume()
        
        
        let imageURL = URL(string: urlString)!
        
        DispatchQueue.global().async { [weak self] in
            
            if let data = try? Data(contentsOf: imageURL) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        
                        self?.image = image
                        
                        completed()
                    }
                }
            }
        }
    }
    
    
    
    func loadCoverImage(from url: String, completed: @escaping () -> ()) {
        
        let imageURL = URL(string: url)
        
        DispatchQueue.global().async { [weak self] in
            
            if let data = try? Data(contentsOf: imageURL!) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        
                        self?.image = image
                        
                        completed()
                    }
                }
            }
        }
    }
    
    
    func downloadImage(from imgURL: String) -> URLSessionDataTask? {
        guard let url = URL(string: imgURL) else { return nil }
        
        // set initial image to nil so it doesn't use the image from a reused cell
        image = nil
        
        // check if the image is already in the cache
        if let imageToCache = testimageCache.object(forKey: imgURL as NSString) {
            self.image = imageToCache
            return nil
        }
        
        // download the image asynchronously
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {

                return
            }
            DispatchQueue.main.async {
                // create UIImage
                let imageToCache = UIImage(data: data!)
                // add image to cache
                testimageCache.setObject(imageToCache!, forKey: imgURL as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        return task
    }
    
}

extension UITableViewCell {
    var cellActionButtonLabel: UILabel? {
        superview?.subviews
            .filter { String(describing: $0).range(of: "UISwipeActionPullView") != nil }
            .flatMap { $0.subviews }
            .filter { String(describing: $0).range(of: "UISwipeActionStandardButton") != nil }
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }.first
    }
    
    
    func formatPrettyPlatformNameToID(platformName: String) -> Int {
        
        switch platformName {
        case "3DO Interactive Multiplayer"                  :   return 50
        case "Amiga CD32"                                   :   return 114
        case "Atari 2600"                                   :   return 59
        case "Atari 5200"                                   :   return 66
        case "Atari 7800"                                   :   return 60
        case "Atari Jaguar"                                 :   return 62
        case "Atari Lynx"                                   :   return 61
        case "ColecoVision"                                 :   return 68
        case "Fairchild Channel F"                          :   return 127
        case "Intellivision"                                :   return 67
        case "Magnavox Odyssey"                             :   return 88
        case "Microsoft Xbox"                               :   return 11
        case "Microsoft Xbox 360"                           :   return 12
        case "Microsoft Xbox One"                           :   return 49
        case "Microsoft Xbox Series S|X"                    :   return 169
        case "Neo Geo AES"                                  :   return 80
        case "Neo Geo CD"                                   :   return 136
        case "Neo Geo Pocket"                               :   return 119
        case "Neo Geo Pocket Color"                         :   return 120
        case "Nintendo Game & Watch"                        :   return 307
        case "Nintendo Entertainment System (NES)"          :   return 18
        case "Super Nintendo Entertainment System (SNES)"   :   return 19
        case "Nintendo Virtual Boy"                         :   return 87
        case "Nintendo 64"                                  :   return 4
        case "Nintendo GameCube"                            :   return 21
        case "Nintendo Wii"                                 :   return 5
        case "Nintendo Wii U"                               :   return 41
        case "Nintendo Switch"                              :   return 130
        case "Nintendo Game Boy"                            :   return 33
        case "Nintendo Game Boy Color"                      :   return 22
        case "Nintendo Game Boy Advance"                    :   return 24
        case "Nintendo DS"                                  :   return 20
        case "Nintendo DSi"                                 :   return 159
        case "Nintendo 3DS"                                 :   return 37
        case "New Nintendo 3DS"                             :   return 137
        case "Nintendo Pokémon Mini"                        :   return 166
        case "Nokia N-Gage"                                 :   return 42
        case "Nuon"                                         :   return 122
        case "TurboGrafx-16/PC Engine"                      :   return 86
        case "PC Engine SuperGrafx"                         :   return 128
        case "Philips CD-i"                                 :   return 117
        case "Sega SG-1000"                                 :   return 84
        case "Sega Master System"                           :   return 64
        case "Sega Genesis/Mega Drive"                      :   return 29
        case "Sega CD"                                      :   return 78
        case "Sega 32X"                                     :   return 30
        case "Sega Saturn"                                  :   return 32
        case "Sega Dreamcast"                               :   return 23
        case "Sega Game Gear"                               :   return 35
        case "Sega Pico"                                    :   return 339
        case "Sony PlayStation"                             :   return 7
        case "Sony PlayStation 2"                           :   return 8
        case "Sony PlayStation 3"                           :   return 9
        case "Sony PlayStation 4"                           :   return 48
        case "Sony PlayStation 5"                           :   return 167
        case "Sony PlayStation Portable (PSP)"              :   return 38
        case "Sony PlayStation Vita"                        :   return 46
        case "Vectrex"                                      :   return 70
        case "WonderSwan"                                   :   return 57
        case "WonderSwan Color"                             :   return 123
        case "Zeebo"                                        :   return 240
        default                                             :   return 18
        }
        
    }
}


extension UIImage {
    
        func aspectFitImage(inRect rect: CGRect) -> UIImage? {
            let width = self.size.width
            let height = self.size.height
            let aspectWidth = rect.width / width
            let aspectHeight = rect.height / height
            let scaleFactor = aspectWidth > aspectHeight ? rect.size.height / height : rect.size.width / width

            UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
            self.draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

            defer {
                UIGraphicsEndImageContext()
            }

            return UIGraphicsGetImageFromCurrentImageContext()
        }
  
    
    func addBackgroundCircle(_ color: UIColor?) -> UIImage? {
        
        let circleDiameter = max(size.width * 2, size.height * 2)
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)
        
        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5
        
        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)
        
        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { ctx in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }
        
        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)
        
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    func getImageWithBlur(blurAmount: Int) -> UIImage?{
        let context = CIContext(options: nil)
        
        guard let currentFilter = CIFilter(name: "CIGaussianBlur") else {
            return nil
        }
        let beginImage = CIImage(image: self)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(blurAmount, forKey: "inputRadius")
        guard let output = currentFilter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        return UIImage(cgImage: cgimg)
    }
    
    func tintedWithLinearGradientColors(colorsArr: [CGColor]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        context.translateBy(x: self.size.width, y: 0)
        context.scaleBy(x: -1, y: 1)
        
        context.setBlendMode(.normal)
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        
        // Create gradient
        let colors = colorsArr as CFArray
        let space = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)
        
        // Apply gradient
        context.clip(to: rect, mask: self.cgImage!)
        context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: self.size.width, y: 0), options: .drawsAfterEndLocation)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gradientImage!
    }
    
    
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    
    func edgeColor(_ insets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), defaultColor: UIColor = .black) -> UIColor {
        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return defaultColor
        }
        
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let width = Int(self.size.width * self.scale)
        let height = Int(self.size.height * self.scale)
        
        var edgeR: Int = 0
        var edgeG: Int = 0
        var edgeB: Int = 0
        var count: Int = 0
        
        for x in stride(from: 0, to: width, by: 1) {
            for y in stride(from: 0, to: height, by: 1) {
                let pixelInfo: Int = ((width * y) + x) * 4
                
                let r: Int = Int(data[pixelInfo])
                let g: Int = Int(data[pixelInfo + 1])
                let b: Int = Int(data[pixelInfo + 2])
                
                // Accumulate top, right and left edges
                if
                    x < Int(insets.left) ||
                        y < Int(insets.top) ||
                        x > width - Int(insets.right) ||
                        y > height - Int(insets.bottom)
                {
                    edgeR += r
                    edgeG += g
                    edgeB += b
                    count += 1
                }
            }
        }
        
        return UIColor(
            red: CGFloat(edgeR / count) / 255,
            green: CGFloat(edgeG / count) / 255,
            blue: CGFloat(edgeB / count) / 255,
            alpha: 1.0
        )
    }
    
}

extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

extension UITableViewCell {
    
    func setPlatformIcon(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
        
        var platformImageName: String = ""
        
        switch platformID! {
        case 18:
            
            if mode == .light {
                //Light Mode
                platformImageName = "NESLogo"
            } else {
                //Dark Mode
                platformImageName = "NESLogoInverse"
                
            }
            
        case 19:
            if mode == .light {
                //Light Mode
                platformImageName = "SNESLogo"
            } else {
                //Dark Mode
                platformImageName = "SNESLogoInverse"
                
            }
        case 4:
            if mode == .light {
                //Light Mode
                platformImageName = "N64Logo"
            } else {
                //Dark Mode
                platformImageName = "N64LogoInverse"
                
            }
        case 21:
            if mode == .light {
                //Light Mode
                platformImageName = "GCLogo"
            } else {
                //Dark Mode
                platformImageName = "GCLogoInverse"
                
            }
        case 33:
            if mode == .light {
                //Light Mode
                platformImageName = "GBLogo"
            } else {
                //Dark Mode
                platformImageName = "GBLogoInverse"
                
            }
        case 24:
            if mode == .light {
                //Light Mode
                platformImageName = "GBALogo"
            } else {
                //Dark Mode
                platformImageName = "gbaLogoInverse"
                
            }
        case 29:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaGenesisLogoInverse"
                
            }
        case 78:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaCDLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaCDLogoInverse"
                
            }
            
        case 339:
            platformImageName = "SegaPicoLogo"
            
        case 8:
            if mode == .light {
                platformImageName = "SonyPlaystation2Logo"
            } else {
                
                platformImageName = "SonyPlaystation2LogoInverse"
            }
            
        case 88:
            platformImageName = "OdysseyLogo"
            
        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            if mode == .light {
                platformImageName = "SegaGameGearLogo"
            } else {
                platformImageName = "SegaGameGearLogoInverse"
            }
        case 123:
            if mode == .light {
                platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"
                
            }
            
        case 62:
            platformImageName = "AtariJaguarLogo"
            
        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
            
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 23:
            if mode == .light {
                platformImageName = "SegaDreamcastLogo"
            } else {
                platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }
            
        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }
            
        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
                platformImageName = "FairchildChannelFLogo"
            } else {
                platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"
                
            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
            
        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            if mode == .light {
                platformImageName = "PhilipsCDiLogo"
            } else {
                platformImageName = "PhilipsCDiLogoInverse"
            }
            
        case 122:
            if mode == .light {
                platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"
                
            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"
                
            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"
                
            }
            
        case 307:
            if mode == .light {
                platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"
                
            }
            
        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
                platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"
                
            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"
                
            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"
                
            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"
                
            }
            
        case 7:
            if mode == .light {
                platformImageName = "SonyPlaystationLogo"
            } else {
                platformImageName = "SonyPlayStationLogoInverse"
                
                
            }
        case 80:
            if mode == .light {
                platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"
                
            }
        case 84:
            platformImageName = "SegaSG1000Logo"
            
            
            
        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"
                
            }
            
        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"
                
            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"
            
        case 0:
            
            if mode == .light {
                //Light Mode
                platformImageName = "allPlatformLogo"
            } else {
                //Dark Mode
                platformImageName = "allPlatformLogoInverse"
                
            }
            
        default:
            print("Invalid Platform")
            
            
        }
        return platformImageName
        
    }
    
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    
    func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else
        {

            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {

            return nil
        }
        
        return UIImage(ciImage: outputImage)
        
        
    }
    
    func fetchAddToButtonIcon(platformID: Int, owned: Bool) -> String {

        var imageName: String = ""
        
        switch platformID {
            
        case 240:
            if owned {
                imageName = "hdd-minus-inversed"
            } else {
                imageName = "hdd-plus-inversed"
                
            }
            
        case 57, 123:
            if owned {
                imageName = "wonderswan-minus-inversed"
            } else {
                imageName = "wonderswan-plus-inversed"
                
            }
            
        case 70:
            if owned {
                imageName = "vectrex-minus-inversed"
            } else {
                imageName = "vectrex-plus-inversed"
                
            }
            
            
        case 86, 128:
            if owned {
                imageName = "turbografx-minus-inversed"
            } else {
                imageName = "turbografx-plus-inversed"
                
            }
            
        case 42:
            if owned {
                imageName = "ngage-minus-inversed"
            } else {
                imageName = "ngage-plus-inversed"
                
            }
        case 61:
            if owned {
                imageName = "atarilynx-minus-inversed"
            } else {
                imageName = "atarilynx-plus-inversed"
                
            }
        case 66:
            if owned {
                imageName = "atari5200-minus-inversed"
                
            } else {
                imageName = "atari5200-plus-inversed"
                
            }
            
        case 59, 60:
            if owned {
                imageName = "atari2600-minus-inversed"
            } else {
                imageName = "atari2600-plus-inversed"
            }
            
        case 307:
            if owned {
                imageName = "gameandwatch-minus-inversed"
            } else {
                imageName = "gameandwatch-plus-inversed"
                
            }
            
        case 18:
            if owned {
                imageName = "nes-minus-inversed"
            } else {
                imageName = "nes-plus-button"
            }
            
        case 19:
            if owned {
                imageName = "snes-minus-inversed"
            } else {
                imageName = "snes-plus-inversed"
            }
            
        case 4:
            if owned {
                imageName = "n64-minus-inversed"
            } else {
                imageName = "n64-plus-inversed"
            }
            
        case 87:
            if owned {
                imageName = "nvb-minus-inversed"
            } else {
                imageName = "nvb-plus-inversed"
            }
            
        case 20, 159, 37, 137:
            if owned {
                imageName = "nds-minus-inversed"
            } else {
                imageName = "nds-plus-inversed"
            }
            
        case 21:
            if owned {
                imageName = "gc-minus-inversed"
            } else {
                imageName = "gc-plus-inversed"
            }
            
        case 33, 22:
            if owned {
                imageName = "gb-minus-inversed"
            } else {
                imageName = "gb-plus-inversed"
            }
        case 24:
            if owned {
                imageName = "gba-minus-inversed"
            } else {
                imageName = "gba-plus-inversed"
            }
            
        case 166:
            if owned {
                imageName = "nintendopokemonmini-minus-inversed"
            } else {
                imageName = "nintendopokemonmini-plus-inversed"
            }
            
        case 130:
            if owned {
                imageName = "switch-minus-inversed"
            } else {
                imageName = "switch-plus-inversed"
            }
        case 64:
            if owned {
                imageName = "sms-minus-inversed"
            } else {
                imageName = "sms-plus-inversed"
            }
            
        case 35:
            if owned {
                imageName = "gamegear-minus-inversed"
            } else {
                imageName = "gamegear-plus-inversed"
            }
        case 30:
            if owned {
                imageName = "32x-minus-inversed"
            } else {
                imageName = "32x-plus-inversed"
            }
            
        case 62:
            if owned {
                imageName = "atarijaguar-minus-inversed"
            } else {
                imageName = "atarijaguar-plus-inversed"
                
                
            }
            
        case 29:
            if owned {
                imageName = "genesis-minus-inversed"
            } else {
                imageName = "genesis-plus-inversed"
            }
            
        case 80:
            if owned {
                imageName = "neogeo-minus-inversed"
            } else {
                imageName = "neogeo-plus-inversed"
            }
        case 78, 7, 167, 12, 49, 48, 9, 32, 117, 114, 50, 11, 23, 136, 8, 169, 5, 122, 41:
            if owned {
                imageName = "cd-minus-inversed"
            } else {
                imageName = "cd-plus-inversed"
            }
        case 84:
            if owned {
                imageName = "segasg1000-minus-inversed"
            } else {
                
                imageName = "segasg1000-plus-inversed"
                
            }
            
        case 339:
            if owned {
                
                imageName = "segapico-minus-inversed"
            } else {
                imageName = "segapico-plus-inversed"
                
            }
            
        case 38:
            if owned {
                imageName = "sonypsp-minus-inversed"
            } else {
                imageName = "sonypsp-plus-inversed"
                
            }
            
        case 46:
            if owned {
                imageName = "psvita-minus-inversed"
            } else {
                imageName = "psvita-plus-inversed"
                
            }
            
        case 68:
            if owned {
                imageName = "colecovision-minus-inversed"
            } else {
                imageName = "colecovision-plus-inversed"
                
            }
        case 127:
            if owned {
                imageName = "fairchild-minus-inversed"
            } else {
                imageName = "fairchild-plus-inversed"
                
            }
        case 67:
            if owned {
                imageName = "intellivision-minus-inversed"
            } else {
                imageName = "intellivision-plus-inversed"
                
            }
        case 88:
            if owned {
                imageName = "odyssey-minus-inversed"
            } else {
                imageName = "odyssey-plus-inversed"
                
            }
        case 119, 120:
            if owned {
                imageName = "neogeopocket-minus-inversed"
            } else {
                imageName = "neogeopocket-plus-inversed"
                
            }
        default:
            print("Invalid Platform")
            
        }
        return imageName
        
    }
    
    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {
        
        var platform = PlatformObject(id: 0, abbreviation: nil, alternativeName: nil, category: nil, createdAt: nil, generation: nil, name: "", platformLogo: nil, platformFamily: nil, slug: nil, updatedAt: nil, url: nil, versions: nil, checksum: nil)
        
        let platforms = network.platforms
        
        for platformObject in platforms {
            
            if platformObject.id == platformID {
                
                platform = PlatformObject(id: platformObject.id, abbreviation: platformObject.abbreviation, alternativeName: platformObject.alternativeName, category: platformObject.category, createdAt: platformObject.createdAt, generation: platformObject.generation, name: platformObject.name, platformLogo: nil, platformFamily: platformObject.platformFamily, slug: platformObject.slug, updatedAt: platformObject.updatedAt, url: platformObject.url, versions: nil, checksum: platformObject.checksum)
                
            }
        }
        
        return platform
        
    }
    
    func setPlatformIconName(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
        
        var platformImageName: String = ""
        
        
        switch platformID! {
        case 18:
            
            if mode == .light {
                //Light Mode
                platformImageName = "NESLogo"
            } else {
                //Dark Mode
                platformImageName = "NESLogoInverse"
                
            }
            
        case 19:
            if mode == .light {
                //Light Mode
                platformImageName = "SNESLogo"
            } else {
                //Dark Mode
                platformImageName = "SNESLogoInverse"
                
            }
        case 4:
            if mode == .light {
                //Light Mode
                platformImageName = "N64Logo"
            } else {
                //Dark Mode
                platformImageName = "N64LogoInverse"
                
            }
        case 21:
            if mode == .light {
                //Light Mode
                platformImageName = "GCLogo"
            } else {
                //Dark Mode
                platformImageName = "GCLogoInverse"
                
            }
        case 33:
            if mode == .light {
                //Light Mode
                platformImageName = "GBLogo"
            } else {
                //Dark Mode
                platformImageName = "GBLogoInverse"
                
            }
        case 24:
            if mode == .light {
                //Light Mode
                platformImageName = "GBALogo"
            } else {
                //Dark Mode
                platformImageName = "gbaLogoInverse"
                
            }
        case 29:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaGenesisLogoInverse"
                
            }
        case 78:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaCDLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaCDLogoInverse"
                
            }
            
        case 339:
            platformImageName = "SegaPicoLogo"
            
        case 8:
            if mode == .light {
                platformImageName = "SonyPlaystation2Logo"
            } else {
                
                platformImageName = "SonyPlaystation2LogoInverse"
            }
            
        case 88:
            platformImageName = "OdysseyLogo"
            
        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            if mode == .light {
                platformImageName = "SegaGameGearLogo"
            } else {
                platformImageName = "SegaGameGearLogoInverse"
            }
        case 123:
            if mode == .light {
                platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"
                
            }
            
        case 62:
            platformImageName = "AtariJaguarLogo"
            
        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
        case 23:
            if mode == .light {
                platformImageName = "SegaDreamcastLogo"
            } else {
                platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }
            
        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }
            
        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
                platformImageName = "FairchildChannelFLogo"
            } else {
                platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"
                
            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
            
        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            if mode == .light {
                platformImageName = "PhilipsCDiLogo"
            } else {
                platformImageName = "PhilipsCDiLogoInverse"
            }
            
        case 122:
            if mode == .light {
                platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"
                
            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"
                
            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"
                
            }
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 307:
            if mode == .light {
                platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"
                
            }
            
        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
                platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"
                
            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"
                
            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"
                
            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"
                
            }
            
        case 7:
            if mode == .light {
                platformImageName = "SonyPlaystationLogo"
            } else {
                platformImageName = "SonyPlayStationLogoInverse"
            }
        case 80:
            if mode == .light {
                platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"
                
            }
        case 84:
            platformImageName = "SegaSG1000Logo"
            
            
            
        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"
                
            }
            
        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"
                
            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"
            
        case 0:
            
            if mode == .light {
                //Light Mode
                platformImageName = "allPlatformLogo"
            } else {
                //Dark Mode
                platformImageName = "allPlatformLogoInverse"
                
            }
            
        default:
            print("Invalid Platform")
            
            
        }
        return platformImageName
        
    }
    
    
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension UIView {
    
        var parentViewController: UIViewController? {
            var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder!.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    
       
    
    func addingShadow() {
       self.backgroundColor = UIColor.clear
       let roundedShapeLayer = CAShapeLayer()
       let roundedMaskPath = UIBezierPath(roundedRect: self.bounds,
                                         byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight],
                                         cornerRadii: CGSize(width: 8, height: 8))

       roundedShapeLayer.frame = self.bounds
       roundedShapeLayer.fillColor = UIColor.white.cgColor
       roundedShapeLayer.path = roundedMaskPath.cgPath

       self.layer.insertSublayer(roundedShapeLayer, at: 0)

       self.layer.shadowOpacity = 0.4
       self.layer.shadowOffset = CGSize(width: -0.1, height: 4)
       self.layer.shadowRadius = 3
       self.layer.shadowColor = UIColor.lightGray.cgColor
     }
    
    
    func applyRoundedGradient(layoutIfNeeded: Bool, colors: [CGColor]) {
        self.backgroundColor = nil
        if layoutIfNeeded {
            self.layoutIfNeeded()
            
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.cornerRadius = 10
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        gradientLayer.cornerRadius = 10
        gradientLayer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
       
    
    }
    
    
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
        
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
    
}



extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    static func fromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let r,g,b: CGFloat
        let offset = hexString.hasPrefix("#") ? 1: 0
        let start = hexString.index(hexString.startIndex, offsetBy: offset)
        let hexColor = String(hexString[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
    
    
}

extension UICollectionReusableView {
    
    func changePlatformNameToID(platformName: String) -> Int {
        
        let network = Networking.shared
        let platforms = network.platforms
        
        for platform in platforms {
            if platform.name == platformName {
                return platform.id
            }
            
        }
        
        return 0
        
        
    }
    
    func setPlatformIcon(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
        
        var platformImageName: String = ""
        
        
        switch platformID! {
        case 18:
            
            if mode == .light {
                //Light Mode
                platformImageName = "NESLogo"
            } else {
                //Dark Mode
                platformImageName = "NESLogoInverse"
                
            }
            
        case 19:
            if mode == .light {
                //Light Mode
                platformImageName = "SNESLogo1"
            } else {
                //Dark Mode
                platformImageName = "SNESLogo1Inverse"
                
            }
        case 4:
            if mode == .light {
                //Light Mode
                platformImageName = "N64Logo"
            } else {
                //Dark Mode
                platformImageName = "N64LogoInverse"
                
            }
        case 21:
            if mode == .light {
                //Light Mode
                platformImageName = "GCLogo"
            } else {
                //Dark Mode
                platformImageName = "GCLogoInverse"
                
            }
        case 33:
            if mode == .light {
                //Light Mode
                platformImageName = "GBLogo"
            } else {
                //Dark Mode
                platformImageName = "GBLogoInverse"
                
            }
        case 24:
            if mode == .light {
                //Light Mode
                platformImageName = "GBALogo"
            } else {
                //Dark Mode
                platformImageName = "gbaLogoInverse"
                
            }
        case 29:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaGenesisLogoInverse"
                
            }
        case 78:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaCDLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaCDLogoInverse"
                
            }
            
        case 339:
            platformImageName = "SegaPicoLogo"
            
        case 8:
            if mode == .light {
                platformImageName = "SonyPlaystation2Logo"
            } else {
                
                platformImageName = "SonyPlaystation2LogoInverse"
            }
            
        case 88:
            platformImageName = "OdysseyLogo"
            
        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            platformImageName = "SegaGameGearLogo"
        case 123:
            if mode == .light {
                platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"
                
            }
            
        case 62:
            platformImageName = "AtariJaguarLogo"
            
        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
        case 23:
            if mode == .light {
                platformImageName = "SegaDreamcastLogo"
            } else {
                platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }
            
        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }
            
        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
                platformImageName = "FairchildChannelFLogo"
            } else {
                platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"
                
            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
            
        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            platformImageName = "PhilipsCDiLogo"
        case 122:
            if mode == .light {
                platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"
                
            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"
                
            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"
                
            }
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 307:
            if mode == .light {
                platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"
                
            }
            
        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
                platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"
                
            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"
                
            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"
                
            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"
                
            }
            
        case 7:
            platformImageName = "SonyPlaystationLogo"
        case 80:
            if mode == .light {
                platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"
                
            }
        case 84:
            platformImageName = "SegaSG1000Logo"
            
            
            
        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"
                
            }
            
        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"
                
            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"
            
        case 0:
            
            if mode == .light {
                //Light Mode
                platformImageName = "allPlatformLogo"
            } else {
                //Dark Mode
                platformImageName = "allPlatformLogoInverse"
                
            }
            
        default:
            print("Invalid Platform")
            
            
        }
        return platformImageName
        
    }
    
    
}
