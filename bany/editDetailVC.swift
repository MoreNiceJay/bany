//
//  editDetailVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/13/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
class editDetailVC: UIViewController {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var purchasedDateTextField: UITextField!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var tagTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    var parentObjectID = String()
    var object : PFObject!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 1000, 0)
        retrievingData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        self.scrollView.contentSize.height = 1000
        self.scrollView.contentSize.width = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButtonTapped(sender: AnyObject) {
        let query = PFQuery(className:"Posts")
        query.getObjectInBackgroundWithId(object.objectId!) {
            (post: PFObject?, error: NSError?) -> Void in
            if error != nil && post == nil {
                
                
                
            }else if let post = post {
                
                post["titleText"] = self.titleTextField.text
                post["descriptionText"] =  self.descriptionTextView.text
                post["priceText"] = self.priceTextfield.text
                post["purchasedDate"] = self.purchasedDateTextField.text
                post["titleText"] = self.titleTextField.text
                post["tagText"] = self.tagTextfield.text
                
                
                //저장 알림
                
                post.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if error == nil{
                        (print("good"))
                        //에러 알림
                    }
                })
            }
        }
        
  
    }
    
  








//        let query = PFQuery(className:"Posts")
//        query.getObjectInBackgroundWithId(parentObjectID) {
//            (post: PFObject?, error: NSError?) -> Void in
//            if error != nil && post == nil {
//                print("go fuck yourslef")
//        
//            }else if let post = post {
//        
//        post["titleText"] = self.titleTextField.text
//        post["descriptionText"] = self.descriptionTextView.text
//        post["priceText"] = self.priceTextfield.text
//        post["purchasedDate"] = self.purchasedDateTextField.text
//        //post["damage_image"] = self.tagTextfield.text
//        //post["front_image"] = 1338
//        post["tagText"] = self.tagTextfield.text
//        
//                
//        post.saveInBackgroundWithBlock({ (success, error) -> Void in
//            if error == nil{
//                (print("good"))
//            }
//        })
//            }
//        }
//    }
//    

    

    

    @IBAction func deleteButtonTapped(sender: AnyObject) {
        
        
        
        let query = PFQuery(className: "Posts")
        query.getObjectInBackgroundWithId(object.objectId!) { (obj, err) -> Void in
            if err != nil {
                //handle error
            } else {
                obj!.deleteInBackground()
                print("deleted")
            }
        }
        
        
    }


   func retrievingData() {
    
    
    
    
        let query = PFQuery(className:"Posts")
        query.getObjectInBackgroundWithId(object.objectId!) {
            (post: PFObject?, error: NSError?) -> Void in
            if error == nil && post != nil {
                
                
                
                
                self.titleTextField.text = post!.valueForKey("titleText") as? String
                self.descriptionTextView.text = post!.valueForKey("descriptionText") as? String
                self.priceTextfield.text = post!.valueForKey("priceText") as? String
                self.purchasedDateTextField.text = post!.valueForKey("purchasedDate") as? String
                
                self.tagTextfield.text =  post!.valueForKey("tagText") as? String
                //self..text = post!.valueForKey("userNickName") as? String
               
                
                               
                
                
                
                
                
                var backPic = post!.valueForKey("damage_image") as? PFFile
                
                backPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                    
                    
                    
                    if(imageData != nil){
                        
                        self.backImageView.image = UIImage(data: imageData!)
                        
                        
                    }
                        
                    else{
                        self.backImageView.image = UIImage(named: "AvatarPlaceholder")
                        
                        
                        
                    }
                    
                    
                    
                    
                    //post!.valueForKey("prefer_phoneNumber") as? String
                    //post!.valueForKey("prefer_email") as? String
                    
                    
                    
                    
                    var frontPic = post!.valueForKey("front_image") as? PFFile
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
    

    



}




