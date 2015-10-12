//
//  NewUploadDescription.swift
//  bany
//
//  Created by Lee Janghyup on 10/11/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class NewUploadDescription: UIViewController {

    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var purchasedDateTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emailSwitch: UISwitch!
    
    @IBOutlet weak var textSwitch: UISwitch!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    
    var category = Int()
    var titleText = String()
    var tagText = String()
    var photoFront = UIImage()
    var photoDamage = UIImage()
    
    var email :String = String()
    var phoneNumber :String = String()
    var uploadPhotoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd.hidden = true
        
        
        
        // Do any additional setup after loading the view.
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
            self.alert("No email found", message : "set your email")
            
            
            
            
            emailSwitch.on = false
            emailSwitch.enabled = false
            //이메일 저장 시키는 텍스트 필드..
            
        }
        
    }
    
    @IBAction func textFieldOn(sender: AnyObject) {
        if let numberFromParse = (PFUser.currentUser()?.objectForKey("phoneNumber") as? String){
            phoneNumber = numberFromParse
            
        }else{
            //이메일 세팅 페이지 만들기
            
            emailSwitch.on = false
            textSwitch.enabled = false
            //전화번호 저장 시키는 텍스트 필드
           //self.alert("No phone# found", message : "set your Phone#")
            
            
            var phoneAlert : UIAlertController = UIAlertController(title: "Phone number", message: "please write prefer phone number ", preferredStyle: UIAlertControllerStyle.Alert)
            
            phoneAlert.addTextFieldWithConfigurationHandler({ (textField : UITextField) -> Void in
                textField.placeholder = "phone number"
                
            })
            
            phoneAlert.addAction(UIAlertAction(title: "111", style: UIAlertActionStyle.Default, handler: { alertAction in
                let textFields : NSArray = phoneAlert.textFields as! NSArray
                let phoneNumberTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                
                PFUser.currentUser()?.setObject(phoneNumberTextField.text!, forKey: "preferPhoneNumber")
                
                PFUser.currentUser()?.saveInBackgroundWithBlock { (success, error) -> Void in
                    self.stopActivityIndicator()
                    
                    if (error != nil)
                    {
                        self.alert("error", message: (error?.localizedDescription)!)
                    }
                    
                    if(success) {
                        print("goooooooooooood")
                        
                       // self.alert("Success", message: "Your information has been saved in your account")
                        
                        //self.performSegueWithIdentifier("moreInfoToMain", sender: self)
                        
                        
                        
                        
                        
                    }
                    
                    
                }
                
                

                
                
                
            }
        ))
        
            
            self.presentViewController(phoneAlert, animated: true, completion: nil)
        
        }
        
        
        
    
        
    
    }
    
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        
        let priceText = priceTextField.text
        let purchasedDate = purchasedDateTextField.text
        let descriptionText = descriptionTextView.text
        
       
        if priceText!.isEmpty || purchasedDate!.isEmpty || description.isEmpty{
            
            
            //유저에게 채워넣으라고 알럴트
            self.alert("invalid", message : "you must fill in the blank")
            
        }else {
            
            if !(purchasedDate!.utf16.count <= 26 && purchasedDate!.utf16.count >= 2 ) {
                // 3보다 크고 16보다 작은게 아니라면
                alert("Invalid", message : "date must be 2 ~ 26")
                buttonEnabled(uploadButton)
                
                stopActivityIndicator()
                
            }else{
                //ㅇㅋ
                
                if !(description.utf16.count <= 200 && description.utf16.count >= 2 ) {
                    
                    alert("Invalid", message : "description 2 ~ 200")
                    buttonEnabled(uploadButton)
                    
                    stopActivityIndicator()
                    
                    
                    
                    
                }else {
            
            
            
            
            if(!emailSwitch.on && !textSwitch.on){
                self.alert("invalid", message : "you must choose at least one contact method")
                
            }else{
                
                    //컨택 메소드 꼭 선택시키고 선택 할때 전화번호/이메일 맞는 지 확인시키기
                    
                    //스케일 조절
                    let scaledImageFront = self.scaleImageWith(photoFront, newSize: CGSizeMake(320, 200))
                
                    let scaledImageBack = self.scaleImageWith(photoDamage, newSize: CGSizeMake(320, 200))
                
                let imageDataOne = UIImagePNGRepresentation(scaledImageFront)
                let imageDataTwo = UIImagePNGRepresentation(scaledImageBack)
                
                    let parseFrontFile = PFFile(name: "front_photo.png", data : imageDataOne!)
                let parseDamageFile = PFFile(name: "damage_photo.png", data : imageDataTwo!)
                
                    let post = PFObject(className: "Posts")
                    
                    
                    post["uploader"] = PFUser.currentUser()?.objectId
                    post["username"] = (PFUser.currentUser()!.username)!
                    post["titleText"] = titleText
                    post["priceText"] = priceText
                    post["tagText"] = tagText
                    post["front_image"] = parseFrontFile
                    post["damage_image"] = parseDamageFile
                    post["descriptionText"] = descriptionText
                    post["purchasedDate"] = purchasedDate
                    post["userNickName"] = PFUser.currentUser()?.objectForKey("nickName")
                    post["category"] = category
                   // post["view"] = zero
                   // post["like"] = zero
                    
                    post.saveInBackgroundWithBlock({ ( isSucessful: Bool, error : NSError?) -> Void in
                        
                        
                        if error == nil {
                            
                            print("업로드 성공")
                            
                            //저장 성공했다고 표시창
                            self.luxuryAlert( "your post uploaded" )
                            
                            
                            
                            
                        }else {
                            
                            self.alert("Error", message : (error?.localizedDescription)!)
                        }
                    })
                    
                       }
        }
    }
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
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        priceTextField.resignFirstResponder()
        purchasedDateTextField.resignFirstResponder()
                descriptionTextView.resignFirstResponder()
        
        
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
    
    func buttonEnabled(buttonName: UIButton){
        
        buttonName.enabled = true
    }
    func buttonDisabeld(buttonName: UIButton){
        
        buttonName.enabled = false
    }
    

    
    
}
