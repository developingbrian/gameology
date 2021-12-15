//
//  AdvancedSearchTableViewCells.swift
//  collector
//
//  Created by Brian on 10/19/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

 class TitleSearchCell: UITableViewCell {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var background : UIView!
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    var delegate : TitlePassDelegate? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleField.addTarget(self, action: #selector(titleDidChange), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func titleDidChange() {
//        print("title changed")
        
        let title = titleField.text
        delegate?.updateTitle(title: title!)
    }
    
    func configureCell() {
        setAppearance()
        
    }
    
    func setAppearance() {
        
     
            
            if traitCollection.userInterfaceStyle == .light {
                background.backgroundColor = lightGray

            } else {
                background.backgroundColor = darkGray
            }
            
            
    
 }


 }


class PlatformSearchCell: UITableViewCell {
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: AlignedCollectionViewFlowLayout!
    var layoutDelegate : LayoutUpdateDelegate?
    
    @IBOutlet weak var background : UIView!
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    
    var selectedPlatforms : [String] = []
    var selectedPlatformsDelegate : PlatformPassDelegate? {
        didSet {
            configureCell()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        flowLayout.horizontalAlignment = .left
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
        
//        NSLayoutConstraint.activate([
//            platformsCollectionView.heightAnchor.constraint(equalToConstant: platformsCollectionView.contentSize.height)
//        ])
//        layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func platformReloadData() {
        platformsCollectionView.reloadData()
        platformsCollectionView.layoutIfNeeded()
    }
    
    func removePlatform(name: String) {
        
    }
    
    
    func configureCell() {
        setAppearance()
        
    }
    
    func setAppearance() {
        
     
            
            if traitCollection.userInterfaceStyle == .light {
                background.backgroundColor = lightGray

            } else {
                background.backgroundColor = darkGray
            }
            
            
    
 }

}


extension PlatformSearchCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("platform count for cv,", selectedPlatforms.count)
        return selectedPlatforms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "platformsCell", for: indexPath) as? PlatformsCVCell else { fatalError() }
        cell.configureCell()
        cell.index = indexPath.item
        let title = formatPrettyPlatformNameToShortName(platformName: selectedPlatforms[indexPath.item])
        
            cell.platformsBtn.setTitle(title, for: .normal)
//        print("cell should be loading")
//        print("cell index", cell.index)
//        print("cell width", cell.layer.bounds.size.width)
//        print("cell height", cell.layer.bounds.size.height)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("item", indexPath.item)

        let cell = collectionView.cellForItem(at: indexPath) as? PlatformsCVCell
        let title = (cell?.platformsBtn.title(for: .normal))!
        let prettyTitle = formatShortNameToPrettyPlatformName(platformName: title)
//        print("selected platforms count", selectedPlatforms.count)
        if selectedPlatforms.contains(prettyTitle) {
//            print("removing", prettyTitle)
            selectedPlatforms.removeAll { $0 == prettyTitle }
        }
//        print("selected platforms count", selectedPlatforms.count)
        selectedPlatformsDelegate?.updateSelectedPlatforms(platforms: selectedPlatforms)
        collectionView.reloadData()
        let index = IndexPath(row: 0, section: 1)
        layoutDelegate?.layoutIfNeeded(index: index)
    }
    
    
    
}

