//
//  ScreenshotTableViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ScreenshotTableViewCell: UITableViewCell {
    @IBOutlet weak var screenshotCardView: UIView!
    
    @IBOutlet weak var screenshotBackgroundView: UIView!
    
    var images: Image?
    var game : GameObject? {
        didSet {
            self.configureCell()
        }
    }
   weak var parent : UIViewController?
    
    @IBOutlet weak var screenshotCollectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        screenshotCollectionView.delegate = self
        screenshotCollectionView.dataSource = self
        screenshotCardView.layer.cornerRadius = 20
        setAppearance()
        
        
    }

    
    func setAppearance() {
//        print("setting appearance")
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")

        
        if appearanceSelection == 0 {
           
            overrideUserInterfaceStyle = .unspecified
        } else if appearanceSelection == 1 {
            overrideUserInterfaceStyle = .light
           


        } else {
            overrideUserInterfaceStyle = .dark
           

        }
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            screenshotBackgroundView.backgroundColor = lightGray
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            screenshotBackgroundView.backgroundColor = darkGray
           

        }
    }
    
}

extension ScreenshotTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (game?.screenshots?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = screenshotCollectionView.dequeueReusableCell(withReuseIdentifier: "screenshotCollection", for: indexPath) as? ScreenshotCollectionViewCell
        
        cell?.indexPath = indexPath
        cell?.game = game

        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let screenshotURL = (game?.screenshots?[indexPath.item].imageID)! + ".jpg"
//        print("testurl \(imageURL)")
        var imageURLs : [String] = []
        if let screenshots = game?.screenshots {
        for screenshot in screenshots {
            
            let screenshotURL = screenshot.imageID! + ".jpg"
            let imageURL = baseURL.screenshotLarge.rawValue + screenshotURL
            imageURLs.append(imageURL)
            
        }
            
        }
        
        
        
        let pageVC = (parent?.storyboard?.instantiateViewController(identifier: "imagePageVC"))! as ImagePageVC
        
        pageVC.imageURLs = imageURLs
        pageVC.selectedIndex = indexPath.item
        parent?.navigationController?.pushViewController(pageVC, animated: true)
        
        
//
//        let vc = (parent?.storyboard?.instantiateViewController(identifier: "fullImage"))! as FullImageVC
//
//        vc.imageURL = imageURL
//        parent?.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    
    
    
}
