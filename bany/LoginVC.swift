//
//  FirstViewController.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class LoginVC: UIViewController {
   
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInd.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookSignUp(sender: AnyObject) {
        
        startActivityIndicator()
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"], block: { (user:PFUser?, error:NSError?) -> Void in
            
            if(error != nil)
            {
            //display an alert message
                
                self.alert("error", message : (error?.localizedDescription)!)
                
                self.stopActivityIndicator()

                
                return
            }
            
            print(user)
            print("Current user token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("Current user id = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            if(FBSDKAccessToken.currentAccessToken() != nil)
            {
                self.performSegueWithIdentifier("loginToMain", sender: self)
                
                self.stopActivityIndicator()

                //다른페이지로 확실히 이동
                //let loginNext = self.storyboard?.instantiateViewControllerWithIdentifier("LoginNextVC") as! LoginNextVC
                
                //let loginNextNav = UINavigationController(rootViewController: loginNext)
                
                //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                //appDelegate.window?.rootViewController = loginNext
            }
            
        })
        
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        
        startActivityIndicator()
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username?.utf16.count < 7 || password?.utf16.count < 6) {
           
           
            self.alert("Invalid", message : "sername must be greater then 4 and Password must be a greater then 5.")
        
        } else {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                self.actInd.stopAnimating()
                
                if((user) != nil) {
                    
                    self.alert("Success", message : "Logged In")
                    
                }else {
                    
                    self.alert("Error", message : (error?.localizedDescription)!)
                    
                    
                }
                
            })
            
            
        }
    
    }
    
    func startActivityIndicator() {
        self.actInd.hidden = false
        self.actInd.startAnimating()
        
    }
    
    func stopActivityIndicator() {
        self.actInd.hidden = true
        self.actInd.stopAnimating()
    }
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }

}

