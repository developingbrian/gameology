//
//  ComingSoonCell.swift
//  collector
//
//  Created by Brian on 5/6/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class ComingSoonCell: UICollectionViewCell {
    
    
    static let cellIdentifier = "comingSoonCell"
    
    let container = UIView()
    let shadowView = UIImageView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let platformBanner = UIImageView()
    var boxartImage: UIImage?
    
    var game: GameObject? {
        didSet {
            
            self.configureCell()
        }
        
    }
    
    
    override func prepareForReuse() {
        imageView.image = nil
        shadowView.image = nil
    }
   
}



extension ComingSoonCell {
    func configureCell() {
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        contentView.addSubview(imageView)
        contentView.addSubview(shadowView)
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
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.contentMode = .scaleAspectFill
        shadowView.isUserInteractionEnabled = true
        shadowView.layer.cornerRadius = 10
        
        container.addSubview(shadowView)
        

        imageView.translatesAutoresizingMaskIntoConstraints = false

        if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.coverSmall.rawValue + boxartURL
            let url = URL(string: gameURL)!
            imageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                self.boxartImage = self.imageView.image
                
                let blurredImage = self.boxartImage?.getImageWithBlur(blurAmount: 6)
                
                self.shadowView.image = blurredImage

            }
        } else {
            self.imageView.image = UIImage(named: "noBoxart")
            self.boxartImage = self.imageView.image
            let blurredImage = self.boxartImage?.getImageWithBlur(blurAmount: 20)
            self.shadowView.image = blurredImage
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.75
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.gray.cgColor

        shadowView.addSubview(imageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = game?.title
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()

        container.addSubview(titleLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = game?.releaseDate
        dateLabel.backgroundColor = .clear
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.numberOfLines = 0
        dateLabel.sizeToFit()

        container.addSubview(dateLabel)

        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            shadowView.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),

            shadowView.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            shadowView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            shadowView.widthAnchor.constraint(equalTo: shadowView.heightAnchor, multiplier: (103/137)),
            
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -6),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -6),
            

            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            dateLabel.heightAnchor.constraint(equalToConstant: 12)

        ])
        


        dateLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        dateLabel.setContentCompressionResistancePriority(.init(rawValue: 751), for: .vertical)
        
        
        
    }
    
    
}
