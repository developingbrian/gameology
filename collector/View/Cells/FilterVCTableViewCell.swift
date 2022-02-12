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
    
}
