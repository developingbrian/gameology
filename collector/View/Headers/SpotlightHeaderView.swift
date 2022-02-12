//
//  SpotlightHeaderView.swift
//  collector
//
//  Created by Brian on 5/8/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class SpotlightHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "header-reuse-identifier"
    let screen = UIScreen.main.bounds
      let label = UILabel()
        let platformLabel = UILabel()
        let button = UIButton()

      override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
      }

      required init?(coder: NSCoder) {
        fatalError()
      }
    }

    extension SpotlightHeaderView {
      func configure() {


        addSubview(label)
        addSubview(platformLabel)
        addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
          
        platformLabel.translatesAutoresizingMaskIntoConstraints = false
        platformLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
          
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintColor = button.currentTitleColor
        button.setImage(UIImage(systemName: "shuffle")
                        , for: .normal)
        button.setInsets(forContentPadding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0), imageTitlePadding: 5)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 2
        button.layer.masksToBounds = false
                    if traitCollection.userInterfaceStyle == .light {
                  
        
                        button.layer.shadowColor = UIColor.darkGray.cgColor
                    } else {
              
                        button.layer.shadowColor = UIColor.gray.cgColor
                    }

          


        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
          label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
          label.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            label.bottomAnchor.constraint(equalTo: platformLabel.topAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            platformLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            platformLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            button.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -inset),
         
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            button.widthAnchor.constraint(equalToConstant: 101.66666666666667),
            button.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        

      }
        
        func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
           return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
       }
    }
    
    
    

