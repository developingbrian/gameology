//
//  FilterVCTableViewCell.swift
//  collector
//
//  Created by Brian on 10/23/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class FilterVCTableViewCell: UITableViewCell {
    @IBOutlet weak var filterChoiceLbl: UILabel!
    @IBOutlet weak var filterChoiceImage: UIImageView!
    @IBOutlet weak var platformLabel: VerticalAlignedLabel!
    
    var filterChoice : String? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
        self.tintColor = .label
        self.backgroundColor = .tertiarySystemBackground
        // Configure the view for the selected state
        if selected {
            let lightBlue = UIColorFromRGB(0x2B95CE)

            filterChoiceLbl.textColor = lightBlue
        } else {
            filterChoiceLbl.textColor = UIColor.label
        }
        
    }
    
}

extension FilterVCTableViewCell {
    
    func configureCell() {
        
        filterChoiceLbl.isHidden = true
        if let title = filterChoice {
            
            if network.sourceTag == 0 || network.sourceTag == 2 {
                filterChoiceLbl.text = filterChoice

                filterChoiceImage.isHidden = true
                filterChoiceLbl.isHidden = false
                platformLabel.isHidden = true


            }
            if network.sourceTag == 1 || network.sourceTag == 3 {
                let platformID = formatPrettyPlatformNameToID(platformName: title)
            let imageName = setPlatformIcon(platformID: platformID, mode: traitCollection.userInterfaceStyle)
                platformLabel.text = title
                platformLabel.contentMode = .bottom
            filterChoiceImage.image = UIImage(named: imageName)
                filterChoiceLbl.text = filterChoice

                filterChoiceLbl.isHidden = true
                filterChoiceImage.isHidden = false
                platformLabel.isHidden = false
                

            }

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
    
}
