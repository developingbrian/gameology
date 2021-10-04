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
        
        filterChoiceLbl.text = filterChoice
        filterChoiceLbl.isHidden = true
        if let title = filterChoice {
            
        let platformID = formatPrettyPlatformNameToID(platformName: title)
            let imageName = setPlatformIcon(platformID: platformID, mode: traitCollection.userInterfaceStyle)
            filterChoiceImage.image = UIImage(named: imageName)
            
            print("title:", title)
            print("platformID:", platformID)
            print("imageName:", imageName)
        }
        
    }
    
}
