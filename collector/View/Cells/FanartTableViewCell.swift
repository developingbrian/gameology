////
////  FanartTableViewCell.swift
////  collector
////
////  Created by Brian on 11/14/20.
////  Copyright © 2020 Brian. All rights reserved.
////
//
//import UIKit
//
//class FanartTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    @IBOutlet weak var fanartCardView: UIView!
//    
//    @IBOutlet weak var fanartBackgroundView: UIView!
//    weak var parent: UIViewController?
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return (images?.fanartArray!.count)!
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = fanartCollectionView.dequeueReusableCell(withReuseIdentifier: "fanartCollection", for: indexPath) as? FanartCollectionViewCell
////        let imageURLString = baseURL.small.rawValue + (images?.fanartArray?[indexPath.row])!
////        let imageURL = URL(string: imageURLString)!
//////        cell?.fanartImageView
//////            .loadImage(from: imageURLString, completed: {
//////            print("fanart images in collectionview downloaded")
//////        })
////        cell?.fanartImageView.setImageAnimated(imageUrl: imageURL, placeholderImage: nil, completed: {
////                        print("fanart images in collectionview downloaded")
////
////        })
//        
//        return cell!
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let fanartURL = images?.fanartArray![indexPath.item]
////        let vc = (parent?.storyboard?.instantiateViewController(identifier: "fullImage"))! as FullImageVC
////
////        vc.imageURL = fanartURL
////        parent?.navigationController?.pushViewController(vc, animated: true)
//    }
//    
////    var images : Image?
//    
//    @IBOutlet weak var fanartCollectionView: UICollectionView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        fanartCollectionView.delegate = self
//        fanartCollectionView.dataSource = self
//        fanartCardView.layer.cornerRadius = 20
//
//        
//        setAppearance()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    func setAppearance() {
////        print("setting appearance")
//        
//        let defaults = UserDefaults.standard
//        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
//
//        
//        if appearanceSelection == 0 {
//           
//            overrideUserInterfaceStyle = .unspecified
//        } else if appearanceSelection == 1 {
//            overrideUserInterfaceStyle = .light
//           
//
//
//        } else {
//            overrideUserInterfaceStyle = .dark
//           
//
//        }
//        
//        if traitCollection.userInterfaceStyle == .light {
//            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//            fanartBackgroundView.backgroundColor = lightGray
//            
//        } else if traitCollection.userInterfaceStyle == .dark {
//            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
//            fanartBackgroundView.backgroundColor = darkGray
//           
//
//        }
//    }
//}
