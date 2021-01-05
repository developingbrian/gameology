//
//  ScreenshotTableViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ScreenshotTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var screenshotCardView: UIView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images?.screenshotArray!.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = screenshotCollectionView.dequeueReusableCell(withReuseIdentifier: "screenshotCollection", for: indexPath) as? ScreenshotCollectionViewCell
        
        let imageURLString = (images?.screenshotArray?[indexPath.row])!
        cell?.screenshotImageView.loadImage(from: baseURL.small.rawValue + imageURLString, completed: {
            print("screenshot images in collectionview downloaded")
        })
        
        return cell!
    }
    

    var images: Image?
    
    @IBOutlet weak var screenshotCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        screenshotCollectionView.delegate = self
        screenshotCollectionView.dataSource = self
        screenshotCardView.layer.cornerRadius = 20
        screenshotCardView.layer.shadowRadius = 7
        screenshotCardView.layer.shadowOpacity = 0.35
        screenshotCardView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
