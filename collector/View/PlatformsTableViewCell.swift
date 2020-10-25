//
//  PlatformsTableViewCell.swift
//  collector
//
//  Created by Brian on 10/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class PlatformsTableViewCell: UITableViewCell {
    @IBOutlet weak var platformBanner: UIImageView!
    @IBOutlet weak var ownedTotalLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
