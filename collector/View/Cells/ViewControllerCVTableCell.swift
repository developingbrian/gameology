//
//  ViewControllerCVTableCell.swift
//  gameology
//
//  Created by Brian on 1/15/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit

class ViewControllerCVTableCell: UICollectionViewCell {
    
    static let cellIdentifier = "tableCell"
    var backgroundCell = RoundedShadowView()
    let button = UIButton()
    let coverImage = UIImageView()
    let title = UILabel()
    let developerLbl = UILabel()
    let horizontalStackView = UIStackView()
    let genreStackView = UIStackView()
    let ageStackView = UIStackView()
    let ratingStackView = UIStackView()
    let genreHeadingLbl = UILabel()
    let genreImageView = UIImageView()
    let genreNameLbl = UILabel()
    let ageHeadingLbl = UILabel()
    let ageImageView = UIImageView()
    let ratingHeadingLbl = UILabel()
    let ratingLbl = UILabel()
    var platformFlagImage = UIImageView()
//    var developerLogoImage = UIImageView()
    var showPlatformFlag = false
    var persistenceManager = PersistenceManager.shared
    var game : GameObject? {
        didSet {
            configureCell()
        }
    }
    
    
    func configureCell() {
        addSubviews()
        setButton()
        setTitle(title: game?.title)
        setCoverImage(imageURL: game?.boxartFrontImage)
        setDeveloperLabel(developer: game?.developer)
        setAgeRating(ageRating: game?.rating)
        setTotalRating(totalRating: game?.totalRating)
        guard let genres = game?.genre else { return }
        if !genres.isEmpty {
            setGenre(genre: genres[0].name, genreID: genres[0].id)
        }
        setPlatformFlag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.shadowPath =
        UIBezierPath(roundedRect: button.bounds, cornerRadius: 8).cgPath
    }

    
    func addSubviews() {
        
        contentView.addSubview(backgroundCell)
//        contentView.backgroundColor = .lightGray
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
     
//        backgroundCell.layer.cornerRadius = 8
        
        backgroundCell.backgroundColor = .tertiarySystemBackground

        backgroundCell.clipsToBounds = false
        backgroundCell.layer.masksToBounds = false
        
        horizontalStackView.spacing = 1
        horizontalStackView.backgroundColor = .separator
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        genreStackView.backgroundColor = .tertiarySystemBackground
        genreStackView.axis = .vertical
        genreStackView.alignment = .fill
        genreStackView.distribution = .fillEqually
        ageStackView.backgroundColor = .tertiarySystemBackground
        ageStackView.axis = .vertical
        ageStackView.alignment = .fill
        ageStackView.distribution = .fill
        ratingStackView.backgroundColor = .tertiarySystemBackground
        ratingStackView.axis = .vertical
        ratingStackView.alignment = .fill
        ratingStackView.distribution = .fill
        
//        developerLogoImage.backgroundColor = .tertiarySystemBackground
        
        
        
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        developerLbl.translatesAutoresizingMaskIntoConstraints = false
        genreHeadingLbl.translatesAutoresizingMaskIntoConstraints = false
        genreImageView.translatesAutoresizingMaskIntoConstraints = false
        genreNameLbl.translatesAutoresizingMaskIntoConstraints = false
        ageImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingLbl.translatesAutoresizingMaskIntoConstraints = false
        ratingHeadingLbl.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        genreStackView.translatesAutoresizingMaskIntoConstraints = false
        ageStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
//        developerLogoImage.translatesAutoresizingMaskIntoConstraints = false
                
        backgroundCell.addSubview(coverImage)
        backgroundCell.addSubview(title)
        backgroundCell.addSubview(button)
        backgroundCell.addSubview(developerLbl)
        backgroundCell.addSubview(horizontalStackView)
        
//        developerLbl.addSubview(developerLogoImage)
        
        horizontalStackView.addArrangedSubview(genreStackView)
        horizontalStackView.addArrangedSubview(ageStackView)
        horizontalStackView.addArrangedSubview(ratingStackView)

        
        genreStackView.addArrangedSubview(genreHeadingLbl)
        genreStackView.addArrangedSubview(genreImageView)
        genreStackView.addArrangedSubview(genreNameLbl)

       
        ageStackView.addArrangedSubview(ageHeadingLbl)
        ageStackView.addArrangedSubview(ageImageView)
        
        
        ratingStackView.addArrangedSubview(ratingHeadingLbl)
        ratingStackView.addArrangedSubview(ratingLbl)
        
        
        if showPlatformFlag == false {
        NSLayoutConstraint.activate([
        
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            
            coverImage.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: -29),
            coverImage.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: -12),
            coverImage.widthAnchor.constraint(equalToConstant: 116.5),
            coverImage.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -8),
            
            title.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 6),
            title.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
            title.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 2),
            
            button.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 6),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: 7),
            button.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: -7),
            
            developerLbl.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
