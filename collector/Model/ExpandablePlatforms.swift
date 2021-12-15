//
//  ExpandablePlatforms.swift
//  collector
//
//  Created by Brian on 2/12/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import Foundation


struct SectionData {
    
    var isOpen : Bool
    var game : [WishList]
    var platformName : String
    
}


struct AdvancedSearchSection {
    
    var sectionDataSource : [String]
    var sectionIndex : Int
    
}
