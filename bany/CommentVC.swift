//
//  CommentVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class CommentVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var commentArray = [String]()
    
    var userIdArray = [String]()
    var parentObjectID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryComment()
        print(commentArray)
        print(parentObjectID)

        // Do any additional setup after loading the view.
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

    @IBAction func sendButton(sender: AnyObject) {
        startActivityIndicator()
        let comment = PFObject(className:"Commment")
        comment["createdBy"] = PFUser.currentUser()
        comment["comment"] =  "" + commentTextField.text!
        comment["parent"] = parentObjectID
        comment["username"] = PFUser.currentUser()?.username
        
        comment.saveInBackgroundWithBlock { (success : Bool, error : NSError?) -> Void in
            if error == nil {
                
                self.commentArray = []
                self.queryComment()
                self.commentTextField.text = ""
                
            }else { print(error)
            }
        }
        
    }



    func queryComment() {
        
        startActivityIndicator()
        
        let queryComments = PFQuery(className: "Commment")
        queryComments.whereKey("parent", equalTo: ("\(parentObjectID)"))
        queryComments.orderByAscending("createdAt")
        queryComments.findObjectsInBackgroundWithBlock { (comments, error) -> Void in
            if error == nil {
                //에러 없음 
                
                for comment in comments! {
                    self.commentArray.append(comment["comment"] as! String)
                    self.userIdArray.append(comment["username"] as! String)
                }
                
            }else{
            print(error)
            }
            self.commentTableView.reloadData()
            self.stopActivityIndicator()
        }
            

        
}
   
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
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
        
        commentTextField.resignFirstResponder()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForComment", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.commentArray[indexPath.row]
        cell.detailTextLabel!.text = "Id:" + self.userIdArray[indexPath.row]
        
        return cell
    }

    
}


   