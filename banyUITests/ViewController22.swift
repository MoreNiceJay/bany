//
//  ViewController22.swift
//  bany
//
//  Created by Lee Janghyup on 9/28/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class ViewController22: UIViewController {

    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func buttonTapped(sender: AnyObject) {
        
        var gameScore = PFObject(className:"GameScore")
        gameScore["score"] = textfield1.text
        gameScore["playerName"] = textfield2.text
        
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
}
