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
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purchasedDateLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var tagTextLabel: UILabel!
    var checkingArray = [String]()
    var liked = false
    var parentObjectID = String()
    var likeButton = Bool()
    var dddd = String()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
        
        scrollView.sizeToFit()
        
        retrievingData()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        

        
        
    
    
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
    }

    @IBAction func likeButtonTapped(sender: AnyObject){
        
    
    var query = PFQuery(className:"Like")
    
    
    
    
    query.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
    (likes: PFObject?, error: NSError?) -> Void in
    if error != nil {
    print(error)
    } else if let likes = likes {
    likes["parent"] = self.parentObjectID
    likes["uploader"] = PFUser.currentUser()?.objectId
        
    likes.saveInBackground()
    
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
}
        

