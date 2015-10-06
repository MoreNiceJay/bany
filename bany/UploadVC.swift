//
//  UploadVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/29/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class UploadVC: UIViewController {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var textSwitch: UISwitch!
    @IBOutlet weak var uploadTitleTextField: UITextField!
    @IBOutlet weak var uploadPriceTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var uploadedPhotoImage: UIImageView!
    @IBOutlet weak var bookSwitch: UISwitch!
    @IBOutlet weak var iclickerSwitch: UISwitch!
    @IBOutlet weak var otherSwitch: UISwitch!
    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var category : Int = 0
    var email :String = String()
    var phoneNumber :String = String()
    var uploadPhotoImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadedPhotoImage.image = uploadPhotoImageView.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    @IBAction func emailSwitchOn(sender: AnyObject) {
        if let emailFromParse = (PFUser.currentUser()?.objectForKey("email") as? String){
            email = emailFromParse
            
        }else{
            //이메일 세팅 페이지 만들기
            self.alert("No email found", message : "Go userInfopage")
            emailSwitch.on = false
            emailSwitch.enabled = false
            
        }

    }

    @IBAction func textFieldOn(sender: AnyObject) {
        if let numberFromParse = (PFUser.currentUser()?.objectForKey("phoneNumber") as? String){
            phoneNumber = numberFromParse
            
        }else{
            //이메일 세팅 페이지 만들기
            self.alert("No phon# found", message : "Go userInfopage")
            emailSwitch.on = false
            textSwitch.enabled = false
        }

    }
    
    
    @IBAction func bookSwitchIsOn(sender: AnyObject) {
        if (bookSwitch.on == true)
        {
            category = 1
            iclickerSwitch.on = false
            otherSwitch.on = false
            
        }
    }
    
    @IBAction func iclickerSwitchIsOn(sender: AnyObject) {
        if (iclickerSwitch.on == true)
        {
            category = 2
            bookSwitch.on = false
            otherSwitch.on = false

        }
    }
    
    @IBAction func otherSwitchIsOn(sender: AnyObject) {
        
        if (otherSwitch.on == true)
        {
            category = 3
            bookSwitch.on = false
            iclickerSwitch.on = false
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let titleText = uploadTitleTextField.text
        let priceText = uploadPriceTextField.text
        let tagText = tagTextField.text
        let descriptionText = descriptionTextView.text
        let bookImage = uploadedPhotoImage.image
        let zero = 0
        if titleText!.isEmpty || priceText!.isEmpty {
            
            
            //유저에게 채워넣으라고 알럴트
            self.alert("invalid", message : "you must fill in the blank")
            
        }else {
            if(!emailSwitch.on && !textSwitch.on){
                self.alert("invalid", message : "you must choose at least one contact method")
            
            }else{
                
                if(!bookSwitch.on && !iclickerSwitch.on && !otherSwitch.on){
                self.alert("invalid", message : "you must choose a category")
                
                }else{
                    saveButton.enabled == false
                    
            
                
                
            //컨택 메소드 꼭 선택시키고 선택 할때 전화번호/이메일 맞는 지 확인시키기
            
            //스케일 조절
            let scaledImage = self.scaleImageWith(bookImage!, newSize: CGSizeMake(320, 200))
            
            
            let imageData = UIImagePNGRepresentation(scaledImage)
            let paseImageFile = PFFile(name: "uploaded_image.png", data : imageData!)
            
            
            let post = PFObject(className: "Posts")
            
            
            post["uploader"] = PFUser.currentUser()?.objectId
            post["username"] = (PFUser.currentUser()!.username)!
            post["titleText"] = titleText
            post["priceText"] = priceText
            post["tagText"] = tagText
            post["imageFile"] = paseImageFile
            post["descriptionText"] = descriptionText
            post["userNickName"] = PFUser.currentUser()?.objectForKey("nickName")
                    if !email.isEmpty {
                        post["preferEmail"] = email}
            
                    if !phoneNumber.isEmpty {
                        post["preferPhoneNumber"] = phoneNumber}
            post["category"] = category
            post["view"] = zero
                    post["like"] = zero
            
            post.saveInBackgroundWithBlock({ ( isSucessful: Bool, error : NSError?) -> Void in
                
                
                if error == nil {
                    
                    print("업로드 성공")
                    
                    //저장 성공했다고 표시창
                    self.luxuryAlert( "your post uploaded" )
                    
                    
                    
                    
                }else {
                    
                    self.alert("Error", message : (error?.localizedDescription)!)
                }
            })
            
                }}}

        
        
        
        
    }
    
    func startActivityIndicator() {
        self.actInd.hidden = false
        self.actInd.startAnimating()
        
    }
    
    func stopActivityIndicator() {
        self.actInd.hidden = true
        self.actInd.stopAnimating()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        uploadPriceTextField.resignFirstResponder()
        uploadTitleTextField.resignFirstResponder()
        tagTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        emailSwitch.resignFirstResponder()
        textSwitch.resignFirstResponder()

    }
    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func luxuryAlert(userMessage:String) {
        
        let myAlert = UIAlertController(title: "Success", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            
            self.performSegueWithIdentifier("uploadSuccess", sender: self)
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }



}
