//
//  ppTableViewCell.swift
//  bany
//
//  Created by Lee Janghyup on 9/28/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class ppTableViewCell: UITableViewCell {

    @IBOutlet weak var masterTitleLabel: UILabel!
    @IBOutlet weak var masterTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
