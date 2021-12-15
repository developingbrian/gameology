//
//  VerticalAlignedLabel.swift
//  collector
//
//  Created by Brian on 11/14/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class VerticalAlignedLabel: UILabel {

    override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            ()
        }
        
        super.drawText(in: newRect)
    }

}
