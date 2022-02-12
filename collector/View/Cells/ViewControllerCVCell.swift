//
//  ViewControllerCVCell.swift
//  gameology
//
//  Created by Brian on 1/11/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit

class ViewControllerCVCell: UICollectionViewCell {
    
    static let cellIdentifier = "CVCell"
    var backgroundCell = RoundedShadowView()
    var coverImage = UIImageView()
    var angledView = AngleView()
    var button = UIButton()
    var titleLbl = UILabel()
    var titleLblShadowView = UIView()
    var developerLbl = UILabel()
    var horizontalStack = UIStackView()
    var genreStack = UIStackView()
    var ageRatingStack = UIStackView()
    var totalRatingStack = UIStackView()
    var genreHeadingLbl = UILabel()
    var genreImage = UIImageView()
    var genreTypeLbl = UILabel()
    var ageHeadingLbl = UILabel()
    var ageImage = UIImageView()
    var totalRatingHeadingLbl = UILabel()
    var totalRatingLbl = UILabel()
    var platformFlagImage = UIImageView()
    var showPlatformFlag = false
    var persistenceManager = PersistenceManager.shared
    var altLayout = true
    var game : GameObject? {
        
        didSet {
            configureCell()
        }
        
    }
    

    func configureCell() {
        self.contentView.layer.cornerRadius = 8
        
        configureSubviews()
        configureBoxart()
        configureTitleLabel()
        configureDeveloperLabel()
        setAgeRating()
        configureGenre()
        configureTotalRating()
        configureButton()
        setPlatformFlag()

    }
    
