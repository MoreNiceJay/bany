//
//  SearchTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 10/3/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class SearchTVCE: UITableViewCell {

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
