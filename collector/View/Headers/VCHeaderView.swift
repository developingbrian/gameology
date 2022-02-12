//
//  VCHeaderView.swift
//  gameology
//
//  Created by Brian on 1/17/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit

class VCHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "header-reuse-identifier"
    let label = UILabel()
    var indexSection : String? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
    
    fatalError()
    }
    
}


extension VCHeaderView {
    
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.text = indexSection
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        
        ])
    }
    
    
    
}
