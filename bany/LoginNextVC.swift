//
//  LoginNextVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class LoginNextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            
            self.performSegueWithIdentifier("logOutToLogIn", sender: self)

            
            
            //유저에게 메세지 보내기
            
           // var myAlert = UIAlertController(title: "Logged out", message: "Logged out", preferredStyle: UIAlertControllerStyle.Alert)
            
           // let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
           // myAlert.addAction(okAction)
            
           // self.presentViewController(myAlert, animated: true, completion: nil)

            
            
        }
        
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
