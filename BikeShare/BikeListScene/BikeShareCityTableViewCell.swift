//
//  BikeShareCityTableViewCell.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

class BikeShareCityTableViewCell: UITableViewCell {

    @IBOutlet weak var bikeShareName: UILabel!
    @IBOutlet weak var bikeShareLocation: UILabel!
    @IBOutlet weak var bikeShareLatitude: UILabel!
    @IBOutlet weak var bikeShareLongitude: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
