//
//  DetailVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class DetailVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purchasedDateLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var tagTextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var checkingArray = [String]()
    
    var parentObjectID = String()
    
    var frontImage = UIImageView()
    var backImage = UIImageView()
    var ddd = String()
    
    var array = []
      var object : PFObject!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
         detailViewSetting()
        print(object)
        
        editButton.hidden = true
        

        // Do any additional setup after loading the view.
        
        scrollView.contentSize.height = 1200
        
        
        //유저가 맞으면 에딧 하게 해주기
        let checkForEdit = PFQuery(className: "Posts")
        
        checkForEdit.getObjectInBackgroundWithId(parentObjectID) {
            (post: PFObject?, error: NSError?) -> Void in
            if error == nil && post != nil {

                
                
                if  (PFUser.currentUser()?.objectId == post!.valueForKey("uploader") as? String){
                    self.editButton.hidden = false
                
                }
            }
        
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        }
        
    
        
        func detailViewSetting(){
        //제목
        
            self.titleLabel.text = object.objectForKey("titleText") as? String
            self.descriptionTextLabel.text = object.valueForKey("descriptionText") as? String
            self.priceLabel.text = object.valueForKey("priceText") as? String
            self.purchasedDateLabel.text = object.valueForKey("purchasedDate") as? String
            
            self.tagTextLabel.text =  object!.valueForKey("tagText") as? String
            
            if let userNickNameCheck = object!.valueForKey("userNickName") as? String {
                
                self.nickNameLabel.text = userNickNameCheck
                
            }else{
               self.nickNameLabel.text = object!.valueForKey("userNickName") as? String
            }

            
            
            
            //시간
            
            
            let dateFormatter:NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM /dd /yyyy HH:mm"
            timeLabel.text = (dateFormatter.stringFromDate(object.createdAt!))
            
            let mainImage = object.objectForKey("front_image") as! PFFile
            
            
            mainImage.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                let image = UIImage(data: imageData!)
                self.frontImageView.image = image
                self.frontImage.image = image
            }
            
            
            let backImage = object.objectForKey("damage_image") as! PFFile
            
            
            backImage.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                let image = UIImage(data: imageData!)
                self.backImageView.image = image
                self.backImage.image = image
            }

            
            
            // 프로필
            if let profileImages = (object.objectForKey("profile_picture") as? PFFile){
                profileImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                    let image = UIImage(data: imageData!)
                    self.profileImageView.image = image
                    
                }
            
            }else{ profileImageView.image = UIImage(named: "AvatarPlaceholder")
               
            }

                
                
                
                
                //post!.valueForKey("prefer_phoneNumber") as? String
                //post!.valueForKey("prefer_email") as? String
                
                
                
                
    

    
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func commentButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("detailToComment", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailToComment") {
            
            
            let destViewController : CommentVC = segue.destinationViewController as! CommentVC
            destViewController.parentObjectID = parentObjectID
                    }
        
        if (segue.identifier == "front") {
            
            
            let destViewController : FrontImage = segue.destinationViewController as! FrontImage
            destViewController.frontImageView.image = frontImage.image
            
            
            
            
        }
        
        if (segue.identifier == "back") {
            
            let destViewController : BackImage = segue.destinationViewController as! BackImage
            destViewController.backImageView.image = backImage.image
            
            
        }

        if (segue.identifier == "editDetail") {
            
            let destViewController : editDetailVC = segue.destinationViewController as! editDetailVC
           
            
            
            
            destViewController.parentObjectID = parentObjectID
            
            
        }
        
    }

    @IBAction func likeButtonTapped(sender: AnyObject){
        
        
                    let save = PFObject(className: "Like")
                    
                    save["parent"] = self.parentObjectID
                    save["uploader"] = PFUser.currentUser()?.objectId
                    
                    save.saveInBackgroundWithBlock { (success, error) -> Void in
                        if error == nil {
                            
                            self.alert("liked", message: "you saved it for later")
                            
                            self.likeButton.enabled = false
                            
                            
                        }else{
                            self.alert("error", message: (error?.localizedDescription)!)
                            
                        }
        }
                    
        
        
                
                

                
                
            }
        
        
        
            

  

      


        
        
        
        
       
       

    
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    func retrievingData() {
    let query = PFQuery(className:"Posts")
    query.getObjectInBackgroundWithId(parentObjectID) {
    (post: PFObject?, error: NSError?) -> Void in
    if error == nil && post != nil {
        
       
        
       
       self.titleLabel.text = post!.valueForKey("titleText") as? String
       self.descriptionTextLabel.text = post!.valueForKey("descriptionText") as? String
        self.priceLabel.text = post!.valueForKey("priceText") as? String
        self.purchasedDateLabel.text = post!.valueForKey("purchasedDate") as? String

        self.tagTextLabel.text =  post!.valueForKey("tagText") as? String
        self.nickNameLabel.text = post!.valueForKey("userNickName") as? String
        
        
        //시간
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
      
        
        self.timeLabel.text = dateFormatter.stringFromDate(post!.createdAt!)
        
        
        
        var backPic = post!.valueForKey("damage_image") as? PFFile
        
        backPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil){
                
                self.backImageView.image = UIImage(data: imageData!)
                self.backImage.image = UIImage(data: imageData!)
                
            }
                
            else{
                self.backImageView.image = UIImage(named: "AvatarPlaceholder")
                
                self.backImage.image = UIImage(named: "AvatarPlaceholder")
                
            }
            
            
            
            
            //post!.valueForKey("prefer_phoneNumber") as? String
            //post!.valueForKey("prefer_email") as? String

        
        
        
        var frontPic = post!.valueForKey("front_image") as? PFFile
                frontPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil)
                
            {
                
                self.frontImageView.image = UIImage(data: imageData!)
                self.frontImage.image = UIImage(data: imageData!)
                
    }else{
        self.frontImageView.image = UIImage(named: "AvatarPlaceholder")
                
                self.frontImage.image =
                    UIImage(named: "AvatarPlaceholder")

        }
       
        
        
        
   
    
    
            }
        
    
        }
        


        }
    
    
        }
        
    }


    
    
  
    
    
    
}
        

