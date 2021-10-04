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
let network = Networking.shared

extension UIButton {
        func setInsets(
            forContentPadding contentPadding: UIEdgeInsets,
            imageTitlePadding: CGFloat) {
            self.contentEdgeInsets = UIEdgeInsets(
                top: contentPadding.top,
                left: contentPadding.left,
                bottom: contentPadding.bottom,
                right: contentPadding.right + imageTitlePadding
            )
            self.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: imageTitlePadding,
                bottom: 0,
                right: -imageTitlePadding
            )
        }
    func applyGradients(colors: [CGColor]) {
//        self.backgroundColor = nil
//        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = self.frame.height/2

//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
//        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
   
    }

    
    func applyGradient(colors: [CGColor]) {
//        self.backgroundColor = nil
//        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = self.frame.height/2

//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
//        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
    
    func moveImageLeftTextCenter(imagePadding: CGFloat = 30.0){
            guard let imageViewWidth = self.imageView?.frame.width else{return}
            guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
            self.contentHorizontalAlignment = .left
            imageEdgeInsets = UIEdgeInsets(top: 5.0, left: imagePadding - imageViewWidth / 2, bottom: 5.0, right: 0.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: (bounds.width - titleLabelWidth) / 2 - imageViewWidth, bottom: 0.0, right: 0.0)
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
        self.layer.cornerRadius = 4
//        self.backgroundColor = .red
        gradientLayer.cornerRadius = 4

//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        self.titleEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        self.titleLabel?.textAlignment = .center
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

extension UICollectionViewCell {
    
 
    
    
}

extension UIViewController {
//    let platforms = ["3DO Interactive Multiplayer", "Amiga CD32", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", "Atari Lynx", "ColecoVision", "Fairchild Channel F", "Intellivision", "Magnavox Odyssey", "Microsoft Xbox", "Microsoft Xbox 360", "Microsoft Xbox One", "Microsoft Xbox Series S|X", "Neo Geo AES", "Neo Geo CD", "Neo Geo Pocket", "Neo Geo Pocket Color", "Nintendo Game & Watch", "Nintendo Entertainment System (NES)", "Super Nintendo Entertainment System (SNES)", "Nintendo Virtual Boy", "Nintendo 64", "Nintendo GameCube", "Nintendo Wii", "Nintendo Wii U", "Nintendo Switch", "Nintendo Game Boy", "Nintendo Game Boy Advance", "Nintendo DS", "Nintendo DSi", "Nintendo 3DS", "New Nintendo 3DS", "Nintendo Pokémon Mini", "Nokia N-Gage", "Nuon", "TurboGrafx-16/PC Engine", "PC Engine SuperGrafx","Philips CD-i", "Sega SG-1000", "Sega Master System", "Sega Genesis/Mega Drive", "Sega CD", "Sega 32X", "Sega Saturn", "Sega Dreamcast", "Sega Game Gear", "Sega Pico", "Sony PlayStation", "Sony PlayStation 2", "Sony PlayStation 3", "Sony PlayStation 4", "Sony PlayStation 5", "Sony PlayStation Portable (PSP)", "Sony PlayStation Vita", "Vectrex", "WonderSwan", "WonderSwan Color", "Zeebo"]

    
    
    func formatPlatformIDToPlatformName(ID: Int) -> String {
      
            switch ID {
            case 50     :   return "3DO Interactive Multiplayer"
            case 114    :   return "Amiga CD32"
            case 59     :   return "Atari 2600"
            case 66                                   :   return "Atari 5200"
            case 60                                   :   return "Atari 7800"
            case 62                                 :   return "Atari Jaguar"
            case 61                                   :   return "Atari Lynx"
            case 68                                 :   return "ColecoVision"
            case 127                          :   return "Fairchild Channel F"
            case 67                                :   return "Intellivision"
            case 88                             :   return "Magnavox Odyssey"
            case 11                               :   return "Microsoft Xbox"
            case 12                           :   return "Microsoft Xbox 360"
            case 49                           :   return "Microsoft Xbox One"
            case 169                    :   return "Microsoft Xbox Series S|X"
            case 80                                  :   return "Neo Geo AES"
            case 136                                   :   return "Neo Geo CD"
            case 119                               :   return "Neo Geo Pocket"
            case 120                         :   return "Neo Geo Pocket Color"
            case 307                        :   return "Nintendo Game & Watch"
            case 18          :   return "Nintendo Entertainment System (NES)"
            case 19   :   return "Super Nintendo Entertainment System (SNES)"
            case 87                         :   return "Nintendo Virtual Boy"
            case 4                                  :   return "Nintendo 64"
            case 21                            :   return "Nintendo GameCube"
            case 5                                 :   return "Nintendo Wii"
            case 41                               :   return "Nintendo Wii U"
            case 130                              :   return "Nintendo Switch"
            case 33                            :   return "Nintendo Game Boy"
            case 22     :   return "Nintendo Game Boy Color"
            case 24                    :   return "Nintendo Game Boy Advance"
            case 20                                  :   return "Nintendo DS"
            case 159                                 :   return "Nintendo DSi"
            case 37                                 :   return "Nintendo 3DS"
            case 137                             :   return "New Nintendo 3DS"
            case 166                        :   return "Nintendo Pokémon Mini"
            case 42                                 :   return "Nokia N-Gage"
            case 122                                         :   return "Nuon"
            case 86                      :   return "TurboGrafx-16/PC Engine"
            case 128                         :   return "PC Engine SuperGrafx"
            case 117                                 :   return "Philips CD-i"
            case 84                                 :   return "Sega SG-1000"
            case 64                           :   return "Sega Master System"
            case 29                      :   return "Sega Genesis/Mega Drive"
            case 78                                      :   return "Sega CD"
            case 30                                     :   return "Sega 32X"
            case 32                                  :   return "Sega Saturn"
            case 23                               :   return "Sega Dreamcast"
            case 35                               :   return "Sega Game Gear"
            case 339                                    :   return "Sega Pico"
            case 7                             :   return "Sony PlayStation"
            case 8                           :   return "Sony PlayStation 2"
            case 9                           :   return "Sony PlayStation 3"
            case 48                           :   return "Sony PlayStation 4"
            case 167                           :   return "Sony PlayStation 5"
            case 38              :   return "Sony PlayStation Portable (PSP)"
            case 46                        :   return "Sony PlayStation Vita"
            case 70                                      :   return "Vectrex"
            case 57                                   :   return "WonderSwan"
            case 123                             :   return "WonderSwan Color"
            case 240                                        :   return "Zeebo"
            default                                             : print("Unkown Platform, platform ID is \(ID)")
                                                                    return "Unknown Platform, platform ID is \(ID)"
            }
       
    }
    
    func formatPrettyPlatformNameToID(platformName: String) -> Int {
      
            switch platformName {
            case "3DO Interactive Multiplayer"                  :   return 50
            case "Amiga CD32"                                   :   return 114
            case "Atari 2600"                                   :   return 59
            case "Atari 5200"                                   :   return 66
            case "Atari 7800"                                   :   return 60
            case "Atari Jaguar"                                 :   return 62
            case "Atari Lynx"                                   :   return 61
            case "ColecoVision"                                 :   return 68
            case "Fairchild Channel F"                          :   return 127
            case "Intellivision"                                :   return 67
            case "Magnavox Odyssey"                             :   return 88
            case "Microsoft Xbox"                               :   return 11
            case "Microsoft Xbox 360"                           :   return 12
            case "Microsoft Xbox One"                           :   return 49
            case "Microsoft Xbox Series S|X"                    :   return 169
            case "Neo Geo AES"                                  :   return 80
            case "Neo Geo CD"                                   :   return 136
            case "Neo Geo Pocket"                               :   return 119
            case "Neo Geo Pocket Color"                         :   return 120
            case "Nintendo Game & Watch"                        :   return 307
            case "Nintendo Entertainment System (NES)"          :   return 18
            case "Super Nintendo Entertainment System (SNES)"   :   return 19
            case "Nintendo Virtual Boy"                         :   return 87
            case "Nintendo 64"                                  :   return 4
            case "Nintendo GameCube"                            :   return 21
            case "Nintendo Wii"                                 :   return 5
            case "Nintendo Wii U"                               :   return 41
            case "Nintendo Switch"                              :   return 130
            case "Nintendo Game Boy"                            :   return 33
            case "Nintendo Game Boy Color"                      :   return 22
            case "Nintendo Game Boy Advance"                    :   return 24
            case "Nintendo DS"                                  :   return 20
            case "Nintendo DSi"                                 :   return 159
            case "Nintendo 3DS"                                 :   return 37
            case "New Nintendo 3DS"                             :   return 137
            case "Nintendo Pokémon Mini"                        :   return 166
            case "Nokia N-Gage"                                 :   return 42
            case "Nuon"                                         :   return 122
            case "TurboGrafx-16/PC Engine"                      :   return 86
            case "PC Engine SuperGrafx"                         :   return 128
            case "Philips CD-i"                                 :   return 117
            case "Sega SG-1000"                                 :   return 84
            case "Sega Master System"                           :   return 64
            case "Sega Genesis/Mega Drive"                      :   return 29
            case "Sega CD"                                      :   return 78
            case "Sega 32X"                                     :   return 30
            case "Sega Saturn"                                  :   return 32
            case "Sega Dreamcast"                               :   return 23
            case "Sega Game Gear"                               :   return 35
            case "Sega Pico"                                    :   return 339
            case "Sony PlayStation"                             :   return 7
            case "Sony PlayStation 2"                           :   return 8
            case "Sony PlayStation 3"                           :   return 9
            case "Sony PlayStation 4"                           :   return 48
            case "Sony PlayStation 5"                           :   return 167
            case "Sony PlayStation Portable (PSP)"              :   return 38
            case "Sony PlayStation Vita"                        :   return 46
            case "Vectrex"                                      :   return 70
            case "WonderSwan"                                   :   return 57
            case "WonderSwan Color"                             :   return 123
            case "Zeebo"                                        :   return 240
            default                                             :   return 18
            }
       
    }
    
    func formatIGDBToPrettyTitle(platformName: String) -> String {
        
        var title = ""
        
        switch platformName {
        
        
        case "Odyssey":
            title = "Magnavox Odyssey"
        
        case "Xbox":
            title = "Microsoft Xbox"
        
        case "Xbox 360":
            title = "Microsoft Xbox 360"
        
        case "Xbox One":
            title = "Microsoft Xbox One"
          
        case "Xbox Series X|S":
            title = "Microsoft Xbox Series S|X"
        
        case "Game & Watch":
            title = "Nintendo Game & Watch"
        
        case "Virtual Boy":
            title = "Nintendo Virtual Boy"
            
        case "Game Boy":
            title = "Nintendo Game Boy"
        case "Game Boy Color":
            title = "Nintendo Game Boy Color"
            
        case "Game Boy Advance":
            title = "Nintendo Game Boy Advance"
            
        case "Pokémon Mini":
            title = "Nintendo Pokémon mini"
            
        case "Wii":
            title = "Nintendo Wii"
        
        case "Wii U":
            title = "Nintendo Wii U"

        case "SG-1000":
            title = "Sega SG-1000"
            
        case "Sega Mega Drive/Genesis":
            title = "Sega Genesis/Mega Drive"
            
        case "Dreamcast":
            title = "Sega Dreamcast"
            
        case "N-Gage":
            title = "Nokia N-Gage"
            
        case "PlayStation":
            title = "Sony PlayStation"
            
        case "PlayStation 2":
            title = "Sony PlayStation 2"
            
        case "PlayStation 3":
            title = "Sony PlayStation 3"
            
        case "PlayStation 4":
            title = "Sony PlayStation 4"
            
        case "PlayStation 5":
            title = "Sony PlayStation 5"
            
        case "PlayStation Portable":
            title = "Sony PlayStation Portable (PSP)"
            
        case "PlayStation Vita":
            title = "Sony PlayStation Vita"
        
        default:
            title = platformName
            
        }
        
        return title
        
        
    }

    
    func formatPrettyTitleToIGDB(platformName: String) -> String {
        
        var title = ""
        
        switch platformName {
        

        case "Magnavox Odyssey"                 :   title = "Odyssey"
        case "Microsoft Xbox"                   :   title = "Xbox"
        case "Microsoft Xbox 360"               :   title = "Xbox 360"
        case "Microsoft Xbox One"               :   title = "Xbox One"
        case "Microsoft Xbox Series S|X"        :   title = "Xbox Series X|S"
        case "Nintendo Game & Watch"            :   title = "Game & Watch"
        case "Nintendo Virtual Boy"             :   title = "Virtual Boy"
        case "Nintendo Game Boy"                :   title = "Game Boy"
        case "Nintendo Game Boy Color"          :   title = "Game Boy Color"
        case "Nintendo Game Boy Advance"        :   title = "Game Boy Advance"
        case "Nintendo Pokémon Mini"            :   title = "Pokémon mini"
        case "Nintendo Wii"                     :   title = "Wii"
        case "Nintendo Wii U"                   :   title = "Wii U"
        case "Sega SG-1000"                     :   title = "SG-1000"
        case "Sega Genesis/Mega Drive"          :   title = "Sega Mega Drive/Genesis"
        case "Sega Dreamcast"                   :   title = "Dreamcast"
        case "Nokia N-Gage"                     :   title = "N-Gage"
        case "Sony PlayStation"                 :   title = "PlayStation"
        case "Sony PlayStation 2"               :   title = "PlayStation 2"
        case "Sony PlayStation 3"               :   title = "PlayStation 3"
        case "Sony PlayStation 4"               :   title = "PlayStation 4"
        case "Sony PlayStation 5"               :   title = "PlayStation 5"
        case "Sony PlayStation Portable (PSP)"  :   title = "PlayStation Portable"
        case "Sony PlayStation Vita"            :   title = "PlayStation Vita"
        default                                 :   title = platformName
            
        }
        
        return title
        
        
        
        }

//var platformImageName : String
    func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else
        {
            print("ciImage failed")
         return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {
            print("outputImage failed")
            return nil
        }
        
        return UIImage(ciImage: outputImage)
        
        
    }
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
   }
    
    
    
    func showSpinner(onView : UIView, userInterfaceStyle: UIUserInterfaceStyle) {
//            let spinnerView = UIView.init(frame: onView.bounds)
            onView.isHidden = false
            var spinnerView = NVActivityIndicatorView(frame: .zero, type: nil, color: nil, padding: nil)
            
            
            if userInterfaceStyle == .light {
                print("spinnerview should be black")

                spinnerView = NVActivityIndicatorView(frame: onView.bounds, type: .ballSpinFadeLoader, color: .black, padding: 20)
                
            } else {
                print("spinnerview should be white")
                spinnerView = NVActivityIndicatorView(frame: onView.bounds, type: .ballSpinFadeLoader, color: .white, padding: 20)

                }
            spinnerView.alpha = 0.75
//            onView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.25)
//            spinnerView.backgroundColor = .clear
//            spinnerView.backgroundColor  = .black
            spinnerView.backgroundColor = .clear
            onView.backgroundColor = .clear
            onView.layer.cornerRadius = 15
//            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            spinnerView.startAnimating()
            spinnerView.center = spinnerView.center
            
            DispatchQueue.main.async {
//                spinnerView.addSubview(ai)
//                onView.addSubview(spinnerView)
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
        print("fetching add to button icon, current platform is:", platformID)
        var imageName: String = ""
        
        switch platformID {
        
        case 240                :   if owned {
                                        imageName = "hdd-minus-inversed"}
                                    else {
                                        imageName = "hdd-plus-inversed"}
        
        case 57, 123            :   if owned {
                                        imageName = "wonderswan-minus-inversed"}
                                    else {
                                        imageName = "wonderswan-plus-inversed"}
        
        case 70                 :   if owned {
                                        imageName = "vectrex-minus-inversed"}
                                    else {
                                        imageName = "vectrex-plus-inversed"}
        
        case 86, 128            :   if owned {
                                        imageName = "turbografx-minus-inversed"}
                                    else {
                                        imageName = "turbografx-plus-inversed"}
        
        case 42                 :   if owned {
                                        imageName = "ngage-minus-inversed"}
                                    else {
                                        imageName = "ngage-plus-inversed"}
            
        case 61                 :   if owned {
                                        imageName = "atarilynx-minus-inversed"}
                                    else {
                                        imageName = "atarilynx-plus-inversed"}
            
        case 66                 :   if owned {
                                        imageName = "atari5200-minus-inversed"}
                                    else {
                                        imageName = "atari5200-plus-inversed"}
        
        case 59, 60             :   if owned {
                                        imageName = "atari2600-minus-inversed"}
                                    else {
                                        imageName = "atari2600-plus-inversed"}
            
        case 307                :   if owned {
                                        imageName = "gameandwatch-minus-inversed"}
                                    else {
                                        imageName = "gameandwatch-plus-inversed"}
            
        case 18                 :   if owned {
                                        imageName = "nes-minus-inversed"}
                                    else {
                                        imageName = "nes-plus-button"}
            
        case 19                 :   if owned {
                                        imageName = "snes-minus-inversed"}
                                    else {
                                        imageName = "snes-plus-inversed"}
            
        case 4                  :   if owned {
                                        imageName = "n64-minus-inversed"}
                                    else {
                                        imageName = "n64-plus-inversed"}
            
        case 87                 :   if owned {
                                        imageName = "nvb-minus-inversed"}
                                    else {
                                        imageName = "nvb-plus-inversed"}
            
        case 20, 159, 37, 137   :   if owned {
                                        imageName = "nds-minus-inversed"}
                                    else {
                                        imageName = "nds-plus-inversed"}
            
        case 21                 :   if owned {
                                        imageName = "gc-minus-inversed"}
                                    else {
                                        imageName = "gc-plus-inversed"}
            
        case 33, 22             :   if owned {
                                        imageName = "gb-minus-inversed"}
                                    else {
                                        imageName = "gb-plus-inversed"}
            
        case 24                 :   if owned {
                                        imageName = "gba-minus-inversed"}
                                    else {
                                        imageName = "gba-plus-inversed"}
            
        case 166                :   if owned {
                                        imageName = "nintendopokemonmini-minus-inversed"}
                                    else {
                                        imageName = "nintendopokemonmini-plus-inversed"}
            
        case 130                :   if owned {
                                        imageName = "switch-minus-inversed"}
                                    else {
                                        imageName = "switch-plus-inversed"}
            
        case 64                 :   if owned {
                                        imageName = "sms-minus-inversed"}
                                    else {
                                        imageName = "sms-plus-inversed"}
            
        case 35                 :   if owned {
                                        imageName = "gamegear-minus-inversed"}
                                    else {
                                        imageName = "gamegear-plus-inversed"}
            
        case 30                 :   if owned {
                                        imageName = "32x-minus-inversed"}
                                    else {
                                        imageName = "32x-plus-inversed"}
            
        case 62                 :   if owned {
                                        imageName = "atarijaguar-minus-inversed"}
                                    else {
                                        imageName = "atarijaguar-plus-inversed"}
            
        case 29                 :   if owned {
                                        imageName = "genesis-minus-inversed"}
                                    else {
                                        imageName = "genesis-plus-inversed"}

        case 80                 :   if owned {
                                        imageName = "neogeo-minus-inversed"}
                                    else {
                                        imageName = "neogeo-plus-inversed"}
        case 78, 7, 167, 12,
             49, 48, 9, 32,
             117, 114, 50, 11,
             23, 136, 8, 169,
             5, 122, 41         :   if owned {
                                        imageName = "cd-minus-inversed"}
                                    else {
                                        imageName = "cd-plus-inversed"}
            
        case 84                 :   if owned {
                                        imageName = "segasg1000-minus-inversed"}
                                    else {
                                        imageName = "segasg1000-plus-inversed"}
        
        case 339                :   if owned {
                                        imageName = "segapico-minus-inversed"}
                                    else {
                                        imageName = "segapico-plus-inversed"}
            
        case 38                 :   if owned {
                                        imageName = "sonypsp-minus-inversed"}
                                    else {
                                        imageName = "sonypsp-plus-inversed"}
                
        case 46                 :   if owned {
                                        imageName = "psvita-minus-inversed"}
                                    else {
                                        imageName = "psvita-plus-inversed"}
            
        case 68                 :   if owned {
                                        imageName = "colecovision-minus-inversed"}
                                    else {
                                        imageName = "colecovision-plus-inversed"}
            
        case 127                :   if owned {
                                        imageName = "fairchild-minus-inversed"}
                                    else {
                                        imageName = "fairchild-plus-inversed"}
            
        case 67                 :   if owned {
                                        imageName = "intellivision-minus-inversed"}
                                    else {
                                        imageName = "intellivision-plus-inversed"}
            
        case 88                 :   if owned {
                                        imageName = "odyssey-minus-inversed"}
                                    else {
                                        imageName = "odyssey-plus-inversed"}
            
        case 119, 120           :   if owned {
                                        imageName = "neogeopocket-minus-inversed"}
                                    else {
                                        imageName = "neogeopocket-plus-inversed"}
            
        default                 :   print("Invalid Platform")
            
        }
        
        return imageName

    }
//    func fetchPlatformObject1(platformID: Int) -> PlatformObject {
    //        let platform = PlatformObject(id: network.platforms["\(pla@objc tformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)
//
//        return platform
//        
//    }
    
    func changePlatformNameToID(platformName: String) -> Int {
        
        let network = Networking.shared
        let platforms = network.platforms
        
        for platform in platforms {
            if platform.name == platformName {
                return platform.id
            }
            
        }
        
        return 0

        
    }
//
//    func changePlatformNameToID(platformName: String) -> Int {
//
//
//
//        switch platformName {
//        case "Nintendo Entertainment System (NES)":
//            return 18
//        case "Super Nintendo (SNES)":
//            return 19
//        case "Nintendo 64":
//            return 4
//        case "Nintendo Game Boy Advance":
//            return 24
//        case "Sega Genesis":
//            return 29
//        case "Sega Pico":
//            return 339
//        case "Playstation 2":
//            return 8
//        case "Odyssey":
//            return 88
//        case "Sega Game Gear":
//            return 35
//        case "ColecoVision":
//            return 68
//        case "WonderSwan Color":
//            return 123
//        case "Neo Geo CD":
//            return 136
//        case "Atari Jaguar":
//            return 62
//        case "Virtual Boy":
//            return 87
//
//        default:
//            print("invalid platform")
//        }
//
//        return 1
//    }
    
func setPlatformIcon(platformID: Int, mode: UIUserInterfaceStyle?) -> String {
    
    var platformImageName: String = ""
    print("setPlatformIcon()")
//    print("\(platformID)")
    switch platformID {
        case 18:
            
            if mode == .light {
                //Light Mode
                platformImageName = "NESLogo"
            } else {
                //Dark Mode
                platformImageName = "NESLogoInverse"
                
            }
            
        case 19:
            if mode == .light {
                //Light Mode
                platformImageName = "SNESLogo1"
            } else {
                //Dark Mode
                platformImageName = "SNESLogo1Inverse"
                
            }
        case 4:
            if mode == .light {
                //Light Mode
                platformImageName = "N64Logo"
            } else {
                //Dark Mode
                platformImageName = "N64LogoInverse"
                
            }
        case 21:
            if mode == .light {
                //Light Mode
                platformImageName = "GCLogo"
            } else {
                //Dark Mode
                platformImageName = "GCLogoInverse"
                
            }
        case 33:
            if mode == .light {
                //Light Mode
                platformImageName = "GBLogo"
            } else {
                //Dark Mode
                platformImageName = "GBLogoInverse"
                
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
            
        case 24:
            if mode == .light {
                //Light Mode
                platformImageName = "GBALogo"
            } else {
                //Dark Mode
               platformImageName = "gbaLogoInverse"
                
            }
        case 29:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaGenesisLogoInverse"
                
            }
        case 78:
            if mode == .light {
                //Light Mode
                platformImageName = "SegaCDLogo"
            } else {
                //Dark Mode
                platformImageName = "SegaCDLogoInverse"
                
            }
            
    case 339:
        platformImageName = "SegaPicoLogo"
        
    case 8:
        if mode == .light {
        platformImageName = "SonyPlaystation2Logo"
        } else {
            
            platformImageName = "SonyPlaystation2LogoInverse"
        }
        
    case 88:
        platformImageName = "OdysseyLogo"
        
    case 68:
        platformImageName = "ColecovisionLogo"
    case 35:
        platformImageName = "SegaGameGearLogo"
    case 123:
        if mode == .light {
        platformImageName = "WonderSwanColorLogo"
        } else {
            platformImageName = "WonderSwanColorLogoInverse"
        }
    case 136:
        if mode == .light {
            platformImageName = "NeoGeoCDLogo"
        } else {
            platformImageName = "NeoGeoCDLogoInverse"

        }
    
    case 62:
        platformImageName = "AtariJaguarLogo"
        
    case 87:
        platformImageName = "VirtualBoyLogo"
    case 89:
        platformImageName = "MicrovisionLogo"
    case 128:
        platformImageName = "SuperGrafxLogo"
        
    case 86:
        platformImageName = "TurboGrafx16Logo"
    case 23:
        if mode == .light {
        platformImageName = "SegaDreamcastLogo"
        } else {
        platformImageName = "SegaDreamcastLogoInverse"
        }
    case 70:
        if mode == .light {
            platformImageName = "VectrexLogo"
        } else {
            platformImageName = "VectrexLogoInverse"
        }
        
    case 119:
        if mode == .light {
            platformImageName = "NeoGeoPocketLogo"
        } else {
            platformImageName = "NeoGeoPocketLogoInverse"
        }
        
    case 124:
        if mode == .light {
            platformImageName = "SwanCrystalLogo"
        } else {
            platformImageName = "SwanCrystalLogoInverse"
        }
    case 127:
        if mode == .light {
        platformImageName = "FairchildChannelFLogo"
        } else {
        platformImageName = "FairchildChannelFLogoInverse"
        }
    case 130:
        if mode == .light {
            platformImageName = "NintendoSwitchLogo"
        } else {
            platformImageName = "NintendoSwitchLogoInverse"
        }
    case 138:
        if mode == .light {
            platformImageName = "VC4000Logo"
            
        } else {
            platformImageName = "VC4000LogoInverse"
        }
    case 159:
        if mode == .light {
            platformImageName = "NintendoDSiLogo"
        } else {
            platformImageName = "NintendoDSiLogoInverse"
        }
    case 11:
        platformImageName = "XBoxLogo"
    case 50:
        if mode == .light {
            platformImageName = "3DOLogo"
        } else {
            platformImageName = "3DOLogoInverse"
        }
    case 60:
        if mode == .light {
            platformImageName = "Atari7800Logo"
        } else {
            platformImageName = "Atari7800LogoInverse"
        }
    case 30:
        if mode == .light {
            platformImageName = "Sega32XLogo"
        } else {
            platformImageName = "Sega32XLogoInverse"
        }
    case 22:
        platformImageName = "GameBoyColorLogo"
    
    case 41:
        platformImageName = "NintendoWiiULogo"
    case 114:
        if mode == .light {
            platformImageName = "AmigaCD32Logo"
        } else {
            platformImageName = "AmigaCD32LogoInverse"
        }
    case 117:
        platformImageName = "PhilipsCDiLogo"
    case 122:
        if mode == .light {
        platformImageName = "NuonLogo"
        } else {
            platformImageName = "NuonLogoInverse"
        }
    case 120:
        if mode == .light {
            platformImageName = "NeoGeoPocketColorLogo"
        } else {
            platformImageName = "NeoGeoPocketColorLogoInverse"

        }
    case 37:
        if mode == .light {
            platformImageName = "Nintendo3DSLogo"
        } else {
            platformImageName = "Nintendo3DSLogoInverse"

        }
    case 64:
        platformImageName = "SegaMasterSystemLogo"
    case 38:
        if mode == .light {
            platformImageName = "SonyPSPLogo"
        } else {
            platformImageName = "SonyPSPLogoInverse"

        }
    case 307:
        if mode == .light {
        platformImageName = "GameAndWatchLogo"
        } else {
            platformImageName = "GameAndWatchLogoInverse"
        }
    case 20:
        if mode == .light {
            platformImageName = "NintendoDSLogo"
        } else {
            platformImageName = "NintendoDSLogoInverse"
        }
    case 32:
        platformImageName = "SegaSaturnLogo"
    case 42:
        if mode == .light {
            platformImageName = "NokiaNGageLogo"
        } else {
            platformImageName = "NokiaNGageLogoInverse"
        }
    case 66:
        if mode == .light {
            platformImageName = "Atari5200Logo"
        } else {
            platformImageName = "Atari5200LogoInverse"
        }
    case 67:
        if mode == .light {
            platformImageName = "MattelIntelliVisionLogo"
        } else {
            platformImageName = "MattelIntelliVisionLogoInverse"

        }
        
    case 9:
        if mode == .light {
            platformImageName = "SonyPlaystation3Logo"
        } else {
        platformImageName = "SonyPlaystation3LogoInverse"
        }
    case 46:
        if mode == .light {
            platformImageName = "SonyPSVitaLogo"
        } else {
            platformImageName = "SonyPSVitaLogoInverse"

        }
    case 48:
        if mode == .light {
            platformImageName = "SonyPlaystation4Logo"
        } else {
            platformImageName = "SonyPlaystation4LogoInverse"

        }
    case 49:
        if mode == .light {
            platformImageName = "XBoxOneLogo"
        } else {
            platformImageName = "XBoxOneLogoInverse"
        }
    case 61:
        platformImageName = "AtariLynxLogo"
    case 12:
        if mode == .light {
            platformImageName = "XBox360Logo"
        } else {
            platformImageName = "XBox360LogoInverse"
        }
    case 167:
        if mode == .light {
            platformImageName = "SonyPlaystation5Logo"
        } else {
            platformImageName = "SonyPlaystation5LogoInverse"

        }
    case 137:
        if mode == .light {
            platformImageName = "NewNintendo3DSLogo"
        } else {
            platformImageName = "NewNintendo3DSLogoInverse"

        }
        
    case 7:
        platformImageName = "SonyPlaystationLogo"
    case 80:
        if mode == .light {
        platformImageName = "NeoGeoLogo"
        } else {
            platformImageName = "NeoGeoLogoInverse"

        }
    case 84:
        platformImageName = "SegaSG1000Logo"
    
        
        
    case 57:
        if mode == .light {
            platformImageName = "WonderSwanLogo"
        } else {
            platformImageName = "WonderSwanLogoInverse"

        }
        
    case 169:
        if mode == .light {
            platformImageName = "XBoxSeriesLogo"
        } else {
            platformImageName = "XBoxSeriesLogoInverse"

        }
    case 5:
        platformImageName = "NintendoWiiLogo"
    case 166:
        platformImageName = "PokemonMiniLogo"
    case 240:
        platformImageName = "ZeeboLogo"
    case 274:
        platformImageName = "PCFXLogo"
    case 59:
        platformImageName = "Atari2600Logo"
        
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
//        let network = Networking.shared
        
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


extension String {
    
    func removing(charactersOf string: String) -> String {
        let characterSet = CharacterSet(charactersIn: string)
        let components = self.components(separatedBy: characterSet)
        return components.joined(separator: "")
    }
    
    
    func levenshteinDistanceScore(to string: String, ignoreCase: Bool = true, trimWhiteSpacesAndNewLines: Bool = true) -> Double {

         var firstString = self
         var secondString = string

         if ignoreCase {
             firstString = firstString.lowercased()
             secondString = secondString.lowercased()
         }
         if trimWhiteSpacesAndNewLines {
             firstString = firstString.trimmingCharacters(in: .whitespacesAndNewlines)
             secondString = secondString.trimmingCharacters(in: .whitespacesAndNewlines)
         }

         let empty = [Int](repeating:0, count: secondString.count)
         var last = [Int](0...secondString.count)

         for (i, tLett) in firstString.enumerated() {
             var cur = [i + 1] + empty
             for (j, sLett) in secondString.enumerated() {
                 cur[j + 1] = tLett == sLett ? last[j] : Swift.min(last[j], last[j + 1], cur[j])+1
             }
             last = cur
         }

         // maximum string length between the two
         let lowestScore = max(firstString.count, secondString.count)

         if let validDistance = last.last {
             return  1 - (Double(validDistance) / Double(lowestScore))
         }

         return 0.0
     }
    
    
}



extension UIImageView {
    
    //// Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    func setImageAnimated(imageUrl:URL, placeholderImage:UIImage?, completed: @escaping () -> ()) {

        print("imageurl is \(imageUrl)")
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: imageUrl, placeholderImage: placeholderImage , options:SDWebImageOptions.avoidDecodeImage, completed: { (image, error, cacheType, url) in
            if cacheType == SDImageCacheType.none {
                if let superview = self.superview {
                UIView.transition(with: superview, duration: 0.2, options:  [.transitionCrossDissolve ,.allowUserInteraction, .curveEaseIn], animations: {
                    self.image = image
//                    print("is animated", image)
                    completed()

                }, completion: { (completed) in
                    

                })
                }
            }
            else {
                self.image = image
//                print("not animated", image)
                print("image downloaded sd_setImage")
                completed()

            }
            
            if error != nil {
                print("error = (\(String(describing: error))")
            }
            

        })
      
    }
    
    func loadImage(from urlString: String, completed: @escaping () -> ()) {
        let activityIndicator = self.activityIndicator

                DispatchQueue.main.async {
                    activityIndicator.startAnimating()
                }
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) {
            DispatchQueue.main.async {
                
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
            }
            self.image = cacheImage
            print("Image already downloaded, using cached image")

            return
        }

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print("Couldn't download image: \(error)")
                return
            }

            guard let data = data else { return }
            let image = UIImage(data: data)
            print("Downloading image")
            imageCache.setObject(image!, forKey: urlString as AnyObject)

            DispatchQueue.main.async {
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
                self.image = image

            }

        }.resume()
    
        
        print("urlString = \(urlString)")
        let imageURL = URL(string: urlString)!

        DispatchQueue.global().async { [weak self] in

            if let data = try? Data(contentsOf: imageURL) {

                if let image = UIImage(data: data) {

                    DispatchQueue.main.async {
//                        activityIndicator.stopAnimating()
//                        activityIndicator.removeFromSuperview()
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

extension UITableViewCell {
    var cellActionButtonLabel: UILabel? {
        superview?.subviews
            .filter { String(describing: $0).range(of: "UISwipeActionPullView") != nil }
            .flatMap { $0.subviews }
            .filter { String(describing: $0).range(of: "UISwipeActionStandardButton") != nil }
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }.first
    }
    
    
    func formatPrettyPlatformNameToID(platformName: String) -> Int {
      
            switch platformName {
            case "3DO Interactive Multiplayer"                  :   return 50
            case "Amiga CD32"                                   :   return 114
            case "Atari 2600"                                   :   return 59
            case "Atari 5200"                                   :   return 66
            case "Atari 7800"                                   :   return 60
            case "Atari Jaguar"                                 :   return 62
            case "Atari Lynx"                                   :   return 61
            case "ColecoVision"                                 :   return 68
            case "Fairchild Channel F"                          :   return 127
            case "Intellivision"                                :   return 67
            case "Magnavox Odyssey"                             :   return 88
            case "Microsoft Xbox"                               :   return 11
            case "Microsoft Xbox 360"                           :   return 12
            case "Microsoft Xbox One"                           :   return 49
            case "Microsoft Xbox Series S|X"                    :   return 169
            case "Neo Geo AES"                                  :   return 80
            case "Neo Geo CD"                                   :   return 136
            case "Neo Geo Pocket"                               :   return 119
            case "Neo Geo Pocket Color"                         :   return 120
            case "Nintendo Game & Watch"                        :   return 307
            case "Nintendo Entertainment System (NES)"          :   return 18
            case "Super Nintendo Entertainment System (SNES)"   :   return 19
            case "Nintendo Virtual Boy"                         :   return 87
            case "Nintendo 64"                                  :   return 4
            case "Nintendo GameCube"                            :   return 21
            case "Nintendo Wii"                                 :   return 5
            case "Nintendo Wii U"                               :   return 41
            case "Nintendo Switch"                              :   return 130
            case "Nintendo Game Boy"                            :   return 33
            case "Nintendo Game Boy Color"                      :   return 22
            case "Nintendo Game Boy Advance"                    :   return 24
            case "Nintendo DS"                                  :   return 20
            case "Nintendo DSi"                                 :   return 159
            case "Nintendo 3DS"                                 :   return 37
            case "New Nintendo 3DS"                             :   return 137
            case "Nintendo Pokémon Mini"                        :   return 166
            case "Nokia N-Gage"                                 :   return 42
            case "Nuon"                                         :   return 122
            case "TurboGrafx-16/PC Engine"                      :   return 86
            case "PC Engine SuperGrafx"                         :   return 128
            case "Philips CD-i"                                 :   return 117
            case "Sega SG-1000"                                 :   return 84
            case "Sega Master System"                           :   return 64
            case "Sega Genesis/Mega Drive"                      :   return 29
            case "Sega CD"                                      :   return 78
            case "Sega 32X"                                     :   return 30
            case "Sega Saturn"                                  :   return 32
            case "Sega Dreamcast"                               :   return 23
            case "Sega Game Gear"                               :   return 35
            case "Sega Pico"                                    :   return 339
            case "Sony PlayStation"                             :   return 7
            case "Sony PlayStation 2"                           :   return 8
            case "Sony PlayStation 3"                           :   return 9
            case "Sony PlayStation 4"                           :   return 48
            case "Sony PlayStation 5"                           :   return 167
            case "Sony PlayStation Portable (PSP)"              :   return 38
            case "Sony PlayStation Vita"                        :   return 46
            case "Vectrex"                                      :   return 70
            case "WonderSwan"                                   :   return 57
            case "WonderSwan Color"                             :   return 123
            case "Zeebo"                                        :   return 240
            default                                             :   return 18
            }
       
    }
}


extension UIImage {
    
    func addBackgroundCircle(_ color: UIColor?) -> UIImage? {

        let circleDiameter = max(size.width * 2, size.height * 2)
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)

        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5

        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { ctx in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }

        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
    
    
    func getImageWithBlur(blurAmount: Int) -> UIImage?{
        let context = CIContext(options: nil)

        guard let currentFilter = CIFilter(name: "CIGaussianBlur") else {
            return nil
        }
        let beginImage = CIImage(image: self)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(blurAmount, forKey: "inputRadius")
        guard let output = currentFilter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        return UIImage(cgImage: cgimg)
    }

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
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
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
    
    func setPlatformIcon(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
        
        var platformImageName: String = ""
        print("setPlatformIcon()")
//        print("\(platformID)")
        switch platformID! {
            case 18:
                
                if mode == .light {
                    //Light Mode
                    platformImageName = "NESLogo"
                } else {
                    //Dark Mode
                    platformImageName = "NESLogoInverse"
                    
                }
                
            case 19:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SNESLogo1"
                } else {
                    //Dark Mode
                    platformImageName = "SNESLogo1Inverse"
                    
                }
            case 4:
                if mode == .light {
                    //Light Mode
                    platformImageName = "N64Logo"
                } else {
                    //Dark Mode
                    platformImageName = "N64LogoInverse"
                    
                }
            case 21:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GCLogo"
                } else {
                    //Dark Mode
                    platformImageName = "GCLogoInverse"
                    
                }
            case 33:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GBLogo"
                } else {
                    //Dark Mode
                    platformImageName = "GBLogoInverse"
                    
                }
            case 24:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GBALogo"
                } else {
                    //Dark Mode
                   platformImageName = "gbaLogoInverse"
                    
                }
            case 29:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SegaGenesisLogo"
                } else {
                    //Dark Mode
                    platformImageName = "SegaGenesisLogoInverse"
                    
                }
            case 78:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SegaCDLogo"
                } else {
                    //Dark Mode
                    platformImageName = "SegaCDLogoInverse"
                    
                }
                
        case 339:
            platformImageName = "SegaPicoLogo"
            
        case 8:
            if mode == .light {
            platformImageName = "SonyPlaystation2Logo"
            } else {
                
                platformImageName = "SonyPlaystation2LogoInverse"
            }
            
        case 88:
            platformImageName = "OdysseyLogo"
            
        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            platformImageName = "SegaGameGearLogo"
        case 123:
            if mode == .light {
            platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"

            }
        
        case 62:
            platformImageName = "AtariJaguarLogo"
            
        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
            
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 23:
            if mode == .light {
            platformImageName = "SegaDreamcastLogo"
            } else {
            platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }
            
        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }
            
        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
            platformImageName = "FairchildChannelFLogo"
            } else {
            platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"
                
            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
        
        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            platformImageName = "PhilipsCDiLogo"
        case 122:
            if mode == .light {
            platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"

            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"

            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"

            }

        case 307:
            if mode == .light {
            platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"

            }
            
        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
            platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"

            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"

            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"

            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"

            }
            
        case 7:
            platformImageName = "SonyPlaystationLogo"
        case 80:
            if mode == .light {
            platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"

            }
        case 84:
            platformImageName = "SegaSG1000Logo"
        
            
            
        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"

            }
            
        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"

            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"
            
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
    
    
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
       return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
   }
    
    func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else
        {
            print("ciImage failed")
         return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {
            print("outputImage failed")
            return nil
        }
        
        return UIImage(ciImage: outputImage)
        
        
    }
    
    func fetchAddToButtonIcon(platformID: Int, owned: Bool) -> String {
        print("fetching add to button icon, current platform is:", platformID)
        var imageName: String = ""
        
        switch platformID {
        
        case 240:
            if owned {
                imageName = "hdd-minus-inversed"
            } else {
                imageName = "hdd-plus-inversed"

            }
        
        case 57, 123:
            if owned {
                imageName = "wonderswan-minus-inversed"
            } else {
                imageName = "wonderswan-plus-inversed"

            }
        
        case 70:
            if owned {
                imageName = "vectrex-minus-inversed"
            } else {
                imageName = "vectrex-plus-inversed"

            }
        
        
        case 86, 128:
            if owned {
                imageName = "turbografx-minus-inversed"
            } else {
                imageName = "turbografx-plus-inversed"

            }
        
        case 42:
            if owned {
                imageName = "ngage-minus-inversed"
            } else {
                imageName = "ngage-plus-inversed"

            }
        case 61:
            if owned {
                imageName = "atarilynx-minus-inversed"
            } else {
                imageName = "atarilynx-plus-inversed"

            }
        case 66:
            if owned {
                imageName = "atari5200-minus-inversed"

            } else {
                imageName = "atari5200-plus-inversed"

            }
        
        case 59, 60:
            if owned {
                imageName = "atari2600-minus-inversed"
            } else {
                imageName = "atari2600-plus-inversed"
            }
            
        case 307:
            if owned {
                imageName = "gameandwatch-minus-inversed"
            } else {
                imageName = "gameandwatch-plus-inversed"

            }
            
        case 18:
            if owned {
                imageName = "nes-minus-inversed"
            } else {
                imageName = "nes-plus-button"
            }
            
        case 19:
            if owned {
                imageName = "snes-minus-inversed"
            } else {
                imageName = "snes-plus-inversed"
            }
            
        case 4:
            if owned {
                imageName = "n64-minus-inversed"
            } else {
                imageName = "n64-plus-inversed"
            }
            
        case 87:
            if owned {
                imageName = "nvb-minus-inversed"
            } else {
                imageName = "nvb-plus-inversed"
            }
        
        case 20, 159, 37, 137:
            if owned {
                imageName = "nds-minus-inversed"
            } else {
                imageName = "nds-plus-inversed"
            }
            
        case 21:
            if owned {
                imageName = "gc-minus-inversed"
            } else {
                imageName = "gc-plus-inversed"
            }
            
        case 33, 22:
            if owned {
                imageName = "gb-minus-inversed"
            } else {
                imageName = "gb-plus-inversed"
            }
        case 24:
            if owned {
                imageName = "gba-minus-inversed"
            } else {
                imageName = "gba-plus-inversed"
            }
            
        case 166:
            if owned {
                imageName = "nintendopokemonmini-minus-inversed"
            } else {
                imageName = "nintendopokemonmini-plus-inversed"
            }
            
        case 130:
            if owned {
                imageName = "switch-minus-inversed"
            } else {
                imageName = "switch-plus-inversed"
            }
        case 64:
            if owned {
                imageName = "sms-minus-inversed"
            } else {
                imageName = "sms-plus-inversed"
            }
            
        case 35:
            if owned {
                imageName = "gamegear-minus-inversed"
            } else {
                imageName = "gamegear-plus-inversed"
            }
        case 30:
            if owned {
                imageName = "32x-minus-inversed"
            } else {
                imageName = "32x-plus-inversed"
            }
            
        case 62:
            if owned {
                imageName = "atarijaguar-minus-inversed"
            } else {
                imageName = "atarijaguar-plus-inversed"

                
            }
            
        case 29:
            if owned {
                imageName = "genesis-minus-inversed"
            } else {
                imageName = "genesis-plus-inversed"
            }

        case 80:
            if owned {
                imageName = "neogeo-minus-inversed"
            } else {
                imageName = "neogeo-plus-inversed"
            }
        case 78, 7, 167, 12, 49, 48, 9, 32, 117, 114, 50, 11, 23, 136, 8, 169, 5, 122, 41:
            if owned {
                imageName = "cd-minus-inversed"
            } else {
                imageName = "cd-plus-inversed"
            }
        case 84:
            if owned {
                imageName = "segasg1000-minus-inversed"
            } else {
                
                imageName = "segasg1000-plus-inversed"

            }
        
        case 339:
            if owned {
                
                imageName = "segapico-minus-inversed"
            } else {
                imageName = "segapico-plus-inversed"

            }
            
        case 38:
            if owned {
                imageName = "sonypsp-minus-inversed"
            } else {
                imageName = "sonypsp-plus-inversed"

            }
            
        case 46:
            if owned {
                imageName = "psvita-minus-inversed"
            } else {
                imageName = "psvita-plus-inversed"

            }
            
        case 68:
            if owned {
                imageName = "colecovision-minus-inversed"
            } else {
                imageName = "colecovision-plus-inversed"

            }
        case 127:
            if owned {
                imageName = "fairchild-minus-inversed"
            } else {
                imageName = "fairchild-plus-inversed"

            }
        case 67:
            if owned {
                imageName = "intellivision-minus-inversed"
            } else {
                imageName = "intellivision-plus-inversed"

            }
        case 88:
            if owned {
                imageName = "odyssey-minus-inversed"
            } else {
                imageName = "odyssey-plus-inversed"

            }
        case 119, 120:
            if owned {
                imageName = "neogeopocket-minus-inversed"
            } else {
                imageName = "neogeopocket-plus-inversed"

            }
        default:
            print("Invalid Platform")
            
        }
        return imageName

    }
    
    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {

        var platform = PlatformObject(id: 0, abbreviation: nil, alternativeName: nil, category: nil, createdAt: nil, generation: nil, name: "", platformLogo: nil, platformFamily: nil, slug: nil, updatedAt: nil, url: nil, versions: nil, checksum: nil)
        
        let platforms = network.platforms
        
        for platformObject in platforms {
            
            if platformObject.id == platformID {
                
                 platform = PlatformObject(id: platformObject.id, abbreviation: platformObject.abbreviation, alternativeName: platformObject.alternativeName, category: platformObject.category, createdAt: platformObject.createdAt, generation: platformObject.generation, name: platformObject.name, platformLogo: nil, platformFamily: platformObject.platformFamily, slug: platformObject.slug, updatedAt: platformObject.updatedAt, url: platformObject.url, versions: nil, checksum: platformObject.checksum)
               
            }
        }
        
        return platform
        
    }
    
    func setPlatformIconName(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {

        var platformImageName: String = ""
        print("setPlatformIcon()")
//        print("\(platformID)")
        switch platformID! {
            case 18:

                if mode == .light {
                    //Light Mode
                    platformImageName = "NESLogo"
                } else {
                    //Dark Mode
                    platformImageName = "NESLogoInverse"

                }

            case 19:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SNESLogo1"
                } else {
                    //Dark Mode
                    platformImageName = "SNESLogo1Inverse"

                }
            case 4:
                if mode == .light {
                    //Light Mode
                    platformImageName = "N64Logo"
                } else {
                    //Dark Mode
                    platformImageName = "N64LogoInverse"

                }
            case 21:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GCLogo"
                } else {
                    //Dark Mode
                    platformImageName = "GCLogoInverse"

                }
            case 33:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GBLogo"
                } else {
                    //Dark Mode
                    platformImageName = "GBLogoInverse"

                }
            case 24:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GBALogo"
                } else {
                    //Dark Mode
                   platformImageName = "gbaLogoInverse"

                }
            case 29:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SegaGenesisLogo"
                } else {
                    //Dark Mode
                    platformImageName = "SegaGenesisLogoInverse"

                }
            case 78:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SegaCDLogo"
                } else {
                    //Dark Mode
                    platformImageName = "SegaCDLogoInverse"

                }

        case 339:
            platformImageName = "SegaPicoLogo"

        case 8:
            if mode == .light {
            platformImageName = "SonyPlaystation2Logo"
            } else {

                platformImageName = "SonyPlaystation2LogoInverse"
            }

        case 88:
            platformImageName = "OdysseyLogo"

        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            platformImageName = "SegaGameGearLogo"
        case 123:
            if mode == .light {
            platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"

            }

        case 62:
            platformImageName = "AtariJaguarLogo"

        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
        case 23:
            if mode == .light {
            platformImageName = "SegaDreamcastLogo"
            } else {
            platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }

        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }

        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
            platformImageName = "FairchildChannelFLogo"
            } else {
            platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"

            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
        case 22:
            platformImageName = "GameBoyColorLogo"

        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            platformImageName = "PhilipsCDiLogo"
        case 122:
            if mode == .light {
            platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"

            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"

            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"

            }
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 307:
            if mode == .light {
            platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"

            }

        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
            platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"

            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"

            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"

            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"

            }

        case 7:
            platformImageName = "SonyPlaystationLogo"
        case 80:
            if mode == .light {
            platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"

            }
        case 84:
            platformImageName = "SegaSG1000Logo"



        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"

            }

        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"

            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"

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
      func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
          item: subview,
          attribute: .centerY,
          relatedBy: .equal,
          toItem: self,
          attribute: .centerY,
          multiplier: 1.0,
          constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
          item: subview,
          attribute: .centerX,
          relatedBy: .equal,
          toItem: self,
          attribute: .centerX,
          multiplier: 1.0,
          constant: 0)
        
        let heightContraint = NSLayoutConstraint(
          item: subview,
          attribute: .height,
          relatedBy: .equal,
          toItem: nil,
          attribute: .notAnAttribute,
          multiplier: 1.0,
          constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
          item: subview,
          attribute: .width,
          relatedBy: .equal,
          toItem: nil,
          attribute: .notAnAttribute,
          multiplier: 1.0,
          constant: subview.frame.width)
        
        addConstraints([
          horizontalContraint,
          verticalContraint,
          heightContraint,
          widthContraint])
        
      }
      
      func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
          item: subview,
          attribute: .top,
          relatedBy: .equal,
          toItem: self,
          attribute: .top,
          multiplier: 1.0,
          constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
          item: subview,
          attribute: .bottom,
          relatedBy: .equal,
          toItem: self,
          attribute: .bottom,
          multiplier: 1.0,
          constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
          item: subview,
          attribute: .leading,
          relatedBy: .equal,
          toItem: self,
          attribute: .leading,
          multiplier: 1.0,
          constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
          item: subview,
          attribute: .trailing,
          relatedBy: .equal,
          toItem: self,
          attribute: .trailing,
          multiplier: 1.0,
          constant: 0)
        
        addConstraints([
          topContraint,
          bottomConstraint,
          leadingContraint,
          trailingContraint])
      }
      
    
}



extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    
    
}

extension UICollectionReusableView {
    
    func changePlatformNameToID(platformName: String) -> Int {
    
    let network = Networking.shared
    let platforms = network.platforms
    
    for platform in platforms {
        if platform.name == platformName {
            return platform.id
        }
        
    }
    
    return 0

    
}
    
    func setPlatformIcon(platformID: Int?, mode: UIUserInterfaceStyle?) -> String {
        
        var platformImageName: String = ""
        print("setPlatformIcon()")
//        print("\(platformID)")
        switch platformID! {
            case 18:
                
                if mode == .light {
                    //Light Mode
                    platformImageName = "NESLogo"
                } else {
                    //Dark Mode
                    platformImageName = "NESLogoInverse"
                    
                }
                
            case 19:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SNESLogo1"
                } else {
                    //Dark Mode
                    platformImageName = "SNESLogo1Inverse"
                    
                }
            case 4:
                if mode == .light {
                    //Light Mode
                    platformImageName = "N64Logo"
                } else {
                    //Dark Mode
                    platformImageName = "N64LogoInverse"
                    
                }
            case 21:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GCLogo"
                } else {
                    //Dark Mode
                    platformImageName = "GCLogoInverse"
                    
                }
            case 33:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GBLogo"
                } else {
                    //Dark Mode
                    platformImageName = "GBLogoInverse"
                    
                }
            case 24:
                if mode == .light {
                    //Light Mode
                    platformImageName = "GBALogo"
                } else {
                    //Dark Mode
                   platformImageName = "gbaLogoInverse"
                    
                }
            case 29:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SegaGenesisLogo"
                } else {
                    //Dark Mode
                    platformImageName = "SegaGenesisLogoInverse"
                    
                }
            case 78:
                if mode == .light {
                    //Light Mode
                    platformImageName = "SegaCDLogo"
                } else {
                    //Dark Mode
                    platformImageName = "SegaCDLogoInverse"
                    
                }
                
        case 339:
            platformImageName = "SegaPicoLogo"
            
        case 8:
            if mode == .light {
            platformImageName = "SonyPlaystation2Logo"
            } else {
                
                platformImageName = "SonyPlaystation2LogoInverse"
            }
            
        case 88:
            platformImageName = "OdysseyLogo"
            
        case 68:
            platformImageName = "ColecovisionLogo"
        case 35:
            platformImageName = "SegaGameGearLogo"
        case 123:
            if mode == .light {
            platformImageName = "WonderSwanColorLogo"
            } else {
                platformImageName = "WonderSwanColorLogoInverse"
            }
        case 136:
            if mode == .light {
                platformImageName = "NeoGeoCDLogo"
            } else {
                platformImageName = "NeoGeoCDLogoInverse"

            }
        
        case 62:
            platformImageName = "AtariJaguarLogo"
            
        case 87:
            platformImageName = "VirtualBoyLogo"
        case 89:
            platformImageName = "MicrovisionLogo"
        case 128:
            platformImageName = "SuperGrafxLogo"
        case 23:
            if mode == .light {
            platformImageName = "SegaDreamcastLogo"
            } else {
            platformImageName = "SegaDreamcastLogoInverse"
            }
        case 70:
            if mode == .light {
                platformImageName = "VectrexLogo"
            } else {
                platformImageName = "VectrexLogoInverse"
            }
            
        case 119:
            if mode == .light {
                platformImageName = "NeoGeoPocketLogo"
            } else {
                platformImageName = "NeoGeoPocketLogoInverse"
            }
            
        case 124:
            if mode == .light {
                platformImageName = "SwanCrystalLogo"
            } else {
                platformImageName = "SwanCrystalLogoInverse"
            }
        case 127:
            if mode == .light {
            platformImageName = "FairchildChannelFLogo"
            } else {
            platformImageName = "FairchildChannelFLogoInverse"
            }
        case 130:
            if mode == .light {
                platformImageName = "NintendoSwitchLogo"
            } else {
                platformImageName = "NintendoSwitchLogoInverse"
            }
        case 138:
            if mode == .light {
                platformImageName = "VC4000Logo"
                
            } else {
                platformImageName = "VC4000LogoInverse"
            }
        case 159:
            if mode == .light {
                platformImageName = "NintendoDSiLogo"
            } else {
                platformImageName = "NintendoDSiLogoInverse"
            }
        case 11:
            platformImageName = "XBoxLogo"
        case 50:
            if mode == .light {
                platformImageName = "3DOLogo"
            } else {
                platformImageName = "3DOLogoInverse"
            }
        case 60:
            if mode == .light {
                platformImageName = "Atari7800Logo"
            } else {
                platformImageName = "Atari7800LogoInverse"
            }
        case 30:
            if mode == .light {
                platformImageName = "Sega32XLogo"
            } else {
                platformImageName = "Sega32XLogoInverse"
            }
        case 22:
            platformImageName = "GameBoyColorLogo"
        
        case 41:
            platformImageName = "NintendoWiiULogo"
        case 114:
            if mode == .light {
                platformImageName = "AmigaCD32Logo"
            } else {
                platformImageName = "AmigaCD32LogoInverse"
            }
        case 117:
            platformImageName = "PhilipsCDiLogo"
        case 122:
            if mode == .light {
            platformImageName = "NuonLogo"
            } else {
                platformImageName = "NuonLogoInverse"
            }
        case 120:
            if mode == .light {
                platformImageName = "NeoGeoPocketColorLogo"
            } else {
                platformImageName = "NeoGeoPocketColorLogoInverse"

            }
        case 37:
            if mode == .light {
                platformImageName = "Nintendo3DSLogo"
            } else {
                platformImageName = "Nintendo3DSLogoInverse"

            }
        case 64:
            platformImageName = "SegaMasterSystemLogo"
        case 38:
            if mode == .light {
                platformImageName = "SonyPSPLogo"
            } else {
                platformImageName = "SonyPSPLogoInverse"

            }
        case 86:
            platformImageName = "TurboGrafx16Logo"
        case 307:
            if mode == .light {
            platformImageName = "GameAndWatchLogo"
            } else {
                platformImageName = "GameAndWatchLogoInverse"
            }
        case 20:
            if mode == .light {
                platformImageName = "NintendoDSLogo"
            } else {
                platformImageName = "NintendoDSLogoInverse"
            }
        case 32:
            platformImageName = "SegaSaturnLogo"
        case 42:
            if mode == .light {
                platformImageName = "NokiaNGageLogo"
            } else {
                platformImageName = "NokiaNGageLogoInverse"
            }
        case 66:
            if mode == .light {
                platformImageName = "Atari5200Logo"
            } else {
                platformImageName = "Atari5200LogoInverse"
            }
        case 67:
            if mode == .light {
                platformImageName = "MattelIntelliVisionLogo"
            } else {
                platformImageName = "MattelIntelliVisionLogoInverse"

            }
            
        case 9:
            if mode == .light {
                platformImageName = "SonyPlaystation3Logo"
            } else {
            platformImageName = "SonyPlaystation3LogoInverse"
            }
        case 46:
            if mode == .light {
                platformImageName = "SonyPSVitaLogo"
            } else {
                platformImageName = "SonyPSVitaLogoInverse"

            }
        case 48:
            if mode == .light {
                platformImageName = "SonyPlaystation4Logo"
            } else {
                platformImageName = "SonyPlaystation4LogoInverse"

            }
        case 49:
            if mode == .light {
                platformImageName = "XBoxOneLogo"
            } else {
                platformImageName = "XBoxOneLogoInverse"
            }
        case 61:
            platformImageName = "AtariLynxLogo"
        case 12:
            if mode == .light {
                platformImageName = "XBox360Logo"
            } else {
                platformImageName = "XBox360LogoInverse"
            }
        case 167:
            if mode == .light {
                platformImageName = "SonyPlaystation5Logo"
            } else {
                platformImageName = "SonyPlaystation5LogoInverse"

            }
        case 137:
            if mode == .light {
                platformImageName = "NewNintendo3DSLogo"
            } else {
                platformImageName = "NewNintendo3DSLogoInverse"

            }
            
        case 7:
            platformImageName = "SonyPlaystationLogo"
        case 80:
            if mode == .light {
            platformImageName = "NeoGeoLogo"
            } else {
                platformImageName = "NeoGeoLogoInverse"

            }
        case 84:
            platformImageName = "SegaSG1000Logo"
        
            
            
        case 57:
            if mode == .light {
                platformImageName = "WonderSwanLogo"
            } else {
                platformImageName = "WonderSwanLogoInverse"

            }
            
        case 169:
            if mode == .light {
                platformImageName = "XBoxSeriesLogo"
            } else {
                platformImageName = "XBoxSeriesLogoInverse"

            }
        case 5:
            platformImageName = "NintendoWiiLogo"
        case 166:
            platformImageName = "PokemonMiniLogo"
        case 240:
            platformImageName = "ZeeboLogo"
        case 274:
            platformImageName = "PCFXLogo"
        case 59:
            platformImageName = "Atari2600Logo"
            
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
    
    
}
