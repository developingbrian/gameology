//
//  Helper.swift
//  collector
//
//  Created by Brian on 12/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit

class ButtonGradient {
    
     func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    
}
