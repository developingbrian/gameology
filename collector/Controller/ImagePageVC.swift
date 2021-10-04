//
//  ImagePageVC.swift
//  collector
//
//  Created by Brian on 5/19/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class ImagePageVC: UIPageViewController {

    var images : [UIImage] = []
    var imageURLs : [String] = []
    var selectedIndex = 0
    var sb = UIStoryboard(name: "Main", bundle: nil)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        print("selected index is", selectedIndex)

        let fullImageVC = sb.instantiateViewController(identifier: "fullImage") as! FullImageVC
        
        if imageURLs.count > 0 {
            
            fullImageVC.imageURL = imageURLs[selectedIndex]
            print(imageURLs[selectedIndex])
        } else {
            fullImageVC.image = images[selectedIndex]
            print(images[selectedIndex])
        }
        
        let viewControllers = [fullImageVC]
        
        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
    



}


extension ImagePageVC: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if imageURLs.count > 0 {
        let currentImageName = (viewController as! FullImageVC).imageURL!
        let currentIndex = imageURLs.firstIndex(of: currentImageName)!



        if currentIndex < imageURLs.count - 1 {

            let fullImageVC = sb.instantiateViewController(identifier: "fullImage") as! FullImageVC
            fullImageVC.imageURL = imageURLs[currentIndex + 1]
            return fullImageVC
        }

        }
        else {
            let currentImage = (viewController as! FullImageVC).zoomedImageView.image!
            let currentIndex = images.firstIndex(of: currentImage)!


            if currentIndex < images.count - 1 {

                let fullImageVC = sb.instantiateViewController(identifier: "fullImage") as! FullImageVC
                fullImageVC.image = images[currentIndex + 1]
                return fullImageVC
            }

        }
        return nil
    }
    


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if imageURLs.count > 0 {
        let currentImageName = (viewController as! FullImageVC).imageURL!
        let currentIndex = imageURLs.firstIndex(of: currentImageName)!
        
        
        
        if currentIndex > 0 {
            
            let fullImageVC = sb.instantiateViewController(identifier: "fullImage") as! FullImageVC
            fullImageVC.imageURL = imageURLs[currentIndex - 1]
            return fullImageVC
        }
        } else {
            
            let currentImage = (viewController as! FullImageVC).zoomedImageView.image!
            let currentIndex = images.firstIndex(of: currentImage)!
            
            if currentIndex > 0 {
                
                let fullImageVC = sb.instantiateViewController(identifier: "fullImage") as! FullImageVC
                fullImageVC.image = images[currentIndex - 1]
                return fullImageVC
                
                
            }
        }
        
        return nil    }



}
