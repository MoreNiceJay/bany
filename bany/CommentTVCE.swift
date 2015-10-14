//
//  CommentTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 10/14/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class CommentTVCE: UITableViewCell {

    
    
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var comment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    @IBAction func editButtonTapped(sender: AnyObject) {
        
        
    }

}
