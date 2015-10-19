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
    var postsArray : NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bringAllDatafromParse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("myPostCell", forIndexPath: indexPath) as! MyPostTVCE
        
        
       var postObjects = self.postsArray.objectAtIndex(indexPath.row) as! PFObject
        
        
    
    
    // 제목
    cell.titleTextLabel.text = (postObjects.objectForKey("titleText") as! String)
    
    
    
    //시간
    let dateFormatter:NSDateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM /dd /yy"
    cell.dateTextField.text = (dateFormatter.stringFromDate(postObjects.createdAt!))
    // 가격
    //cell.priceLabel.text = postObjects.objectForKey("priceText") as! String
    //이미지
    
    let mainImages = postObjects.objectForKey("front_image") as! PFFile
    
    
    mainImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
    let image = UIImage(data: imageData!)
    cell.mainPhoto.image = image
    }
    
    return cell
    
}

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postsArray.count
    }

    
    
//    func loadMyPost(){
//        
//        let myPost = PFQuery(className: "Posts")
//        myPost.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)
//        myPost.orderByAscending("createdAt")
//        myPost.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
//            if error == nil {
//                
//                for post in posts! {
//                    
//                    self.myPostTitle.append(post["titleText"] as! String)
//                    //time
//                    let dateFormatter:NSDateFormatter = NSDateFormatter()
//                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
//                    self.myPostDate.append(dateFormatter.stringFromDate(post.createdAt!))
//                    self.myPostPic.append(post["front_image"] as! PFFile)
//                    self.objectArray.append((post.objectId)! as String!)
//                    
//                    self.tableView.reloadData()
//                }
//                
//                
//            }else{
//                print(error)
//            }
//            
//        }
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "MyPostToDetail") {
            
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            let destViewController : DetailVC = segue.destinationViewController as! DetailVC
            destViewController.object = postsArray[(selectedRowIndex?.row)!] as! PFObject
            
            
        }
    }

    
    func bringAllDatafromParse() {
        //activityIndicatorOn()
        
        
        
        postsArray = []
        let query = PFQuery(className: "Posts")
        query.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)
                query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
            if error == nil && objects != nil{
                
                for object : PFObject in objects! {
                    
                    self.postsArray.addObject(object)
                    
                }
                
                let array : Array = self.postsArray.reverseObjectEnumerator().allObjects
                
                
                self.postsArray = array as! NSMutableArray
                
                
            }
            self.tableView.reloadData()
      }
    }
}
