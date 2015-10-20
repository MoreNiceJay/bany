//
//  MoreInfoContactVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/8/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

//class MoreInfoContactVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var phoneNumberTextField: UITextField!
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var preferPhoneNumberSwitch: UISwitch!
//    @IBOutlet weak var preferEmailSwitch: UISwitch!
//    @IBOutlet weak var actInd: UIActivityIndicatorView!
//    @IBOutlet weak var nickNameTextField: UITextField!
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var profilePhotoImageView: UIImageView!
//
//    @IBOutlet weak var skipButton: UIButton!
//    @IBOutlet weak var saveButton: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        circularImage(profilePhotoImageView)
//        actInd.hidden = true
//    }
//    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
//        
//        // startActivityIndicator()
//        
//        photoCaptureButtonAction()
//        
//        //stopActivityIndicator()
//        
//    }
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        
//        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//
//    
//    
//    
//    @IBAction func saveButtonTapped(sender: AnyObject) {
//        startActivityIndicator()
//        
//        let phoneNumber =  phoneNumberTextField.text!
//        let email =  emailTextField.text!
//        let name =  nameTextField.text!
//        let nickName =  nickNameTextField.text!
//        let profileIamge = profilePhotoImageView.image!
//
//        
//        
//        if (phoneNumber.isEmpty || email.isEmpty ) {
//            
//            alert("Invalid", message : "All fields must be filled")
//            buttonEnabled(skipButton)
//            buttonEnabled(saveButton)
//            stopActivityIndicator()
//        }else{
//            
//            if !(phoneNumber.utf16.count == 10  ) {
//                // 3보다 크고 16보다 작은게 아니라면
//                alert("Invalid", message : "phoneNumber 10")
//                buttonEnabled(skipButton)
//                buttonEnabled(saveButton)
//                stopActivityIndicator()
//                
//            }else{
//                //ㅇㅋ
//                
//                if !(email.utf16.count > 7 ) {
//                    
//                    alert("Invalid", message : "email more than 7")
//                    buttonEnabled(skipButton)
//                    buttonEnabled(saveButton)
//                    stopActivityIndicator()
//                    
//                    
//                    }else{
//                        //굿투고
//                        
//                        
//                        
//                        //파스저장
//                        let  user = PFUser.currentUser()!
//                        
//                        user.setObject(email, forKey: "email_address")
//                        user.setObject(phoneNumber, forKey: "phone_number")
//                    user.setObject(name, forKey: "fullName")
//                    
//                    if( profilePhotoImageView.image != UIImage(named: "AvatarPlaceholder")) {
//                        let scaledImage = scaleImageWith(profileIamge, newSize: CGSizeMake(50, 50))
//                        let profileImageData = UIImagePNGRepresentation(scaledImage)
//                        let profileImageFile = PFFile(name: "profile.png", data : profileImageData!)
//                        
//                        user.setObject(profileImageFile, forKey: "profile_picture")
//                    
//                    }
//                        user.saveInBackgroundWithBlock { (success, error) -> Void in
//                            self.stopActivityIndicator()
//                            
//                            if (error != nil)
//                            {
//                                self.alert("alert", message: (error?.localizedDescription)!)
//                            }
//                            
//                            if(success) {
//                                
//                                self.performSegueWithIdentifier("moreInfoContactToMain", sender: self)
//                                
//                                
//                                
//                                self.alert("Success", message: "Your information save in your account")
//                                
//                            }
//                        }
//                    }
//                }
//                
//         
//        
//        
//    }
// 
//}
//
//
//    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
//        
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
//        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImage
//    }
//
//
//
//
//func startActivityIndicator() {
//    self.actInd.hidden = false
//    self.actInd.startAnimating()
//    
//}
//
//func stopActivityIndicator() {
//    self.actInd.hidden = true
//    self.actInd.stopAnimating()
//}
//
//
//
//func alert(title : String, message : String) {
//    
//    let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
//    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
//    myAlert.addAction(okAction)
//    self.presentViewController(myAlert, animated: true, completion: nil)
//    
//}
//
//override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//    
//    phoneNumberTextField.resignFirstResponder()
//    emailTextField.resignFirstResponder()
//    nickNameTextField.resignFirstResponder()
//    nameTextField.resignFirstResponder()
//    
//    
//}
//    func buttonEnabled(buttonName: UIButton){
//        
//        buttonName.enabled = true
//    }
//    func buttonDisabeld(buttonName: UIButton){
//        
//        buttonName.enabled = false
//    }
//    //페북 사진 가져오기
//    // var userProfile = "Https://graph.facebook.com/" + userID + "/picture?type=large"
//    
//    
//    func photoCaptureButtonAction() {
//        let cameraDeviceAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
//        let photoLibraryAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
//        
//        if cameraDeviceAvailable && photoLibraryAvailable {
//            let actionController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//            
//            let takePhotoAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartCameraController() })
//            let choosePhotoAction = UIAlertAction(title: NSLocalizedString("Choose Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartPhotoLibraryPickerController() })
//            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            actionController.addAction(takePhotoAction)
//            actionController.addAction(choosePhotoAction)
//            actionController.addAction(cancelAction)
//            
//            self.presentViewController(actionController, animated: true, completion: nil)
//        }
//    }
//    
//    func shouldStartCameraController() -> Bool {
//        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
//            return false
//        }
//        
//        let cameraUI = UIImagePickerController()
//        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
//        {                cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
//            
//            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
//                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Rear
//            } else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
//                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Front
//            }
//        } else {
//            return false
//        }
//        
//        cameraUI.allowsEditing = false
//        cameraUI.showsCameraControls = true
//        cameraUI.delegate = self
//        
//        self.presentViewController(cameraUI, animated: true, completion: nil)
//        
//        return true
//    }
//    func shouldStartPhotoLibraryPickerController() -> Bool {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false
//            && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) == false {
//                return false
//        }
//        
//        let cameraUI = UIImagePickerController()
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
//        {
//            
//            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//            
//            
//        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
//        {
//            cameraUI.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
//            
//            
//        } else {
//            return false
//        }
//        
//        cameraUI.allowsEditing = true
//        cameraUI.delegate = self
//        
//        self.presentViewController(cameraUI, animated: true, completion: nil)
//        
//        return true
//    }
//
//
//       func circularImage(image : UIImageView) {
//        image.layer.cornerRadius = image.frame.size.width / 2
//        image.clipsToBounds  = true
//        image.layer.borderColor  = UIColor.whiteColor().CGColor
//        image.layer.borderWidth = 3
//    }
//    
//
//
//
////        user.setObject(phoneNumber, forKey: "phoneNumber")
////
////        //저장전 맞는 형식이 저장 됬나 확인 해야함.
////
////        if (preferPhoneNumberSwitch.on == true){
////            user.setObject(preferPhoneNumber, forKey: "preferPhoneNumber")
////        }
////        if (preferEmailSwitch.on == true){
////            user.setObject(preferEmailAddress, forKey: "preferEmail")
////        }
////
////        // Do any additional setup after loading the view.
////    }
////
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
