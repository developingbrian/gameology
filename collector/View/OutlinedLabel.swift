//
//  OutlinedLabel.swift
//  collector
//
//  Created by Brian on 6/15/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class OutlinedLabel : UILabel
{
    override func draw(_ rect: CGRect)
  {
    let shadowOffset = self.shadowOffset
    let textColor = self.textColor

    let context = UIGraphicsGetCurrentContext()
    context!.setLineWidth(1)
    context!.setLineJoin(CGLineJoin.round)

    context!.setTextDrawingMode(CGTextDrawingMode.stroke);
    self.textColor = UIColor.black
    super.drawText(in: rect)

    context!.setTextDrawingMode(CGTextDrawingMode.fill)
    self.textColor = textColor
    self.shadowOffset = CGSize(width: 0, height: 0)
    super.drawText(in: rect)

    self.shadowOffset = shadowOffset
  }
}
