//
//  AngleView.swift
//  gameology
//
//  Created by Brian on 1/9/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit


@IBDesignable
public class AngleView: UIView {
    
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
        shapeLayer.shadowRadius = 2
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.35
        shapeLayer.shadowOffset = CGSize(width: 0, height: -3)
        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }

        let path = UIBezierPath()
        let frame = CGRect(x: 0, y: 0, width: 150, height: 78)
        path.move(to: CGPoint(x: frame.minX + 161.68, y: frame.minY + 15.42))
        path.addCurve(to: CGPoint(x: frame.minX + 141.7, y: frame.minY + 0.86), controlPoint1: CGPoint(x: frame.minX + 156.19, y: frame.minY + 1.9), controlPoint2: CGPoint(x: frame.minX + 148.69, y: frame.minY - 0.57))
        path.addCurve(to: CGPoint(x: frame.minX + 129.9, y: frame.minY + 6.32), controlPoint1: CGPoint(x: frame.minX + 135.81, y: frame.minY + 2.06), controlPoint2: CGPoint(x: frame.minX + 129.9, y: frame.minY + 6.32))
        path.addLine(to: CGPoint(x: 0.5, y: 78.5))
        path.addLine(to: CGPoint(x: 163.49, y: 78.5))
        path.addLine(to: CGPoint(x: 163.49, y: 36.04))
        path.addCurve(to: CGPoint(x: frame.minX + 161.68, y: frame.minY + 15.42), controlPoint1: CGPoint(x: 163.49, y: 36.04), controlPoint2: CGPoint(x: frame.minX + 163.7, y: frame.minY + 20.39))
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
