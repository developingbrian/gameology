//
//  barcodeTableViewCell.swift
//  collector
//
//  Created by Brian on 9/17/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class BarcodeTableViewCell: UITableViewCell {
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var boxartImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
