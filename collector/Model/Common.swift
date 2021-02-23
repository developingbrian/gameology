//
//  Common.swift
//  collector
//
//  Created by Brian on 8/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

var imageCache = NSCache<AnyObject, UIImage>()
let testimageCache = NSCache<NSString, UIImage>()
var vSpinner : UIView?
let network = Networking()

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
//        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
    
    func applyGradientRounded(layoutIfNeeded: Bool, colors: [CGColor]) {
        self.backgroundColor = nil
        if layoutIfNeeded {
        self.layoutIfNeeded()
        }
            
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.cornerRadius = 10
        gradientLayer.cornerRadius = 10

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
//        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }

    
}




extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension UIViewController {

//var platformImageName : String
    
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
   }
    
    
    
        func showSpinner(onView : UIView) {
//            let spinnerView = UIView.init(frame: onView.bounds)
            onView.isHidden = false
            let spinnerView = NVActivityIndicatorView(frame: onView.bounds, type: .pacman, padding: 160)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            
            onView.backgroundColor = spinnerView.backgroundColor
//            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            spinnerView.startAnimating()
            spinnerView.center = spinnerView.center
            
            DispatchQueue.main.async {
//                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            vSpinner = spinnerView
        }
        
    func removeSpinner() {
            DispatchQueue.main.async {
                vSpinner?.removeFromSuperview()
                vSpinner = nil
            }
        }

    
    func fetchAddToButtonIcon(platformID: Int, owned: Bool) -> String {
        
        var imageName: String = ""
        
        switch platformID {
        
        case 7:
            if owned {
                imageName = "nes-minus-inversed"
            } else {
                imageName = "nes-plus-inversed"
            }
            
        case 6:
            if owned {
                imageName = "snes-minus-inversed"
            } else {
                imageName = "snes-plus-inversed"
            }
            
        case 3:
            if owned {
                imageName = "n64-minus-inversed"
            } else {
                imageName = "n64-plus-inversed"
            }
        
        case 2:
            if owned {
                imageName = "gc-minus-inversed"
            } else {
                imageName = "gc-plus-inversed"
            }
            
        case 4:
            if owned {
                imageName = "gb-minus-inversed"
            } else {
                imageName = "gb-plus-inversed"
            }
        case 5:
            if owned {
                imageName = "gba-minus-inversed"
            } else {
                imageName = "gba-plus-inversed"
            }
        case 18:
            if owned {
                imageName = "genesis-minus-inversed"
            } else {
                imageName = "genesis-plus-inversed"
            }
        case 21:
            if owned {
                imageName = "cd-minus-inversed"
            } else {
                imageName = "cd-plus-inversed"
            }
        default:
            print("Invalid Platform")
            
        }
        return imageName

    }
    
    func fetchPlatformObject1(platformID: Int) -> PlatformObject {
        let platform = PlatformObject(id: network.platforms["\(platformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)

        return platform
        
    }
    
    func changePlatformNameToID(platformName: String) -> Int {
        


        switch platformName {
        case "Nintendo Entertainment System (NES)":
            return 7
        case "Super Nintendo (SNES)":
            return 6
        case "Nintendo Game Boy Advance":
            return 5
        case "Sega Genesis":
            return 18
            
        default:
            print("invalid platform")
        }
        
        return 1
    }
    
func setPlatformIcon(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
    
    var platformImageName: String = ""
    print("setPlatformIcon()")
    print("\(platformID)")
    switch platformID! {
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
            
    case 0:
        
        if mode == .light {
            //Light Mode
            platformImageName = "allPlatformLogo"
        } else {
            //Dark Mode
            platformImageName = "allPlatformLogoInverse"
            
        }
            
        default:
            print("Invalid Platform")
            
        
    }
    return platformImageName
    
}
    
    
    func getImageFileName(imageType: String, imageData: [GameImages.Inner]) -> String {
        print("outside imageData \(imageData)")
        let network = Networking()
        
        let images = imageData

        var imageFileName : String = ""

        let testArray = images.filter({$0.type == "\(imageType)"})
print("testArray = \(testArray)")

        if testArray.count > 0 && imageType == "fanart"{
            imageFileName = (testArray.randomElement()?.fileName)!
            
        } else if testArray.count > 0 {
            imageFileName = (testArray[0].fileName) 
        }
        return imageFileName
    }
    
    
    
}






extension UIImageView {
    
    func setImageAnimated(imageUrl:URL, placeholderImage:UIImage) {
        self.sd_setImage(with: imageUrl, placeholderImage: placeholderImage , options:SDWebImageOptions.avoidAutoSetImage, completed: { (image, error, cacheType, url) in
            if cacheType == SDImageCacheType.none {
                UIView.transition(with: self.superview!, duration: 0.2, options:  [.transitionCrossDissolve ,.allowUserInteraction, .curveEaseIn], animations: {
                    self.image = image
                }, completion: { (completed) in
                })
            } else {
                self.image = image
            }
        })
    }
    
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
    
        
        print("urlString = \(urlString)")
        let imageURL = URL(string: urlString)!

        DispatchQueue.global().async { [weak self] in

            if let data = try? Data(contentsOf: imageURL) {

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
    
    
    func downloadImage(from imgURL: String) -> URLSessionDataTask? {
        guard let url = URL(string: imgURL) else { return nil }

        // set initial image to nil so it doesn't use the image from a reused cell
        image = nil

        // check if the image is already in the cache
        if let imageToCache = testimageCache.object(forKey: imgURL as NSString) {
            self.image = imageToCache
            return nil
        }

        // download the image asynchronously
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
                return
            }

            DispatchQueue.main.async {
                // create UIImage
                let imageToCache = UIImage(data: data!)
                // add image to cache
                testimageCache.setObject(imageToCache!, forKey: imgURL as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        return task
    }
    
}


extension UIImage {
    
    
 

    func tintedWithLinearGradientColors(colorsArr: [CGColor]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        context.translateBy(x: self.size.width, y: 0)
        context.scaleBy(x: -1, y: 1)

        context.setBlendMode(.normal)
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)

        // Create gradient
        let colors = colorsArr as CFArray
        let space = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)

        // Apply gradient
        context.clip(to: rect, mask: self.cgImage!)
        context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: self.size.width, y: 0), options: .drawsAfterEndLocation)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return gradientImage!
    }

    
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    
    func edgeColor(_ insets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), defaultColor: UIColor = .black) -> UIColor {
        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return defaultColor
        }

        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let width = Int(self.size.width * self.scale)
        let height = Int(self.size.height * self.scale)

        var edgeR: Int = 0
        var edgeG: Int = 0
        var edgeB: Int = 0
        var count: Int = 0

        for x in stride(from: 0, to: width, by: 1) {
            for y in stride(from: 0, to: height, by: 1) {
                let pixelInfo: Int = ((width * y) + x) * 4

                let r: Int = Int(data[pixelInfo])
                let g: Int = Int(data[pixelInfo + 1])
                let b: Int = Int(data[pixelInfo + 2])

                // Accumulate top, right and left edges
                if
                    x < Int(insets.left) ||
                    y < Int(insets.top) ||
                    x > width - Int(insets.right) ||
                    y > height - Int(insets.bottom)
                {
                    edgeR += r
                    edgeG += g
                    edgeB += b
                    count += 1
                }
            }
        }

        return UIColor(
            red: CGFloat(edgeR / count) / 255,
            green: CGFloat(edgeG / count) / 255,
            blue: CGFloat(edgeB / count) / 255,
            alpha: 1.0
        )
    }
    
}

extension UITableViewCell {
    
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
   }
    
    
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
