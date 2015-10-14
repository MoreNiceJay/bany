//
//  MyLikeTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 10/13/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class MyLikeTVCE: UITableViewCell {

    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
