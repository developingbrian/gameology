//
//  BoxartTableViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class BoxartTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var images : Image?
    @IBOutlet var boxartCardView: UIView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images?.boxartArray!.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = boxartCollectionView.dequeueReusableCell(withReuseIdentifier: "boxartCollection", for: indexPath) as? BoxartCollectionViewCell
        let imageURLString = (images?.boxartArray?[indexPath.row])!
        cell?.boxartImageView.loadImage(from: baseURL.small.rawValue + imageURLString, completed: {
            print("boxart images in collectionview downloaded")
        })
        
        return cell!
    }
    
    @IBOutlet weak var boxartCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        boxartCollectionView.delegate = self
        boxartCollectionView.dataSource = self
        boxartCardView.layer.cornerRadius = 20
        boxartCardView.layer.shadowRadius = 7
        boxartCardView.layer.shadowOpacity = 0.35
        boxartCardView.layer.masksToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
