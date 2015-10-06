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

    @IBOutlet weak var likedButton: UIButton!
    
    var parentObjectID = String()
    var likeButton = Bool()
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.sizeToFit()
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
    @IBAction func likeButtonTapped(sender: AnyObject) {
        
        if likeButton == false {
        likedButton.titleLabel!.text = "liked"
            likedButton.titleLabel?.textColor = UIColor.redColor()
            likeButton = true
        let likeSave = PFObject(className: "like")
        
        likeSave["uploader"] = PFUser.currentUser()?.objectId
        likeSave["status"] = true
        likeSave["parent"] = parentObjectID
        
        likeSave.saveEventually { (success, error) -> Void in
            if error == nil {
                
                self.alert("Error", message : (error?.localizedDescription)!)
                
                
            }else{
                self.alert("Error", message : (error?.localizedDescription)!)
            }
        }
        }else { likeButton = false
            likedButton.titleLabel!.text = "like"
            likedButton.titleLabel?.textColor = UIColor.blueColor()
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
    }
    
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }

}
