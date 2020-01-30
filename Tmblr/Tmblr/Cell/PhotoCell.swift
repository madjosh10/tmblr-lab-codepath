//
//  PhotoCell.swift
//  Tmblr
//
//  Created by Joshua Madrigal on 1/30/20.
//  Copyright © 2020 Joshua Madrigal. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var tmblrImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
