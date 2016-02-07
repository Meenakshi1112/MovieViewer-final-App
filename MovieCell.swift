//
//  MovieCell.swift
//  MovieViewer
//
//  Created by user115593 on 1/24/16.
//  Copyright © 2016 user115593. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var Overview: UILabel!

    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