func formatPrettyPlatformNameToShortName(platformName: String) -> String {
  
        switch platformName {
        case "3DO Interactive Multiplayer"                  :   return "3DO"
        case "Amiga CD32"                                   :   return "CD32"
        case "Atari 2600"                                   :   return "Atari 2600"
        case "Atari 5200"                                   :   return "Atari 5200"
        case "Atari 7800"                                   :   return "Atari 7800"
        case "Atari Jaguar"                                 :   return "Jaguar"
        case "Atari Lynx"                                   :   return "Lynx"
        case "ColecoVision"                                 :   return "ColecoVision"
        case "Fairchild Channel F"                          :   return "Channel F"
        case "Intellivision"                                :   return "Intellivision"
        case "Magnavox Odyssey"                             :   return "Odyssey"
        case "Microsoft Xbox"                               :   return "Xbox"
        case "Microsoft Xbox 360"                           :   return "Xbox 360"
        case "Microsoft Xbox One"                           :   return "Xbox One"
        case "Microsoft Xbox Series S|X"                    :   return
            "Xbox S|X"
        case "Neo Geo AES"                                  :   return "Neo Geo AES"
        case "Neo Geo CD"                                   :   return "Neo Geo CD"
        case "Neo Geo Pocket"                               :   return "NG Pocket"
        case "Neo Geo Pocket Color"                         :   return "NG Pocket Color"
        case "Nintendo Game & Watch"                        :   return "Game & Watch"
        case "Nintendo Entertainment System (NES)"          :   return "NES"
        case "Super Nintendo Entertainment System (SNES)"   :   return "SNES"
        case "Nintendo Virtual Boy"                         :   return "Virtual Boy"
        case "Nintendo 64"                                  :   return "N64"
        case "Nintendo GameCube"                            :   return "GameCube"
        case "Nintendo Wii"                                 :   return "Wii"
        case "Nintendo Wii U"                               :   return "Wii U"
        case "Nintendo Switch"                              :   return "Switch"
        case "Nintendo Game Boy"                            :   return "Game Boy"
        case "Nintendo Game Boy Color"                      :   return "Game Boy Color"
        case "Nintendo Game Boy Advance"                    :   return "GBA"
        case "Nintendo DS"                                  :   return "DS"
        case "Nintendo DSi"                                 :   return "DSi"
        case "Nintendo 3DS"                                 :   return "3DS"
        case "New Nintendo 3DS"                             :   return "New 3DS"
        case "Nintendo Pokémon Mini"                        :   return "Pokémon Mini"
        case "Nokia N-Gage"                                 :   return "N-Gage"
        case "Nuon"                                         :   return "Nuon"
        case "TurboGrafx-16/PC Engine"                      :   return "TurboGrafx"
        case "PC Engine SuperGrafx"                         :   return "SuperGrafx"
        case "Philips CD-i"                                 :   return "CD-i"
        case "Sega SG-1000"                                 :   return "SG-1000"
        case "Sega Master System"                           :   return "Master System"
        case "Sega Genesis/Mega Drive"                      :   return "Genesis"
        case "Sega CD"                                      :   return "Sega CD"
        case "Sega 32X"                                     :   return "32X"
        case "Sega Saturn"                                  :   return "Saturn"
        case "Sega Dreamcast"                               :   return "Dreamcast"
        case "Sega Game Gear"                               :   return "Game Gear"
        case "Sega Pico"                                    :   return "Pico"
        case "Sony PlayStation"                             :   return "PS1"
        case "Sony PlayStation 2"                           :   return "PS2"
        case "Sony PlayStation 3"                           :   return "PS3"
        case "Sony PlayStation 4"                           :   return "PS4"
        case "Sony PlayStation 5"                           :   return "PS5"
        case "Sony PlayStation Portable (PSP)"              :   return "PSP"
        case "Sony PlayStation Vita"                        :   return "Vita"
        case "Vectrex"                                      :   return "Vectrex"
        case "WonderSwan"                                   :   return "Woderswan"
        case "WonderSwan Color"                             :   return "Wonderswan Color"
        case "Zeebo"                                        :   return "Zeebo"
        default                                             :   return ""
        }
    
}
    
    func formatShortNameToPrettyPlatformName(platformName: String) -> String {
      
            switch platformName {
            case "3DO"                 :   return "3DO Interactive Multiplayer"
            case "CD32"                                   :   return "Amiga CD32"
            case "Atari 2600"                                   :   return "Atari 2600"
            case "Atari 5200"                                   :   return "Atari 5200"
            case "Atari 7800"                                   :   return "Atari 7800"
            case "Jaguar"                                 :   return "Atari Jaguar"
            case "Lynx"                                   :   return "Atari Lynx"
            case "ColecoVision"                                 :   return "ColecoVision"
            case "Channel F"                          :   return "Fairchild Channel F"
            case "Intellivision"                                :   return "Intellivision"
            case "Odyssey"                             :   return "Magnavox Odyssey"
            case "Xbox"                               :   return "Microsoft Xbox"
            case "Xbox 360"                           :   return "Microsoft Xbox 360"
            case "Xbox One"                           :   return "Microsoft Xbox One"
            case "Xbox S|X"                    :   return
                "Microsoft Xbox Series S|X"
            case "Neo Geo AES"                                  :   return "Neo Geo AES"
            case "Neo Geo CD"                                   :   return "Neo Geo CD"
            case "NG Pocket"                               :   return "Neo Geo Pocket"
            case "NG Pocket Color"                         :   return "Neo Geo Pocket Color"
            case "Nintendo Game & Watch"                        :   return "Nintendo Game & Watch"
            case "NES"          :   return "Nintendo Entertainment System (NES)"
            case "SNES"   :   return "Super Nintendo Entertainment System (SNES)"
            case "Virtual Boy"                         :   return "Nintendo Virtual Boy"
            case "N64"                                  :   return "Nintendo 64"
            case "GameCube"                            :   return "Nintendo GameCube"
            case "Wii"                                 :   return "Nintendo Wii"
            case "Wii U"                               :   return "Nintendo Wii U"
            case "Switch"                              :   return "Nintendo Switch"
            case "Game Boy"                            :   return "Nintendo Game Boy"
            case "Game Boy Color"                      :   return "Nintendo Game Boy Color"
            case "GBA"                    :   return "Nintendo Game Boy Advance"
            case "DS"                                  :   return "Nintendo DS"
            case "DSi"                                 :   return "Nintendo DSi"
            case "3DS"                                 :   return "Nintendo 3DS"
            case "New 3DS"                             :   return "New Nintendo 3DS"
            case "Pokémon Mini"                        :   return "Nintendo Pokémon Mini"
            case "Nokia N-Gage"                                 :   return "Nokia N-Gage"
            case "Nuon"                                         :   return "Nuon"
            case "TurboGrafx"                      :   return "TurboGrafx-16/PC Engine"
            case "SuperGrafx"                         :   return "PC Engine SuperGrafx"
            case "CD-i"                                 :   return "Philips CD-i"
            case "SG-1000"                                 :   return "Sega SG-1000"
            case "Master System"                           :   return "Sega Master System"
            case "Genesis"                      :   return "Sega Genesis/Mega Drive"
            case "Sega CD"                                      :   return "Sega CD"
            case "32X"                                     :   return "Sega 32X"
            case "Saturn"                                  :   return "Sega Saturn"
            case "Dreamcast"                               :   return "Sega Dreamcast"
            case "Game Gear"                               :   return "Sega Game Gear"
            case "Sega Pico"                                    :   return "Pico"
            case "PS1"                             :   return "Sony PlayStation"
            case "PS2"                           :   return "Sony PlayStation 2"
            case "PS3"                           :   return "Sony PlayStation 3"
            case "PS4"                           :   return "Sony PlayStation 4"
            case "PS5"                           :   return "Sony PlayStation 5"
            case "PSP"              :   return "Sony PlayStation Portable (PSP)"
            case "Vita"                        :   return "Sony PlayStation Vita"
            case "Vectrex"                                      :   return "Vectrex"
            case "WonderSwan"                                   :   return "Woderswan"
            case "WonderSwan Color"                             :   return "Wonderswan Color"
            case "Zeebo"                                        :   return "Zeebo"
            default                                             :   return ""
            }
   
}

class PlatformsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var platformsBtn: UIButton!
    var index = 0
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    @IBAction func didPressPlatformBtn(_ sender: Any) {
//        print("platforms button pressed")
//
//        print("index is", index)
//                let cell = collectionView.cellForItem(at: indexPath) as? PlatformsCVCell
//        let indexPath = IndexPath(row: 0, section: 1)
//        let cell = tableView?.cellForRow(at:indexPath ) as? PlatformSearchCell
//                let title = (platformsBtn.title(for: .normal))!
//                let prettyTitle = formatShortNameToPrettyPlatformName(platformName: title)
//        if cell!.selectedPlatforms.contains(prettyTitle) {
//                    print("removing", prettyTitle)
//            cell?.selectedPlatforms.removeAll { $0 == prettyTitle }
//                }
//
//        cell?.platformsCollectionView.reloadData()
    }
    
    
    func configureCell() {
        platformsBtn.translatesAutoresizingMaskIntoConstraints = false
        platformsBtn.layer.cornerRadius = 6
        platformsBtn.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection  == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    }
    
}

class GenreSearchCell: UITableViewCell {
    @IBOutlet weak var genresCollectionView: UICollectionView!
    var layoutDelegate : LayoutUpdateDelegate?

    @IBOutlet weak var background: UIView!

