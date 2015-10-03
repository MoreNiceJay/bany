//
//  DetailVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UIScrollViewDelegate {

    
    var parentObjectID = String()
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.sizeToFit()
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
    @IBAction func commentButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("detailToComment", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailToComment") {
            
            
            let destViewController : CommentVC = segue.destinationViewController as! CommentVC
            destViewController.parentObjectID = parentObjectID
            
        }
    }

}
