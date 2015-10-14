//
//  MyLikeTVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/13/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MyLikeTVC: UITableViewController {

    
    var likeTitle = [String]()
    var likePrice = [String]()
    var likePic = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadMyPost()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likeTitle.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MyLikeTVCE = tableView.dequeueReusableCellWithIdentifier("likeCell", forIndexPath: indexPath) as! MyLikeTVCE


        
        // 제목
        cell.titleLabel.text = likeTitle[indexPath.row]
        
        // 시간
        cell.priceLabel.text = likePrice[indexPath.row]
        
        // 이미지
        likePic[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData!)
            cell.likeImage.image = image
        }

        
        
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadMyPost(){
        
        let query = PFQuery(className: "Like")
        query.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if error == nil {
                
                for post in posts! {
                    
                    
                    self.likeTitle.append(post["titleText"] as! String)
                    
                    
                    
                    self.likePrice.append(post["price"] as! String)
                    
                    self.likePic.append(post["front_image"] as! PFFile)
                    
                    
                    self.tableView.reloadData()
                }
                
                
            }else{
                print(error)
            }
            
        }
        
    }

    

}
