//
//  MyPostTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 10/5/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class MyPostTVCE: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
