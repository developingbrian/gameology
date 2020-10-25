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
    
    @IBOutlet weak var selectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectionButtonPressed(_ sender: Any) {
        print("selection button pressed")
    }
    
}
