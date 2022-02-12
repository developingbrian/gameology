//
//  ReverseAngleView.swift
//  gameology
//
//  Created by Brian on 1/10/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit


@IBDesignable

public class ReverseAngleView: UIView {

//    @IBInspectable var cornerRadius: CGFloat = 0 {
//       didSet {
//           layer.cornerRadius = cornerRadius
//           layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//           layer.masksToBounds = cornerRadius > 0
//       }
//    }
    
    @IBInspectable public var fillColor: UIColor = .blue { didSet { setNeedsLayout() } }
    

    var points: [CGPoint] = [
        CGPoint(x: 1, y: 0.1),
        CGPoint(x: 0.9, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 1, y: 1)
    ] { didSet { setNeedsLayout() } }

    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()

    override public func layoutSubviews() {
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = fillColor.cgColor
        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }

        let path = UIBezierPath()
        let frame = CGRect(x: 0, y: 0, width: 110, height: 26)
        
//        path.move(to: CGPoint(x: frame.minX + 133.01, y: frame.minY + 23.44))
//        path.addCurve(to: CGPoint(x: frame.minX + 116.71, y: frame.minY + 13.74), controlPoint1: CGPoint(x: frame.minX + 128.53, y: frame.minY + 14.43), controlPoint2: CGPoint(x: frame.minX + 122.41, y: frame.minY + 12.78))
//        path.addCurve(to: CGPoint(x: frame.minX + 107.08, y: frame.minY + 17.38), controlPoint1: CGPoint(x: frame.minX + 111.91, y: frame.minY + 14.54), controlPoint2: CGPoint(x: frame.minX + 107.08, y: frame.minY + 17.38))
//        path.addLine(to: CGPoint(x: frame.minX + 1.5, y: frame.minY + 65.5))
//        path.addLine(to: CGPoint(x: frame.minX + 134.5, y: frame.minY + 65.5))
//        path.addLine(to: CGPoint(x: frame.minX + 134.5, y: frame.minY + 37.19))
//        path.addCurve(to: CGPoint(x: frame.minX + 133.01, y: frame.minY + 23.44), controlPoint1: CGPoint(x: frame.minX + 134.5, y: frame.minY + 37.19), controlPoint2: CGPoint(x: frame.minX + 134.66, y: frame.minY + 26.76))


        path.move(to: CGPoint(x: frame.minX + 1.73, y: frame.minY + 5.28))
        path.addCurve(to: CGPoint(x: frame.minX + 15.21, y: frame.minY + 0.61), controlPoint1: CGPoint(x: frame.minX + 5.43, y: frame.minY + 0.95), controlPoint2: CGPoint(x: frame.minX + 10.5, y: frame.minY + 0.16))
        path.addCurve(to: CGPoint(x: frame.minX + 23.18, y: frame.minY + 2.36), controlPoint1: CGPoint(x: frame.minX + 19.18, y: frame.minY + 1), controlPoint2: CGPoint(x: frame.minX + 23.18, y: frame.minY + 2.36))
        path.addLine(to: CGPoint(x: 110.5, y: 25.5))
        path.addLine(to: CGPoint(x: frame.minX + 0.5, y: frame.minY + 25.5))
        path.addLine(to: CGPoint(x: frame.minX + 0.5, y: frame.minY + 11.89))
        path.addCurve(to: CGPoint(x: frame.minX + 1.73, y: frame.minY + 5.28), controlPoint1: CGPoint(x: frame.minX + 0.5, y: frame.minY + 11.89), controlPoint2: CGPoint(x: frame.minX + 0.37, y: frame.minY + 6.88))



        
        
//        path.move(to: convert(relativePoint: points[0]))
//
//        path.addArc(withCenter: points[1], radius: 12, startAngle: 0, endAngle: CGFloat(Float.pi/2), clockwise: true)
//        path.addLine(to: points[2])
//        path.addLine(to: points[3])
//
//        for point in points.dropFirst() {
//            path.addLine(to: convert(relativePoint: point))
//        }
        path.close()
        UIColor.white.setStroke()
        path.lineWidth = 1
        path.stroke()
        shapeLayer.path = path.cgPath
    }

    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
}
