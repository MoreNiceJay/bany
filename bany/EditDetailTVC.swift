//
//  EditDetailTVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/19/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import  Parse

class EditDetailTVC: UITableViewController {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var purchasedDateTextField: UITextField!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var tagTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    var parentObjectID = String()
    var object : PFObject!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
stopActivityIndicator()
        retrievingData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let query = PFQuery(className:"Posts")
        query.getObjectInBackgroundWithId(object.objectId!) {
            (post: PFObject?, error: NSError?) -> Void in
            if error != nil && post == nil {
                
                
                
            }else if let post = post {
                let titleText = self.titleTextField.text
                let tagText = self.tagTextfield.text
                let priceText = self.priceTextfield.text
                let purchasedDate = self.purchasedDateTextField.text
                let descriptionText = self.descriptionTextView.text
                
                
                
                if !((priceText?.isEmpty) != nil){
                    
                }else {
                    
                }
                
                if !(titleText!.utf16.count <= 45 && titleText!.utf16.count >= 2 ) {
                    
                }else{
                    
                     if !(tagText!.utf16.count <= 40 && tagText!.utf16.count >= 2 ) {
                        
                     }else {
                
                
                post["titleText"] = self.titleTextField.text
                post["descriptionText"] =  self.descriptionTextView.text
                post["priceText"] = self.priceTextfield.text
                post["purchasedDate"] = self.purchasedDateTextField.text
                
                post["tagText"] = self.tagTextfield.text
                post["front_image"] = self.frontImageView.image
                
                    post["back_image"] = self.backImageView.image
                
                //저장 알림
                
                post.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if error == nil{
                        (print("good"))
                        //에러 알림
                        
                        self.alert("saved", message: "your post has been saved")
                    }
                })
            }
        }
        
        }
        }
    }
   

    

    
    @IBAction func deleteButtonTapped(sender: AnyObject) {
        
        
            
            let query = PFQuery(className: "Posts")
            query.getObjectInBackgroundWithId(self.object.objectId!) { (obj, err) -> Void in
                if err != nil {
                    //handle error
                } else {
                    
                    
                    obj!.deleteInBackgroundWithBlock({ (success, error) -> Void in
                        if error == nil {
                            
                            let myAlert = UIAlertController(title: "Deleted", message: "your post has been deleted", preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {Void in self.performSegueWithIdentifier("editDetailTVCToMain", sender: self)})
                            myAlert.addAction(okAction)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            

                            
                            
                        }
                    })
                    
                    
                }
            }

            
            
       
    }
    func retrievingData() {
        
        
        
        
        self.titleTextField.text = object!.valueForKey("titleText") as? String
        self.descriptionTextView.text = object!.valueForKey("descriptionText") as? String
        self.priceTextfield.text = object!.valueForKey("priceText") as? String
        self.purchasedDateTextField.text = object!.valueForKey("purchasedDate") as? String
        
        self.tagTextfield.text =  object!.valueForKey("tagText") as? String
        
        
        
        
        let backPic = object!.valueForKey("back_image") as? PFFile
        
        backPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil){
                
                self.backImageView.image = UIImage(data: imageData!)
                
                
            }
                
            else{
                self.backImageView.image = UIImage(named: "AvatarPlaceholder")
                
            }
            
            
            
            
            //post!.valueForKey("prefer_phoneNumber") as? String
            //post!.valueForKey("prefer_email") as? String
            
            
            
            
            let frontPic = self.object!.valueForKey("front_image") as? PFFile
            frontPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                
                
                if(imageData != nil)
                    
                {
                    
                    self.frontImageView.image = UIImage(data: imageData!)
                    
                    
                }else{
                    self.frontImageView.image = UIImage(named: "AvatarPlaceholder")
                    
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
        
        
        titleTextField.resignFirstResponder()
        priceTextfield.resignFirstResponder()
        tagTextfield.resignFirstResponder()
        purchasedDateTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        
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
    @IBAction func keyBoardDismissButton(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        
        return true
        
    }



    }
