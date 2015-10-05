//
//  SignUpVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/24/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class SignUpVC: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    //var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.actInd.hidden = true
        

       // self.actInd.center = self.view.center
       // self.actInd.hidesWhenStopped = true
       // self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
       // view.addSubview(self.actInd)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
            
    

        
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        
       
        startActivityIndicator()
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        let userPasswordConfirm = passwordConfirmationTextField.text
        
        let nickname = emailTextField.text
        
        //빈칸 확인
        if (userEmail!.isEmpty || userPassword!.isEmpty || userPasswordConfirm!.isEmpty)
        {
            
            
            self.alert("Invalid", message : "All fields must be filled")
       
            stopActivityIndicator()

        
        }else {
            //굿투고

            //이메일과 패스워드 길이 확인
            if (userEmail?.utf16.count < 7) {
                
                
                self.alert("Invalid", message : "email address must be valid")
                
                stopActivityIndicator()
            }else if (userPassword?.utf16.count < 6){
                
                //이메일이 8자리가 안될경우
               
                
                self.alert("Invalid", message : "Password must be more than 6 characters")
                
                stopActivityIndicator()

            } else {
                //굿투고
                
                //패스워드 두번 체크
                if(userPassword != userPasswordConfirm)
                {
                    self.alert("Invalid", message : "Password are not mached")
                    
                    stopActivityIndicator()
                
                }else {
                    //굿투 고
                    
                    
                    
                    //파스저장
                    let user = PFUser()
                    user.username = userEmail
                    user.password = userPassword
                    user.email = userEmail
                    user.setObject(nickname!, forKey: "nickName")
                    
                    
                    user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                        if(!success)
                        { //저장 안될때
                            
                            let myAlert = UIAlertController(title: "Invalid", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                            myAlert.addAction(okAction)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            self.alert("Invalid", message : (error?.localizedDescription)!)
                            
                            self.stopActivityIndicator()
                            
                        }else {
                        
                            
                          
                        
                            //드뎌 성공 알럴트
                            
                            NSUserDefaults.standardUserDefaults().setObject(PFUser.currentUser()?.objectId, forKey: "objectId")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            self.performSegueWithIdentifier("11", sender: self)
                            self.alert("Welcome", message : "Succesully signed up!                         please go check email verificatoin")
                            
                            //개인정보 페이지로 보내기
                            self.stopActivityIndicator()
                            
                        
                        }
                    })
                    
                    
                    }
               

            }
            
        }
       
    }
    

    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func facebookLoginButtonTapped(sender: AnyObject) {
        
        startActivityIndicator()
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"], block: { (user:PFUser?, error:NSError?) -> Void in
            
            if(error != nil)
            {
                //display an alert message
                
                
                self.alert("Alert", message : (error?.localizedDescription)!)
                
                return
                
                    self.stopActivityIndicator()

            }
            
            print(user)
            print("Current user token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("Current user id = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            
            
            
            
            if(FBSDKAccessToken.currentAccessToken() != nil)
            {
                self.stopActivityIndicator()
                self.performSegueWithIdentifier("11", sender: self)
            }
            
        })
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
        emailTextField.resignFirstResponder()
        passwordConfirmationTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }





/*
let userMessage = "good"

var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)

let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)

myAlert.addAction(okAction)

self.presentViewController(myAlert, animated: true, completion: nil)

*/
}
