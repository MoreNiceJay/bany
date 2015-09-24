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

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        
        self.actInd.startAnimating()
        self.actInd.hidden = false
    
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        let userPasswordConfirm = passwordConfirmationTextField.text
        
        let nickname = emailTextField.text
        let profileIamge = profilePhotoImageView.image
        //빈칸 확인
        if (userEmail!.isEmpty || userPassword!.isEmpty || userPasswordConfirm!.isEmpty)
        {
            
            let alert = UIAlertView(title: "Invalid", message: "All fields must be filled", delegate: self, cancelButtonTitle: "Ok")
            
            alert.show()

        
        }else {
            //굿투고

            //이메일과 패스워드 길이 확인
            if (userEmail?.utf16.count < 7) {
                
                let alert = UIAlertView(title: "Invalid", message: "email address must be valid ", delegate: self, cancelButtonTitle: "OK")
                
                alert.show()
            }else if (userPassword?.utf16.count < 6){
                
                //이메일이 8자리가 안될경우
                
                let alert = UIAlertView(title: "Invalid", message: "Password must be more than 6 characters", delegate: self, cancelButtonTitle: "OK")
                alert.show()

            } else {
                //굿투고
                
                //패스워드 두번 체크
                if(userPassword != userPasswordConfirm)
                {
                    let alert = UIAlertView(title: "Invalid", message: "Password are not mached", delegate: self, cancelButtonTitle: "Ok")
                    
                    alert.show()
                    
                
                }else {
                    //굿투 고
                    
                    
                    //파스저장
                    let user = PFUser()
                    user.username = userEmail
                    user.password = userPassword
                    user.email = userEmail
                    user.setObject(nickname!, forKey: "nickName")

                    
                    
                    if( profilePhotoImageView.image != UIImage(named: "AvatarPlaceholder")) {
                    let scaledImage = self.scaleImageWith(profileIamge!, newSize: CGSizeMake(50, 50))
                    let profileImageData = UIImagePNGRepresentation(scaledImage)
                    let profileImageFile = PFFile(name: "profile.png", data : profileImageData!)
                    }
                    
                    user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                        if(!success)
                        {
                            let alert = UIAlertView(title: "Invalid", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "Ok")
                            
                            alert.show()
                            
                        }else {
                        
                            
                        var myAlert = UIAlertController(title: "Welcome", message: "Succesully signed up!                         Plese go check email verificatoin", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                            
                            myAlert.addAction(okAction)
                            
                            self.presentViewController(myAlert, animated: true, completion: nil)
                        
                        }
                    })
                    
                    
                
                    }
            }
                        }
            
        self.actInd.stopAnimating()
        self.actInd.hidesWhenStopped = true

        
            
        }
    

    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
}


/*
let userMessage = "good"

var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)

let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)

myAlert.addAction(okAction)

self.presentViewController(myAlert, animated: true, completion: nil)

*/

