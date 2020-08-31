//
//  Common.swift
//  collector
//
//  Created by Brian on 8/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, UIImage>()

extension UIViewController {

//var platformImageName : String

func setPlatformIcon(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
    
    var platformImageName: String = ""
    print("setPlatformIcon()")
    
    switch platformID {
        case 7:
            
            if mode == .light {
                //Light Mode
                platformImageName = "NESLogo"
            } else {
                //Dark Mode
                platformImageName = "NESLogoInverse"
                
            }
            
        case 6:
            if mode == .light {
                //Light Mode
                platformImageName = "SNESLogo1"
            } else {
                //Dark Mode
                platformImageName = "SNESLogo1Inverse"
                
            }
        case 3:
            if mode == .light {
                //Light Mode
                platformImageName = "N64Logo"
            } else {
                //Dark Mode
                platformImageName = "N64LogoInverse"
                
            }
        case 2:
            if mode == .light {
                //Light Mode
                platformImageName = "GCLogo"
            } else {
                //Dark Mode
                platformImageName = "GCLogoInverse"
                
            }
        case 4:
            if mode == .light {
                //Light Mode
                platformImageName = "GBLogo"
            } else {
                //Dark Mode
                platformImageName = "GBLogoInverse"
                
            }
        case 5:
            if mode == .light {
                //Light Mode
                platformImageName = "GBALogo"
            } else {
                //Dark Mode
               platformImageName = "gbaLogoInverse"
                
            }
        case 18:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaGenesisLogoInverse"
                
            }
        case 21:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaCDLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaCDLogoInverse"
                
            }
            
        default:
            print("Invalid Platform")
            
        
    }
    return platformImageName
    
}
    
    
    func getImageFileName(imageType: String, imageData: [Images.Inner]) -> String {
        print("outside imageData \(imageData)")
        let testtest : Images.Inner?
        let network = Networking()
        print(network.gameImageData)
        let images = imageData
        var image1 = [Images.Inner]()
        var array:[Images.Inner]?
        var imageFileName : String = ""
        let imagetest = Networking().gameImageData
        let inner = images
//            network.gameDataImages?.data?.images.innerArray
//        for (_, value) in inner! {
//
//            array = value
//        }
//        print(testtest)
        print("\(imagetest)")
        array = network.gameImageData
        print("images = \(images)")
        print("image1 = \(image1)")
        print("array = \(array)")
        print("imageType = \(imageType)")
        let testArray = images.filter({$0.type == "\(imageType)"})
print("testArray = \(testArray)")
        //        let fanartArray = array?.filter({$0.type == "\(imageType)"})
        if testArray.count > 0 {
            imageFileName = (testArray[0].fileName) as! String
            
        }
        return imageFileName
    }
    
    
    
}






extension UIImageView {
    func loadImage(from urlString: String, completed: @escaping () -> ()) {
//
//        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = cacheImage
//            print("Image already downloaded, using cached image")
//            return
//        }
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                print("Couldn't download image: \(error)")
//                return
//            }
//
//            guard let data = data else { return }
//            let image = UIImage(data: data)
//            print("Downloading image")
//            imageCache.setObject(image!, forKey: urlString as AnyObject)
//
//            DispatchQueue.main.async {
//                self.image = image
//            }
//
//        }.resume()
    
        
        
        let imageURL = URL(string: urlString)

        DispatchQueue.global().async { [weak self] in

            if let data = try? Data(contentsOf: imageURL!) {

                if let image = UIImage(data: data) {

                    DispatchQueue.main.async {
                        self?.image = image
                        completed()
                    }
                }
            }
        }
    }
    
    
    
    func loadCoverImage(from url: String, completed: @escaping () -> ()) {
        
        let imageURL = URL(string: url)
        
        DispatchQueue.global().async { [weak self] in
            
            if let data = try? Data(contentsOf: imageURL!) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        
                        self?.image = image
                        
                        completed()
                    }
                }
            }
        }
    }
    
}