//            developerLbl.heightAnchor.constraint(equalToConstant: 25),
            developerLbl.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            developerLbl.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            developerLbl.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor),
//            developerLogoImage.topAnchor.constraint(equalTo: developerLbl.topAnchor),
//            developerLogoImage.leadingAnchor.constraint(equalTo: developerLbl.leadingAnchor),
//            developerLogoImage.trailingAnchor.constraint(equalTo: developerLbl.trailingAnchor),
//            developerLogoImage.bottomAnchor.constraint(equalTo: developerLbl.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 6),
            horizontalStackView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -5),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 61.5),
        
            ageHeadingLbl.bottomAnchor.constraint(equalTo: genreHeadingLbl.bottomAnchor),
            ratingHeadingLbl.bottomAnchor.constraint(equalTo: genreHeadingLbl.bottomAnchor),
            ratingLbl.centerYAnchor.constraint(equalTo: ageImageView.centerYAnchor)
            
        ])
        
        } else {
            
            backgroundCell.addSubview(platformFlagImage)
            platformFlagImage.translatesAutoresizingMaskIntoConstraints = false
            platformFlagImage.contentMode = .scaleToFill
            
            NSLayoutConstraint.activate([
            
                backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34),
                backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
                backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
                
                coverImage.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: -29),
                coverImage.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: -12),
                coverImage.widthAnchor.constraint(equalToConstant: 116.5),
                coverImage.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -21),
                
                title.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 6),
                title.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
                title.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 2),
                
                button.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 6),
                button.widthAnchor.constraint(equalToConstant: 70),
                button.heightAnchor.constraint(equalToConstant: 40),
                button.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: 7),
                button.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: -7),
                
                developerLbl.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
    //            developerLbl.heightAnchor.constraint(equalToConstant: 25),
                developerLbl.leadingAnchor.constraint(equalTo: title.leadingAnchor),
                developerLbl.trailingAnchor.constraint(equalTo: button.leadingAnchor),
                developerLbl.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor),
                
//                developerLogoImage.topAnchor.constraint(equalTo: developerLbl.topAnchor),
//                developerLogoImage.leadingAnchor.constraint(equalTo: developerLbl.leadingAnchor),
//                developerLogoImage.trailingAnchor.constraint(equalTo: developerLbl.trailingAnchor),
//                developerLogoImage.bottomAnchor.constraint(equalTo: developerLbl.bottomAnchor),
                
                horizontalStackView.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 6),
                horizontalStackView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
                horizontalStackView.bottomAnchor.constraint(equalTo: platformFlagImage.topAnchor),
                horizontalStackView.heightAnchor.constraint(equalToConstant: 61.5),
            
                ageHeadingLbl.bottomAnchor.constraint(equalTo: genreHeadingLbl.bottomAnchor),
                ratingHeadingLbl.bottomAnchor.constraint(equalTo: genreHeadingLbl.bottomAnchor),
                ratingLbl.centerYAnchor.constraint(equalTo: ageImageView.centerYAnchor),
                
                platformFlagImage.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 6),
                platformFlagImage.widthAnchor.constraint(equalToConstant: 175),
