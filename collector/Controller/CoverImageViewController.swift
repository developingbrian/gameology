//
//  CoverImageViewController.swift
//  collector
//
//  Created by Brian on 9/3/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class CoverImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
  
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var largeImage: UIImageView!
    
    var frontCoverImage : UIImage?
    var rearCoverImage : UIImage?
    var screenshotImage : UIImage?
    var tag = 0
    var coverImageArray : [UIImage?] = []
    var screenshotsArray : [UIImage?] = []
    var imageIndexPath : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        coverImageArray.append(frontCoverImage)
        coverImageArray.append(rearCoverImage)
        
//        scrollToIndex(index: imageIndexPath!)
//        imageCollectionView.reloadData()
        
        print("imageIndexPath = \(imageIndexPath)")
        
//           self.imageCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .right, animated: false)
//        scrollToIndex(index: imageIndexPath!)
//        scrollToIndex(index: 2)
//        imageCollectionView.reloadData()

        
//        if tag == 1 {
//        coverImage.image = frontCoverImage
//        } else if tag == 2 {
//        coverImage.image = screenshotImage
//        }
//        
//        self.view.bringSubviewToFront(nextButton)
//        nextButton.layer.zPosition = 5
//        coverImage.layer.zPosition = 4
//        previousButton.layer.zPosition = 5
//        

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("imageIndexPath = \(imageIndexPath)")
//        scrollToIndex(index: imageIndexPath!)
//        imageCollectionView.reloadData()
//
//    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
//        print("imageIndexPath = \(imageIndexPath)")
//        scrollToIndex(index: 2)

     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if tag == 2 {
           scrollToIndex(index: imageIndexPath!)
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if tag == 1 {
            count = coverImageArray.count
        } else if tag == 2 {
            count = screenshotsArray.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "largeImage", for: indexPath) as! CoverImageCollectionViewCell
        
        if tag == 1 {
            let image = coverImageArray[indexPath.row]
            print("tag 1 cellforitemat")
            cell.largeImage.image = image
            print(cell.largeImage.image)
        } else if tag == 2 {
            let image = screenshotsArray[indexPath.row]
            cell.largeImage.image = image
        }
        return cell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.imageCollectionView.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.imageCollectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }
    
    func scrollToIndex(index: Int) {
        let indexPath = NSIndexPath(item: index, section: 0)
        self.imageCollectionView.scrollToItem(at: indexPath as IndexPath, at: .right, animated: false)
    }
    

}
