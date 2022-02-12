//
//  BoxartTableViewCell.swift
//  collector
//
//  Created by Brian on 11/14/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class BoxartTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var parent: UIViewController?
    var game : GameObject?
    
    @IBOutlet var boxartCardView: UIView!
    
    @IBOutlet weak var boxartBackgroundView: UIView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = boxartCollectionView.dequeueReusableCell(withReuseIdentifier: "boxartCollection", for: indexPath) as? BoxartCollectionViewCell
        
        cell?.game = game
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let boxartURL = baseURL.fullHD.rawValue + (game?.boxartFrontImage)!
        let vc = (parent?.storyboard?.instantiateViewController(identifier: "fullImage"))! as FullImageVC
        
        vc.imageURL = boxartURL
        parent?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var boxartCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        boxartCollectionView.delegate = self
        boxartCollectionView.dataSource = self
        boxartCardView.layer.cornerRadius = 10
        
        setAppearance()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setAppearance() {
        
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
            boxartBackgroundView.backgroundColor = lightGray
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            boxartBackgroundView.backgroundColor = darkGray
            
            
        }
    }
    
    
    
}