    //    @IBOutlet weak var genreHeight: NSLayoutConstraint!
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    var selectedGenres : [String] = []
    var selectedGenresDelegate : GenrePassDelegate? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let flowLayout = genresCollectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout

        flowLayout?.horizontalAlignment = .left
        
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        setAppearance()
        
    }
    
    func setAppearance() {
        
     
            
            if traitCollection.userInterfaceStyle == .light {
                background.backgroundColor = lightGray

            } else {
                background.backgroundColor = darkGray
            }
            
            
    
 }

}


class GenresCVCell: UICollectionViewCell {
    @IBOutlet weak var genresBtn: UIButton!

       
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
    @IBAction func didPressGenresBtn(_ sender: Any) {
//        print("genres button pressed")
    }
    
    func configureCell() {
        genresBtn.translatesAutoresizingMaskIntoConstraints = false
        genresBtn.layer.cornerRadius = 6
        genresBtn.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection  == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    }
    
}


extension GenreSearchCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresCell", for: indexPath) as? GenresCVCell
        cell?.configureCell()
            let title = selectedGenres[indexPath.item]
        cell?.genresBtn.setTitle(title, for: .normal)
            
        return cell!
            
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("item", indexPath.item)

        let cell = collectionView.cellForItem(at: indexPath) as? GenresCVCell
        let title = (cell?.genresBtn.title(for: .normal))!
//        let prettyTitle = formatShortNameToPrettyPlatformName(platformName: title)
//        print("selected platforms count", selectedGenres.count)
        if selectedGenres.contains(title) {
//            print("removing", title)
            selectedGenres.removeAll { $0 == title }
        }
//        print("selected platforms count", selectedGenres.count)
        selectedGenresDelegate?.updateSelectedGenres(genres: selectedGenres)
        collectionView.reloadData()
        let index = IndexPath(row: 0, section: 2)
        layoutDelegate?.layoutIfNeeded(index: index)
        
    }
    
    
    
    
}




class YearSearchCell: UITableViewCell {
    @IBOutlet weak var yearsBtn: UIButton!
    @IBOutlet weak var background: UIView!

    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    var yearDelegate : YearRemovalDelegate? {
        didSet {
            configureCell()
        }
    }
    var removeYearsDelegate: PassAgeDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        yearsBtn.isHidden = true
        yearsBtn.layer.cornerRadius = 6
        yearsBtn.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection  == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didPressYearsBtn(_ sender: Any) {
        
//        print("years button pressed")
        yearsBtn.isHidden = true
        yearDelegate?.removeAllSelectedYears()
        removeYearsDelegate?.updateSearchAges(yearRange: [])
    }
    
    func configureCell() {
        setAppearance()
        
    }
    
    func setAppearance() {
        
     
            
            if traitCollection.userInterfaceStyle == .light {
                background.backgroundColor = lightGray

            } else {
                background.backgroundColor = darkGray
            }
            
            
    
 }
    
}





class DynamicHeightCollectionView: UICollectionView {
  override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize){
      self.invalidateIntrinsicContentSize()
    }
  }
  override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
