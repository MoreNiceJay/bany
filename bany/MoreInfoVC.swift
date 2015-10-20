//
//  MoreInfoVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/25/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MoreInfoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var lastNameTextFiled: UITextField!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    
//    @IBAction func sendbuttonTapped(sender: AnyObject) {
//        
//        startActivityIndicator()
//        
//        
//        
//        if (lastName.isEmpty || firstName.isEmpty || nickName.isEmpty){
//           
//            alert("Invalid", message : "All fields must be filled")
//            buttonEnabled(skipButton)
//            buttonEnabled(saveButton)
//            stopActivityIndicator()
//        }else{
//            
//            if !(nickName.utf16.count <= 12 && nickName.utf16.count >= 3 ) {
//                // 3보다 크고 16보다 작은게 아니라면
//                alert("Invalid", message : "nickname 3 ~ 12")
//                buttonEnabled(skipButton)
//                buttonEnabled(saveButton)
//                stopActivityIndicator()
//                
//            }else{
//                //ㅇㅋ
//                
//                if !(firstName.utf16.count <= 16 && firstName.utf16.count >= 2 ) {
//                    
//                    alert("Invalid", message : "first name 2 ~ 16")
//                    buttonEnabled(skipButton)
//                    buttonEnabled(saveButton)
//                    stopActivityIndicator()
//
//                   
//                    
//                }else{
//                    
//                     if !(lastName.utf16.count <= 16 && lastName.utf16.count >= 1 ) {
//                        
//                        alert("Invalid", message : "lastname 1 ~ 16")
//                        buttonEnabled(skipButton)
//                        buttonEnabled(saveButton)
//                        stopActivityIndicator()
//
//                        
//                        
//                        
//                     }else{
//                        //굿투고
//                    
//
//                
//                //파스저장
//                let  user = PFUser.currentUser()!
//                
//                user.setObject(firstName, forKey: "firstName")
//                user.setObject(lastName, forKey: "lastName")
//                user.setObject(nickName, forKey: "nickName")
//                //닉네임 있는지 체크 파스 쿼리 던져야함
//                if( profilePhotoImageView.image != UIImage(named: "AvatarPlaceholder")) {
//                    let scaledImage = scaleImageWith(profileIamge, newSize: CGSizeMake(50, 50))
//                    let profileImageData = UIImagePNGRepresentation(scaledImage)
//                    let profileImageFile = PFFile(name: "profile.png", data : profileImageData!)
//                    
//                    user.setObject(profileImageFile, forKey: "profile_picture")
//                } //else{
//                
//                //이미지가 아바타 이미지일 경우
//                //    print("노이미지")
//                //  }
//                
//                user.saveInBackgroundWithBlock { (success, error) -> Void in
//                    self.stopActivityIndicator()
//                    
//                    if (error != nil)
//                    {
//                        self.alert("alert", message: (error?.localizedDescription)!)
//                    }
//                    
//                    if(success) {
//                        
//                        self.performSegueWithIdentifier("moreInfoToMoreInfoContact", sender: self)
//                        
//                        
//                        
//                        self.alert("Success", message: "Your information save in your account")
//                        
//                    }
//                    }
//                    }
//                }
//            }
//        }
//            }
//
//  
//    
//
//        func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
//            
//            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//            image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
//            let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return newImage
//}
//        
//    
//    func startActivityIndicator() {
//        self.actInd.hidden = false
//        self.actInd.startAnimating()
//        
//    }
//    
//    func stopActivityIndicator() {
//        self.actInd.hidden = true
//        self.actInd.stopAnimating()
//    }
//    
//    
//    
//    func alert(title : String, message : String) {
//        
//        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
//        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
//        myAlert.addAction(okAction)
//        self.presentViewController(myAlert, animated: true, completion: nil)
//        
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        nickNameTextField.resignFirstResponder()
//        firstNameTextFiled.resignFirstResponder()
//        lastNameTextFiled.resignFirstResponder()
//        
//        
//    }
//   
////    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
////        
////        profileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
////        
////        self.dismissViewControllerAnimated(true, completion: nil)
////    }
////    
////    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
////        self.dismissViewControllerAnimated(true, completion: nil)
////    }
////    
////    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
////        
////        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
////        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
////        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
////        UIGraphicsEndImageContext()
////        
////        return newImage
////    }
////
//    func circularImage(image : UIImageView) {
//        image.layer.cornerRadius = image.frame.size.width / 2
//        image.clipsToBounds  = true
//        image.layer.borderColor  = UIColor.whiteColor().CGColor
//        image.layer.borderWidth = 3
//    }
//
    
}
