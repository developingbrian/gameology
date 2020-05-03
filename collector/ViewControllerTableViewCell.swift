//
//  ViewControllerTableViewCell.swift
//  collector
//
//  Created by Brian on 3/28/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var tableViewCoverImage: UIImageView!
    @IBOutlet weak var tableViewGameName: UILabel!
    @IBOutlet weak var tableViewGenreLabel: UILabel!
    @IBOutlet weak var tableViewAgeRatingLabel: UILabel!
    @IBOutlet weak var tableViewCompanyLabel: UILabel!
    @IBOutlet weak var tableViewReleaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
