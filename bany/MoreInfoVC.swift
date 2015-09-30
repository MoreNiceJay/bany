//
//  MoreInfoVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/25/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MoreInfoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var lastNameTextFiled: UITextField!
    @IBOutlet weak var firstNameTextFiled: UITextField!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        
        startActivityIndicator()
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
        stopActivityIndicator()

    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }
    
    @IBAction func sendbuttonTapped(sender: AnyObject) {
        
        startActivityIndicator()
        
        let phoneNumber =  phoneNumberTextField.text!
        let lastName =  lastNameTextFiled.text!
        let firstName =  firstNameTextFiled.text!
        let nickName =  nickNameTextField.text!
        let profileIamge = profilePhotoImageView.image!
        
        
        
        //파스저장
         let  user = PFUser.currentUser()!
        
        user.setObject(firstName, forKey: "firstName")
        user.setObject(lastName, forKey: "lastName")
        user.setObject(nickName, forKey: "nickName")
        user.setObject(phoneNumber, forKey: "phoneNumber")
        //닉네임 있는지 체크 파스 쿼리 던져야함
        if( profilePhotoImageView.image != UIImage(named: "AvatarPlaceholder")) {
            let scaledImage = self.scaleImageWith(profileIamge, newSize: CGSizeMake(50, 50))
            let profileImageData = UIImagePNGRepresentation(scaledImage)
            let profileImageFile = PFFile(name: "profile.png", data : profileImageData!)
            
            user.setObject(profileImageFile, forKey: "profile_picture")
        } //else{
            
            //이미지가 아바타 이미지일 경우
       //    print("노이미지")
      //  }
        
        user.saveInBackgroundWithBlock { (success, error) -> Void in
            self.stopActivityIndicator()
        
        if (error != nil)
        {
            self.alert("alert", message: (error?.localizedDescription)!)
            }
            
            if(success) {
                
                    self.performSegueWithIdentifier("moreInfoToMain", sender: self)
                
           
                
                self.alert("Success", message: "Your information save in your account")
            
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
        profilePhotoImageView.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        firstNameTextFiled.resignFirstResponder()
        lastNameTextFiled.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        
    }

        
        
        
}
