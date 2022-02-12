//
//  TopTwentyCell.swift
//  collector
//
//  Created by Brian on 5/7/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class TopTwentyCell: UICollectionViewCell {
    
    static let cellIdentifier = "topTwentyCell"
    
    let container = UIView()
    let imageView = UIImageView()
    let shadowView = UIImageView()
    let titleLabel = UILabel()
    let genreLabel = UILabel()
    let maxRatingLabel = UILabel()
    let headingLabel = UILabel()
    
    
    
    var game : GameObject? {
        didSet {
            self.configureCell()
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        shadowView.image = nil
    }
    
    
}


extension TopTwentyCell {
    
    func configureCell() {
        titleLabel.backgroundColor = .tertiarySystemBackground
        genreLabel.backgroundColor = .tertiarySystemBackground
        container.backgroundColor = .tertiarySystemBackground
        maxRatingLabel.backgroundColor = .clear
        headingLabel.backgroundColor = .clear
        
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        contentView.addSubview(shadowView)
        contentView.addSubview(imageView)
        container.layer.cornerRadius = 4
        container.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        container.layer.shadowOpacity = 0.7
        container.layer.shadowRadius = 2
        
        if traitCollection.userInterfaceStyle == .light {
            
            
            container.layer.shadowColor = UIColor.darkGray.cgColor
        } else {
            
            container.layer.shadowColor = UIColor.gray.cgColor
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.contentMode = .scaleAspectFill
        shadowView.layer.cornerRadius = 10
        if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.coverSmall.rawValue + boxartURL
            let url = URL(string: gameURL)!
            imageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                let blurredImage = self.imageView.image?.getImageWithBlur(blurAmount: 10)
                self.shadowView.image = blurredImage
            }
        } else {
            imageView.image = UIImage(named: "noBoxart")
            let blurredImage = self.imageView.image?.getImageWithBlur(blurAmount: 10)
            self.shadowView.image = blurredImage
        }
        
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOpacity = 0.75
        imageView.layer.masksToBounds = false
        
        imageView.clipsToBounds = false
        
        container.addSubview(shadowView)
        shadowView.addSubview(imageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = game?.title
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        container.addSubview(titleLabel)
        genreLabel.textAlignment = .right
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let totalRating = game?.totalRating {
            genreLabel.text = "\(totalRating)"
        }
        genreLabel.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        genreLabel.adjustsFontForContentSizeCategory = true
        genreLabel.numberOfLines = 0
        genreLabel.sizeToFit()
        
        maxRatingLabel.textAlignment = .left
        maxRatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        maxRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        maxRatingLabel.text = "/100"
        maxRatingLabel.textColor = .systemGray
        maxRatingLabel.sizeToFit()
        
        headingLabel.textAlignment = .right
        headingLabel.textColor = .systemGray
        headingLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.text = "IGDB Rating"
        headingLabel.adjustsFontForContentSizeCategory = true
        headingLabel.sizeToFit()
        
        container.addSubview(genreLabel)
        container.addSubview(maxRatingLabel)
        container.addSubview(headingLabel)
        
        
        NSLayoutConstraint.activate( [
            
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            shadowView.widthAnchor.constraint(equalToConstant: 70),
            
            
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -1),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -1),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: container.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),
            
            
            
            genreLabel.widthAnchor.constraint(equalToConstant: 50),
            genreLabel.bottomAnchor.constraint(equalTo: headingLabel.topAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: maxRatingLabel.leadingAnchor),
            genreLabel.topAnchor.constraint(equalTo: container.centerYAnchor),
            
            maxRatingLabel.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor),
            maxRatingLabel.heightAnchor.constraint(equalToConstant: 12),
            maxRatingLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            maxRatingLabel.bottomAnchor.constraint(equalTo: headingLabel.topAnchor, constant: -4),
            
            headingLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            headingLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
            headingLabel.heightAnchor.constraint(equalToConstant: 15),
            headingLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -2)
            
        ] )
    }
    
    
}
