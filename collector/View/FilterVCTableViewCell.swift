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
        
        
    }
    
}
