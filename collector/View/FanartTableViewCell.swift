//
//  FanartTableViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class FanartTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var fanartCardView: UIView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images?.fanartArray!.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fanartCollectionView.dequeueReusableCell(withReuseIdentifier: "fanartCollection", for: indexPath) as? FanartCollectionViewCell
        let imageURLString = (images?.fanartArray?[indexPath.row])!
        cell?.fanartImageView
            .loadImage(from: baseURL.small.rawValue + imageURLString, completed: {
            print("fanart images in collectionview downloaded")
        })
        
        return cell!
    }
    
    
    var images : Image?
    
    @IBOutlet weak var fanartCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fanartCollectionView.delegate = self
        fanartCollectionView.dataSource = self
        fanartCardView.layer.cornerRadius = 20
        fanartCardView.layer.shadowRadius = 7
        fanartCardView.layer.shadowOpacity = 0.35
        fanartCardView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
