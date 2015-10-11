//
//  LoginNextVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class UserInfoVC: UIViewController {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            //닉네임
        if let nickname = (PFUser.currentUser()?.objectForKey("nickName") as? String){
            self.nickNameLabel.text = nickname
            
            
        }else{
            self.nickNameLabel.text = "NO NICKNAME"
        }
        
        
        
        //이메일
        if let email = (PFUser.currentUser()?.objectForKey("email") as? String){
            self.emailLabel.text = email
            
        }else{
            self.emailLabel.text = "NO EMAIL"
        }
        //전화번호
        if let phoneNumber = (PFUser.currentUser()?.objectForKey("phoneNumber") as? String){
            self.phoneNumberLabel.text = phoneNumber
            
        }else{
            self.phoneNumberLabel.text = "NO PHONE#"
        }

        //profile Pic
        if let profilePictureObject = (PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile){
            
            
            
            profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                
                
                if(imageData != nil)
                    
                {
                    
                    self.profileImageView.image = UIImage(data: imageData!)
                }        }
        }else{
            self.profileImageView.image = UIImage(named: "AvatarPlaceholder")
            
        }
        
        
        self.circularImage(profileImageView)
        
          }

    
    

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("objectId")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackground()
        
        self.performSegueWithIdentifier("logOutToLogin", sender: self)
            
            
            
            
            
            //유저에게 메세지 보내기
            
           // var myAlert = UIAlertController(title: "Logged out", message: "Logged out", preferredStyle: UIAlertControllerStyle.Alert)
            
           // let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
           // myAlert.addAction(okAction)
            
           // self.presentViewController(myAlert, animated: true, completion: nil)
      
    }

    @IBAction func changePassword(sender: AnyObject) {
        
        self.performSegueWithIdentifier("resetPassword", sender: self)
    }
    
    @IBAction func editProfileTapped(sender: AnyObject) {
        
        
        self.performSegueWithIdentifier("userInfoToEditInfo", sender: self)
        
    }
    func circularImage(image : UIImageView){
    image.layer.cornerRadius = image.frame.size.width / 2
    image.clipsToBounds = true
    image.layer.borderColor = UIColor.whiteColor().CGColor
    image.layer.borderWidth = 3
    }
  }
