//
//  BackImage.swift
//  bany
//
//  Created by Lee Janghyup on 10/13/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class BackImage: UIViewController {

    var backImageView = UIImageView()
    
    @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       backImage.image = backImageView.image

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
