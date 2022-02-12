//
//  NewReleasesCell.swift
//  collector
//
//  Created by Brian on 5/7/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class NewReleasesCell: UICollectionViewCell {
    
    static let cellIdentifier = "newReleasesCell"
    
    let container = UIView()
    let imageView = UIImageView()
    let shadowView = UIImageView()
    let titleLabel = UILabel()
    let genreLabel = UILabel()
    let titleView = UIView()
    let boxartImageView = UIImageView()
    
    
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


extension NewReleasesCell {
    
    func configureCell() {
        
        
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        contentView.addSubview(imageView)
        contentView.addSubview(shadowView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.hd.rawValue + boxartURL
            
            let url = URL(string: gameURL)!
            boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
            }
        }
        
        if let screenshotURL = game?.screenshots?[0].imageID {
            let gameURL = baseURL.screenshotMedium.rawValue + screenshotURL + ".jpg"
            
            let url = URL(string: gameURL)!
            imageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                
                let blurredImage = self.imageView.image?.getImageWithBlur(blurAmount: 4)
                self.shadowView.image = blurredImage
            }
        }
        
        else if let boxartURL = game?.boxartFrontImage {
            let gameURL = baseURL.screenshotMedium.rawValue + boxartURL
            
            let url = URL(string: gameURL)!
            imageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                
                let blurredImage = self.imageView.image?.getImageWithBlur(blurAmount: 4)
                self.shadowView.image = blurredImage
                
            }
        }
        else {
            imageView.image = UIImage(named: "arcadeBackground")
            
        }
        
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
        shadowView.contentMode = .scaleToFill
        shadowView.isUserInteractionEnabled = true
        shadowView.layer.cornerRadius = 10
        
        container.addSubview(shadowView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 2
        
        if traitCollection.userInterfaceStyle == .light {
            
            
            imageView.layer.shadowColor = UIColor.darkGray.cgColor
        } else {
            
            imageView.layer.shadowColor = UIColor.gray.cgColor
        }
        shadowView.addSubview(imageView)
        
        
        
        titleView.backgroundColor = .black
        titleView.layer.opacity = 0
        titleView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(titleView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = game?.title
        titleLabel.shadowOffset = CGSize(width: 1.25, height: 1.25)
        titleLabel.shadowColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLabel.textColor = .white
        
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        imageView.addSubview(titleLabel)
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.text = game?.releaseDate
        genreLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        genreLabel.textColor = .white
        genreLabel.adjustsFontForContentSizeCategory = true
        genreLabel.numberOfLines = 0
        genreLabel.sizeToFit()
        genreLabel.shadowColor = .black
        genreLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        imageView.addSubview(genreLabel)
        
        let height = (contentView.frame.height / 4)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            shadowView.topAnchor.constraint(equalTo: container.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -10),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),
            
            titleView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleView.heightAnchor.constraint(equalToConstant: height),
            
            genreLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: genreLabel.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: genreLabel.trailingAnchor),
            
            
        ])
        
        
    }
}
