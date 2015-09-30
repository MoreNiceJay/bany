//
//  PasswordFindVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/27/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class PasswordFindVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let emailAddress = emailTextField.text
        
        if (emailAddress!.isEmpty)
        {
            self.alert("Error", message : "email address is not valid" )
            return
            
        }
        
        PFUser.requestPasswordResetForEmailInBackground(emailAddress!, block: { (success, error) -> Void in
            if(error != nil)
                
            {//노굿
                
                self.alert("Error", message : (error!.localizedDescription))
                
                
            }else {
                //success
                self.alert("Success", message : "message was sent to \(emailAddress)")
                
            }
        })
    }

    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }

}
