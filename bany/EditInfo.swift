//
//  EditInfo.swift
//  bany
//
//  Created by Lee Janghyup on 10/4/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class EditInfo: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var userArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoProvider()
        
        
        circularImage(profileImageView)
        
    }

    @IBAction func profileButtonTapped(sender: AnyObject) {
        
        photoCaptureButtonAction()
        
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let phoneNumber =  phoneTextField.text!
        let lastName =  lastNameTextfield.text!
        let firstName =  firstNameTextField.text!
        let nickName =  nickNameTextField.text!
        let email = emailTextField.text!
        let profilePic = profileImageView.image
      //  let profileIamge = profilePhotoImageView.image!
       // let preferPhoneNumber = phoneNumberTextField.text!
        //let preferEmailAddress = emailTextField.text!
        
        let scaledImage = self.scaleImageWith(profilePic!, newSize: CGSizeMake(320, 200))
        
        
        let imageData = UIImagePNGRepresentation(scaledImage)
        let paseImageFile = PFFile(name: "profile_image", data : imageData!)

        
        let  user = PFUser.currentUser()!
        
        user.setObject(nickName, forKey: "nickName")
        user.setObject(firstName, forKey: "firstName")
        user.setObject(lastName, forKey: "lastName")
        user.setObject(phoneNumber, forKey: "phone_number")
        user.setObject(email, forKey: "email_address")
        user.setObject(paseImageFile, forKey: "profile_picture")
        
        user.saveInBackgroundWithBlock { (success, error) -> Void in
            self.stopActivityIndicator()
            
            if (error != nil)
            {
                self.alert("error", message: (error?.localizedDescription)!)
            }
            
            if(success) {
                
                
                self.alert("Success", message: "Your information has been saved in your account")
                
                //self.performSegueWithIdentifier("moreInfoToMain", sender: self)
                
                
                
                
                
            }
            
            
        }

        
    
    }
        
        
        
        
        
    
    
    func userInfoProvider() {
        //닉네임
        if let nickname = (PFUser.currentUser()?.objectForKey("nickName") as? String){
            self.nickNameTextField.text = nickname
            
            
        }else{
            self.nickNameTextField.text = "NO NICKNAME"
        }
        
        //last name
        if let lastName = (PFUser.currentUser()?.objectForKey("lastName") as? String){
            self.lastNameTextfield.text = lastName
            
        }else{
            self.lastNameTextfield.text = "NO LASTNAME"
        }
        
        
        //first name
        if let firstName = (PFUser.currentUser()?.objectForKey("firstName") as? String){
            self.firstNameTextField.text = firstName
        }else{
            self.firstNameTextField.text = "NO FIRSTNAME"
        }
        
        //이메일
        if let email = (PFUser.currentUser()?.objectForKey("email_address") as? String){
            self.emailTextField.text = email
            
        }else{
            self.emailTextField.text = "NO EMAIL"
        }
        //전화번호
        if let phoneNumber = (PFUser.currentUser()?.objectForKey("phone_number") as? String){
            self.phoneTextField.text = phoneNumber
            
        }else{
            self.phoneTextField.text = "NO PHONE#"
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
        lastNameTextfield.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
    }
    func photoCaptureButtonAction() {
        let cameraDeviceAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let photoLibraryAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        
        if cameraDeviceAvailable && photoLibraryAvailable {
            let actionController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let takePhotoAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartCameraController() })
            let choosePhotoAction = UIAlertAction(title: NSLocalizedString("Choose Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartPhotoLibraryPickerController() })
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
            
            actionController.addAction(takePhotoAction)
            actionController.addAction(choosePhotoAction)
            actionController.addAction(cancelAction)
            
            self.presentViewController(actionController, animated: true, completion: nil)
        }
    }

    func shouldStartCameraController() -> Bool {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            return false
        }
        
        let cameraUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {                cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
            
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            } else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Front
            }
        } else {
            return false
        }
        
        cameraUI.allowsEditing = true
        cameraUI.showsCameraControls = true
        cameraUI.delegate = self
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    func shouldStartPhotoLibraryPickerController() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false
            && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) == false {
                return false
        }
        
        let cameraUI = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            
            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
        {
            cameraUI.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            
            
        } else {
            return false
        }
        
        cameraUI.allowsEditing = true
        cameraUI.delegate = self
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        profileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func circularImage(image : UIImageView) {
    image.layer.cornerRadius = image.frame.size.width / 2
    image.clipsToBounds  = true
    image.layer.borderColor  = UIColor.whiteColor().CGColor
    image.layer.borderWidth = 3
}





}
