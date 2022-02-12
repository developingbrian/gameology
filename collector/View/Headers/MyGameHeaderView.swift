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
        
        backgroundColor = .clear
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        
        ])

    }
    
}