//                platformFlagImage.trailingAnchor.constraint(equalTo: title.trailingAnchor),
//                platformFlagImage.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
                platformFlagImage.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -5),
                platformFlagImage.heightAnchor.constraint(equalToConstant: 25)
                
            ])
            
            
            
        }
        
    }
    
    
    func setPlatformFlag() {
        guard let platformID = game?.platformID else { return }
        let lightImage = game?.fetchPlatformFlag(platformID: platformID, uiMode: .light)
        let darkImage = game?.fetchPlatformFlag(platformID: platformID, uiMode: .dark)
        
        if traitCollection.userInterfaceStyle == .dark {
            platformFlagImage.image = darkImage
        } else {
            platformFlagImage.image = lightImage
        }
            
        
    }

    
    func setButton() {
        guard let gameID = game?.id else { return }
        guard let platformID = game?.platformID else { return }
        let ownedStatus = persistenceManager.isGameInLibrary(gameID: gameID)
        let buttonIcon = game?.fetchLibraryIcon(platformID: platformID, isOwned: ownedStatus)
        let colors = [UIColor(named: "color4")!.cgColor, UIColor(named: "color5")!.cgColor]
//        button.tintColor = .secondaryLabel
//        button.backgroundColor = .tertiarySystemBackground
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

    func setTitle(title: String?) {
        self.title.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.title.adjustsFontSizeToFitWidth = true
        self.title.minimumScaleFactor = 0.65
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byTruncatingTail
        guard let gameTitle = title else { self.title.text = ""; return }
        self.title.text = gameTitle

    }
    
    func setDeveloperLabel(developer: String?) {
        self.developerLbl.font = .systemFont(ofSize: 14)
        self.developerLbl.numberOfLines = 0
        self.developerLbl.adjustsFontSizeToFitWidth = true
        self.developerLbl.minimumScaleFactor = 0.8
        self.title.lineBreakMode = .byTruncatingTail
        guard let developerTitle = developer else { self.developerLbl.text = "" ; return }
        self.developerLbl.text = developerTitle
        
    }

    func setCoverImage(imageURL: String?) {
        guard let urlString = imageURL else { return }

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

    func setTotalRating(totalRating: Int?) {
        ratingHeadingLbl.text = "Total Rating"
        ratingHeadingLbl.textAlignment = .center
        ratingHeadingLbl.numberOfLines = 0
        ratingHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
        ratingLbl.textAlignment = .center
        ratingLbl.font = .systemFont(ofSize: 12)
        guard let rating = totalRating else { ratingLbl.text = "--/100"; return }
        ratingLbl.text = String(rating) + "/100"
       
    }
    
    func setAgeRating(ageRating: String?) {
        ageHeadingLbl.text = "Age Rating"
        ageHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
        ageHeadingLbl.textAlignment = .center
        guard let rating = ageRating else { return }
        guard let ageImage = game?.fetchAgeRatingIcon(for: rating) else { return }
        ageImageView.contentMode = .scaleAspectFit
        ageImageView.image = ageImage
            
    }
    

    func setGenre(genre: String?, genreID: Int?) {
        genreHeadingLbl.text = "Genre"
        genreHeadingLbl.font = .systemFont(ofSize: 11, weight: .medium)
        genreHeadingLbl.textAlignment = .center
        if let genreString = genre {
            genreNameLbl.text = genreString

        } else {
            genreNameLbl.text = ""
            
        }
        genreNameLbl.font = .systemFont(ofSize: 12)
        genreNameLbl.numberOfLines = 0
        genreNameLbl.adjustsFontSizeToFitWidth = true
        genreNameLbl.textAlignment = .center

        if let genreNum = genreID {
            
            let genreImage = game?.fetchGenreImage(for: genreNum)
            guard let image = genreImage else { print("genre image failure"); return }
            genreImageView.backgroundColor = .tertiarySystemBackground
            genreImageView.contentMode = .scaleAspectFit
            genreImageView.tintColor = .label
            genreImageView.image = image
        }
        
    }
    

    
}
