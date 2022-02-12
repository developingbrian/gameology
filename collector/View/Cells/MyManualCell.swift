//
//  MyManualCell.swift
//  collector
//
//  Created by Brian on 5/20/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class MyManualCell: UICollectionViewCell {
    static let cellIdentifier = "myManualCell"
    
    let container = UIView()
    let imageView = UIImageView()
    let deleteButton = UIButton()
    
    var photo : Photos? {
        didSet {
            self.configureCell()
        }
    }
    
    
}


extension MyManualCell {
    
    func configureCell() {
        
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .tertiarySystemBackground
        container.backgroundColor = .tertiarySystemBackground
        container.clipsToBounds = true
        container.layer.cornerRadius = 4
        container.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        container.layer.shadowOpacity = 0.7
        container.layer.shadowRadius = 2
        container.layer.masksToBounds = false
        if traitCollection.userInterfaceStyle == .light {
            
            
            container.layer.shadowColor = UIColor.darkGray.cgColor
        } else {
            
            container.layer.shadowColor = UIColor.gray.cgColor
        }
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = photo?.photo {
            let myGameImage = UIImage(data: image)
            imageView.image = myGameImage
            
            
            
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        container.addSubview(imageView)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.tintColor = .white
        deleteButton.isUserInteractionEnabled = true
        deleteButton.isEnabled = true
        deleteButton.backgroundColor = .clear
        
        imageView.addSubview(deleteButton)
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
            
            
            
        ])
        
    }
}
