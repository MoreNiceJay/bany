//
//  MainTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 9/30/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class MainTVCE: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var viewCountingLabel: UILabel!
    @IBOutlet weak var likeCountingLabel: UILabel!
    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
