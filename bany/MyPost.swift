//
//  MyPost.swift
//  bany
//
//  Created by Lee Janghyup on 10/5/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MyPost: UIViewController,  UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var myPostTitle = [String]()
    var myPostPic = [PFFile]()
    var myPostDate = [String]()
    var objectArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadMyPost()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("myPostCell", forIndexPath: indexPath) as! MyPostTVCE
        
        
        // 제목
        cell.titleTextLabel.text = myPostTitle[indexPath.row]
        
        // 시간
        cell.dateTextField.text = String(myPostDate[indexPath.row])
        
        // 이미지
        myPostPic[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData!)
            cell.mainPhoto.image = image
        }
        

    
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return myPostTitle.count
    }

    
    
    func loadMyPost(){
        
        let myPost = PFQuery(className: "Posts")
        myPost.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)
        myPost.orderByAscending("createdAt")
        myPost.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if error == nil {
                
                for post in posts! {
                    
                    self.myPostTitle.append(post["titleText"] as! String)
                    //time
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    self.myPostDate.append(dateFormatter.stringFromDate(post.createdAt!))
                    self.myPostPic.append(post["front_image"] as! PFFile)
                    self.objectArray.append((post.objectId)! as String!)
                    
                    self.tableView.reloadData()
                }
                
                
            }else{
                print(error)
            }
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "MyPostToDetail") {
            
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            let destViewController : DetailVC = segue.destinationViewController as! DetailVC
            destViewController.parentObjectID = objectArray[(selectedRowIndex?.row)!]
            
            
        }
    }

    
}
