//
//  State.swift
//  collector
//
//  Created by Brian on 3/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation

enum State {
    case ready // ready to request
    case reloading
    case loadNext
    case endOfContent
}
