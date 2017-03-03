//
//  MyTableViewCell.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-23.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var energyValueLabel: UILabel!
    
    var foodProduct: FoodProduct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
