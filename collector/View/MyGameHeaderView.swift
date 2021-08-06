//
//  MyGameHeaderView.swift
//  collector
//
//  Created by Brian on 5/22/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class MyGameHeaderView: UICollectionReusableView {
        
    static let reuseIdentifier = "header-reuse-identifier"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}

extension MyGameHeaderView {
    func configure() {
        
//        if traitCollection.userInterfaceStyle == .light {
//            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//            backgroundColor = lightGray
//
//        } else if traitCollection.userInterfaceStyle == .dark {
//            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
//           backgroundColor = darkGray
//
//
//        }
        backgroundColor = .clear
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        
        ])

    }
    
}