    func configureSubviews() {
        
        if altLayout {
        let width = contentView.layer.frame.width
        let height = contentView.layer.frame.height / 1.37
        
        contentView.addSubview(backgroundCell)
      
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
        backgroundCell.layer.cornerRadius = 8
        backgroundCell.clipsToBounds = true
        backgroundCell.addSubview(coverImage)
        backgroundCell.addSubview(developerLbl)
        backgroundCell.addSubview(horizontalStack)
        backgroundCell.backgroundColor = .tertiarySystemBackground
   
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.isUserInteractionEnabled = true
        coverImage.layer.cornerRadius = 8
        coverImage.clipsToBounds = true
            
        if altLayout {
            coverImage.addSubview(angledView)
        }
        coverImage.backgroundColor = .tertiarySystemBackground
        
        if altLayout {
            angledView.translatesAutoresizingMaskIntoConstraints = false
            angledView.addSubview(titleLblShadowView)
            angledView.addSubview(button)
            angledView.backgroundColor = .clear
            angledView.fillColor = .tertiarySystemBackground
            angledView.isUserInteractionEnabled = true
        }
            
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        
        developerLbl.translatesAutoresizingMaskIntoConstraints = false
        developerLbl.textAlignment = .center
        developerLbl.font = UIFont.systemFont(ofSize: 9, weight: .light)
        developerLbl.clipsToBounds = false
        
        titleLblShadowView.translatesAutoresizingMaskIntoConstraints = false
        titleLblShadowView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.backgroundColor = .clear
        titleLbl.textColor = .white
        titleLbl.font = .systemFont(ofSize: 11, weight: .heavy)
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.clipsToBounds = true
        horizontalStack.layer .cornerRadius = 8
        horizontalStack.backgroundColor = .red
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 1
        horizontalStack.backgroundColor = .gray
        horizontalStack.addArrangedSubview(genreStack)
        horizontalStack.addArrangedSubview(ageRatingStack)
        horizontalStack.addArrangedSubview(totalRatingStack)
        
        genreStack.translatesAutoresizingMaskIntoConstraints = false
        genreStack.addArrangedSubview(genreHeadingLbl)
        genreStack.addArrangedSubview(genreImage)
        genreStack.addArrangedSubview(genreTypeLbl)
        genreStack.backgroundColor = .tertiarySystemBackground
        genreStack.axis = .vertical
        genreStack.alignment = .fill
        genreStack.spacing = 0
        genreStack.distribution = .fillEqually
            
        genreHeadingLbl.text = "Genre"
        genreHeadingLbl.font = .systemFont(ofSize: 8)
        genreHeadingLbl.translatesAutoresizingMaskIntoConstraints = false
        genreHeadingLbl.textAlignment = .center
            
        genreImage.contentMode = .scaleAspectFit
        genreImage.translatesAutoresizingMaskIntoConstraints = false
            
        genreTypeLbl.font = .systemFont(ofSize: 7, weight: .semibold)
        genreTypeLbl.translatesAutoresizingMaskIntoConstraints = false
        genreTypeLbl.textAlignment = .center
            
        ageRatingStack.translatesAutoresizingMaskIntoConstraints = false
        ageRatingStack.axis = .vertical
        ageRatingStack.distribution = .fill
        ageRatingStack.alignment = .fill
        ageRatingStack.spacing = 2
        ageRatingStack.contentMode = .scaleToFill
        ageRatingStack.backgroundColor = .tertiarySystemBackground
        ageRatingStack.addArrangedSubview(ageHeadingLbl)
        ageRatingStack.addArrangedSubview(ageImage)
            
        ageHeadingLbl.text = "Age Rating"
        ageHeadingLbl.font = .systemFont(ofSize: 8)
        ageHeadingLbl.textAlignment = .center
        ageHeadingLbl.translatesAutoresizingMaskIntoConstraints = false
            
        ageImage.translatesAutoresizingMaskIntoConstraints = false
        ageImage.contentMode = .scaleAspectFit
        
        totalRatingStack.axis = .vertical
        totalRatingStack.alignment = .fill
        totalRatingStack.distribution = .fill
        totalRatingStack.spacing = 0
        totalRatingStack.translatesAutoresizingMaskIntoConstraints = false
        totalRatingStack.addArrangedSubview(totalRatingHeadingLbl)
        totalRatingStack.addArrangedSubview(totalRatingLbl)
        totalRatingStack.backgroundColor = .tertiarySystemBackground
            
        totalRatingHeadingLbl.text = "Total Rating"
        totalRatingHeadingLbl.font = .systemFont(ofSize: 8)
        totalRatingHeadingLbl.textAlignment = .center
        totalRatingHeadingLbl.translatesAutoresizingMaskIntoConstraints = false
            
        totalRatingLbl.translatesAutoresizingMaskIntoConstraints = false
        totalRatingLbl.font = .systemFont(ofSize: 9)
        totalRatingLbl.textAlignment = .center
        
        if showPlatformFlag == false {
            NSLayoutConstraint.activate([
        
                backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                
                coverImage.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
                coverImage.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                coverImage.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                
                angledView.bottomAnchor.constraint(equalTo: coverImage.bottomAnchor),
                angledView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                angledView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                angledView.heightAnchor.constraint(equalToConstant: 75),
                
                button.heightAnchor.constraint(equalToConstant: 28),
                button.widthAnchor.constraint(equalToConstant: 46),
                button.trailingAnchor.constraint(equalTo: angledView.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: titleLblShadowView.topAnchor, constant: -5),
                
                titleLblShadowView.leadingAnchor.constraint(equalTo: angledView.leadingAnchor),
                titleLblShadowView.heightAnchor.constraint(equalToConstant: 26.5),
                titleLblShadowView.bottomAnchor.constraint(equalTo: angledView.bottomAnchor, constant: -4.5),
                titleLblShadowView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -23),
                
                titleLbl.topAnchor.constraint(equalTo: titleLblShadowView.topAnchor),
                titleLbl.leadingAnchor.constraint(equalTo: titleLblShadowView.leadingAnchor),
                titleLbl.trailingAnchor.constraint(equalTo: titleLblShadowView.trailingAnchor),
                titleLbl.bottomAnchor.constraint(equalTo: titleLblShadowView.bottomAnchor),
              
                developerLbl.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
                developerLbl.heightAnchor.constraint(equalToConstant: 11),
                developerLbl.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                developerLbl.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                
                horizontalStack.topAnchor.constraint(equalTo: developerLbl.bottomAnchor),
                horizontalStack.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                horizontalStack.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                horizontalStack.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor),
                horizontalStack.heightAnchor.constraint(equalToConstant: 61.5),
                
                genreHeadingLbl.bottomAnchor.constraint(equalTo: ageHeadingLbl.bottomAnchor),
                genreHeadingLbl.bottomAnchor.constraint(equalTo: totalRatingHeadingLbl.bottomAnchor),
                
                totalRatingLbl.centerXAnchor.constraint(equalTo: totalRatingStack.centerXAnchor)
            
        ])
        } else {
            platformFlagImage.translatesAutoresizingMaskIntoConstraints = false
            backgroundCell.addSubview(platformFlagImage)
            
            NSLayoutConstraint.activate([
            
                backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                
                coverImage.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
                coverImage.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                coverImage.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                
                angledView.bottomAnchor.constraint(equalTo: coverImage.bottomAnchor),
                angledView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                angledView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                angledView.heightAnchor.constraint(equalToConstant: 75),
                
                button.heightAnchor.constraint(equalToConstant: 28),
                button.widthAnchor.constraint(equalToConstant: 46),
                button.trailingAnchor.constraint(equalTo: angledView.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: titleLblShadowView.topAnchor, constant: -5),
                
                titleLblShadowView.leadingAnchor.constraint(equalTo: angledView.leadingAnchor),
                titleLblShadowView.heightAnchor.constraint(equalToConstant: 26.5),
                titleLblShadowView.bottomAnchor.constraint(equalTo: angledView.bottomAnchor, constant: -4.5),
                titleLblShadowView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -23),
                
                titleLbl.topAnchor.constraint(equalTo: titleLblShadowView.topAnchor),
                titleLbl.leadingAnchor.constraint(equalTo: titleLblShadowView.leadingAnchor),
                titleLbl.trailingAnchor.constraint(equalTo: titleLblShadowView.trailingAnchor),
                titleLbl.bottomAnchor.constraint(equalTo: titleLblShadowView.bottomAnchor),
              
                developerLbl.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
                developerLbl.heightAnchor.constraint(equalToConstant: 11),
                developerLbl.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                developerLbl.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                
                horizontalStack.topAnchor.constraint(equalTo: developerLbl.bottomAnchor),
                horizontalStack.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                horizontalStack.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                horizontalStack.bottomAnchor.constraint(equalTo: platformFlagImage.topAnchor),
                horizontalStack.heightAnchor.constraint(equalToConstant: 61.5),
                
                genreHeadingLbl.bottomAnchor.constraint(equalTo: ageHeadingLbl.bottomAnchor),
                genreHeadingLbl.bottomAnchor.constraint(equalTo: totalRatingHeadingLbl.bottomAnchor),
                
                totalRatingLbl.centerXAnchor.constraint(equalTo: totalRatingStack.centerXAnchor),
                
                platformFlagImage.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor),
                platformFlagImage.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                platformFlagImage.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor),
                platformFlagImage.heightAnchor.constraint(equalToConstant: 25)
            ])
            
            
            
            
            
        }
            
            
            
            
        }
    }
    
    func setPlatformFlag() {
        guard let platformID = game?.platformID else { return }
        let lightImage = game?.fetchPlatformFlag(platformID: platformID, uiMode: .light)
        let darkImage = game?.fetchPlatformFlag(platformID: platformID, uiMode: .dark)
        
        platformFlagImage.image = traitCollection.userInterfaceStyle == .dark ? darkImage : lightImage
        
    }
    
    
    func configureButton() {
        
        if altLayout {
        guard let gameID = game?.id else { return }
        guard let platformID = game?.platformID else { return }
        let ownedStatus = persistenceManager.isGameInLibrary(gameID: gameID)
        let buttonIcon = game?.fetchLibraryIcon(platformID: platformID, isOwned: ownedStatus)
        button.isUserInteractionEnabled = true
        button.tintColor = UIColor.secondaryLabel
        button.setImage(buttonIcon, for: .normal)
        button.addTarget(self, action: #selector(didPressLibraryButton), for: .touchUpInside)
        } else {
            
            guard let gameID = game?.id else { return }
            guard let platformID = game?.platformID else { return }
            let ownedStatus = persistenceManager.isGameInLibrary(gameID: gameID)
            let buttonIcon = game?.fetchLibraryIcon(platformID: platformID, isOwned: ownedStatus)
            let colors = [UIColor(named: "color4")!.cgColor, UIColor(named: "color5")!.cgColor]

            button.setImage(buttonIcon, for: .normal)
            button.applyGradientRounded(layoutIfNeeded: true, colors: colors)
            button.layer.shadowRadius = 3
            button.layer.shadowOpacity = 0.8
            button.layer.shadowColor = UIColor.secondaryLabel.cgColor
            button.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            button.layer.masksToBounds = false
            button.clipsToBounds = false
            button.addTarget(self, action: #selector(didPressLibraryButton), for: .touchUpInside)
            
            
            
        }
        
        
    }
    
    func configureBoxart() {

        if altLayout {
        guard let imageURLString = game?.boxartFrontImage else { return }
        let urlString = baseURL.coverLarge.rawValue + imageURLString
        let url = URL(string: urlString)!
        
        coverImage.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        coverImage.setImageAnimated(imageUrl: url, placeholderImage: nil) {

        }
        } else {
            
            guard let urlString = game?.boxartFrontImage else { return }

            let url = URL(string: baseURL.coverLarge.rawValue  + urlString)!
            coverImage.layer.masksToBounds = false
            coverImage.clipsToBounds = false
            coverImage.layer.shadowOffset = CGSize(width: 3, height: 3)
            coverImage.layer.cornerRadius = 2
            coverImage.layer.shadowRadius = 3
            coverImage.layer.shadowColor = UIColor.secondaryLabel.cgColor
            coverImage.layer.shadowOpacity = 0.8
            coverImage.setImageAnimated(imageUrl: url, placeholderImage: nil) {
            }

            
            
        }
        
        

    }
    
    func configureTitleLabel() {
        
        if altLayout {
        
        guard let title = game?.title else { return }
        titleLbl.text = title
        titleLbl.translatesAutoresizingMaskIntoConstraints = false

        guard let lightBlue = UIColor(named: "color4")?.cgColor else { return }
        guard let blue = UIColor(named: "color5")?.cgColor else { return }

        titleLblShadowView.layer.shadowRadius = 1
        titleLblShadowView.layer.shadowColor = UIColor(named: "color4")?.cgColor
        titleLblShadowView.layer.shadowOpacity = 0.5
        titleLblShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleLblShadowView.applyRoundedGradient(layoutIfNeeded: true, colors: [lightBlue, blue])
        } else {
            
            totalRatingHeadingLbl.text = "Total Rating"
            totalRatingHeadingLbl.textAlignment = .center
            totalRatingHeadingLbl.numberOfLines = 0
            totalRatingHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
            totalRatingLbl.textAlignment = .center
            totalRatingLbl.font = .systemFont(ofSize: 12)
            guard let rating = game?.rating else { totalRatingLbl.text = "--/100"; return }
            totalRatingLbl.text = String(rating) + "/100"
            
            
        }
    }
    
    func configureDeveloperLabel() {
        if altLayout {
        guard let developerName = game?.developer else { return }
        developerLbl.text = developerName
        } else {
            
            self.developerLbl.font = .systemFont(ofSize: 14)
            self.developerLbl.numberOfLines = 0
            self.developerLbl.adjustsFontSizeToFitWidth = true
            self.developerLbl.minimumScaleFactor = 0.8
            self.titleLbl.lineBreakMode = .byTruncatingTail
            guard let developerTitle = game?.developer else { self.developerLbl.text = "" ; return }
            self.developerLbl.text = developerTitle
            
            
            
        }
        
    }
    
    func configureGenre() {
        if altLayout {
        guard let genres = game?.genre else { return }
        if !genres.isEmpty {
    
            let genre = genres[0]
            genreTypeLbl.text = genre.name
            genreImage.tintColor = UIColor.label
            guard let genreID = genre.id else { return }
            guard let genreImageIcon = game?.fetchGenreImage(for: genreID) else { print("invalid image"); return }
            genreImage.image = genreImageIcon
            
            
        }
            
        } else {
            
            
            genreHeadingLbl.text = "Genre"
            genreHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
            genreHeadingLbl.textAlignment = .center
            if let genreString = game?.genre?[0].name {
                genreTypeLbl.text = genreString

            } else {
                genreTypeLbl.text = ""
                
            }
            genreTypeLbl.font = .systemFont(ofSize: 12)
            genreTypeLbl.numberOfLines = 0
            genreTypeLbl.adjustsFontSizeToFitWidth = true
            genreTypeLbl.textAlignment = .center

            if let genreNum = game?.genre?[0].id {
                
                let genreImageFetched = game?.fetchGenreImage(for: genreNum)
                guard let image = genreImageFetched else { print("genre image failure"); return }
                genreImage.backgroundColor = .tertiarySystemBackground
                genreImage.contentMode = .scaleAspectFit
                genreImage.tintColor = .label
                genreImage.image = image
            }
            
        }
        
    }

        
                
    
    
    func setAgeRating() {
      
        if altLayout {
        guard let ageRating = game?.rating else { return }
        

        let ageRatingIcon = game?.fetchAgeRatingIcon(for: ageRating)
        ageImage.image = ageRatingIcon
        
        } else {
            ageHeadingLbl.text = "Age Rating"
            ageHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
            ageHeadingLbl.textAlignment = .center
            guard let rating = game?.rating else { return }
            guard let ageImageIcon = game?.fetchAgeRatingIcon(for: rating) else { return }
            ageImage.contentMode = .scaleAspectFit
            ageImage.image = ageImageIcon
        }
    }
    
    
    func configureTotalRating() {
        if altLayout {
        guard let rating = game?.totalRating else { totalRatingLbl.text = "--/100"; return }
        
        totalRatingLbl.text = String(rating) + "/100"
            
        } else {
            totalRatingHeadingLbl.text = "Total Rating"
            totalRatingHeadingLbl.textAlignment = .center
            totalRatingHeadingLbl.numberOfLines = 0
            totalRatingHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
            totalRatingLbl.textAlignment = .center
            totalRatingLbl.font = .systemFont(ofSize: 12)
            guard let rating = game?.totalRating else { totalRatingLbl.text = "--/100"; return }
            totalRatingLbl.text = String(rating) + "/100"
            
            
        }
        
    }
    
    @objc func didPressLibraryButton() {
        guard let gameID = game?.id else { return }

        switch persistenceManager.isGameInLibrary(gameID: gameID) {
            
        case true:
            promptDeleteConfirmation()
        
        case false:
            addGameToLibrary()

        }
        
        
    }
    
    func addGameToLibrary() {
        guard let gameObject = game else { return }
        guard let platformID = game?.platformID else { return }
        
        let imageIcon = game?.fetchLibraryIcon(platformID: platformID, isOwned: true)
        button.setImage(imageIcon, for: .normal)
        
        persistenceManager.saveGameToLibrary(game: gameObject)
        
    }
    
    func removeGameFromLibrary() {
        guard let platformID = game?.platformID else { return }
        guard let gameID = game?.id else { return }
        let platformIsInLibrary = self.persistenceManager.isPlatformInLibrary(platformID: platformID)
        
        if platformIsInLibrary {
                    
            self.persistenceManager.removeGameFromLibrary(gameID: gameID)
          
        }
        
        
    }
    
    
    func promptDeleteConfirmation() {
        guard let platformID = game?.platformID else { return }
        let parentVC = self.parentViewController
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
        let deleteAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] action in
            
            let imageIcon = self?.game?.fetchLibraryIcon(platformID: platformID, isOwned: false)
            self?.button.setImage(imageIcon, for: .normal)
            self?.removeGameFromLibrary()

        
        }
        
        let alert = UIAlertController(title: "Are you sure you wish to delete this game?", message: "Deleting a game is permanent.  Any user saved data and information will not be able to be restored.", preferredStyle: .alert)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
    
        parentVC?.present(alert, animated: true, completion: nil)
        
    }
    
}
