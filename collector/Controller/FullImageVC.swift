//
//  FullImageVC.swift
//  collector
//
//  Created by Brian on 4/3/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class FullImageVC: UIViewController {
    
    
    @IBOutlet weak var zoomedImageView: UIImageView!
    var imageURL : String?
    var image : UIImage?
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        if let imgURL = imageURL {
            
            let url = URL(string: "\(imgURL)")!
            
            zoomedImageView.setImageAnimated(imageUrl: url, placeholderImage: nil) {
                
            }
        }
        
        if let image = image {
            zoomedImageView.image = image
        }
    }
    
    
    
    
    
    @IBAction func imageDoubleTapped(_ sender: UITapGestureRecognizer) {
        
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: sender.location(in: sender.view)), animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
        
        
    }
    
    
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = zoomedImageView.frame.size.height / scale
        zoomRect.size.width  = zoomedImageView.frame.size.width  / scale
        let newCenter = scrollView.convert(center, from: zoomedImageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}




extension FullImageVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.zoomedImageView
        
    }
    
    
}
