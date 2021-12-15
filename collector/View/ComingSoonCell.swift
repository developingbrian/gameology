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
//        shadowView.backgroundColor = .red
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
        
        
//        let maskLayer = CAGradientLayer()
//        maskLayer.frame = shadowView.bounds
//        maskLayer.shadowRadius = 3
//        maskLayer.shadowPath = CGPath(roundedRect: shadowView.bounds.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
//        maskLayer.shadowOpacity = 1
//        maskLayer.shadowOffset = CGSize.zero
//        maskLayer.shadowColor = UIColor.darkGray.cgColor
//
//
//        shadowView.layer.mask = maskLayer
//        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
//        imageView.layer.masksToBounds = true
        if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.coverSmall.rawValue + boxartURL
            let url = URL(string: gameURL)!
            imageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
//                print("coming soon image loaded")
                self.boxartImage = self.imageView.image
                
                let blurredImage = self.boxartImage?.getImageWithBlur(blurAmount: 6)
                
                self.shadowView.image = blurredImage
//                print("game.boxartimage", self.game?.boxartImage)
            }
        } else {
            self.imageView.image = UIImage(named: "noBoxart")
            self.boxartImage = self.imageView.image
            let blurredImage = self.boxartImage?.getImageWithBlur(blurAmount: 20)
            self.shadowView.image = blurredImage
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowOpacity = 0.75
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.gray.cgColor

        shadowView.addSubview(imageView)
        
//        if let image = imageView.image {
//        game?.boxartImage = image
//        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = game?.title
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()

        container.addSubview(titleLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = game?.releaseDate
        dateLabel.backgroundColor = .clear
        dateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.numberOfLines = 0
        dateLabel.sizeToFit()

        container.addSubview(dateLabel)
        
//
//        platformBanner.translatesAutoresizingMaskIntoConstraints = false
//        let interfaceStyle = self.traitCollection.userInterfaceStyle
//        if let platformID = game?.platformID {
//        let platformTitle = setPlatformIcon(platformID: platformID, mode: interfaceStyle)
//            platformBanner.image = UIImage(named: platformTitle)
//        }
//        container.addSubview(platformBanner)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            shadowView.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),

            shadowView.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            shadowView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            
//            shadowView.leadingAnchor.constraint(lessThanOrEqualTo: container.leadingAnchor, constant: 0),
//            shadowView.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: 0),
            shadowView.widthAnchor.constraint(equalTo: shadowView.heightAnchor, multiplier: (103/137)),
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -6),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -6),
            
//            imageView.heightAnchor.constraint(equalTo: container.heightAnchor, constant: 50),
            
            
//            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
//            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            dateLabel.heightAnchor.constraint(equalToConstant: 10)
//            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
//            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
//            platformBanner.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
//
//            platformBanner.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            platformBanner.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -10),
//            platformBanner.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        
        
        ])
        
//        platformBanner.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
//        platformBanner.setContentCompressionResistancePriority(.init(rawValue: 751), for: .vertical)

        dateLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        dateLabel.setContentCompressionResistancePriority(.init(rawValue: 751), for: .vertical)
        
        
        
    }
    
    
}
