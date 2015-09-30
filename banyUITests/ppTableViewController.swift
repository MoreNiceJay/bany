//
//  ppTableViewController.swift
//  bany
//
//  Created by Lee Janghyup on 9/28/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class ppTableViewController: UITableViewController {

    var noteObjects = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.noteObjects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ppTableViewCell
        
        var object : PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
        
        cell.masterTitleLabel.text = object["title"] as? String
        cell.masterTextLabel.text = object["text"] as? String

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("editNote", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var upcoming : addTableViewController = segue.destinationViewController as! addTableViewController
        if (segue.identifier == "editNote") {
            let indexPath = self.tableView.indexPathForSelectedRow
            var object: PFObject = self.noteObjects.objectAtIndex(indexPath!.row) as! PFObject
            upcoming.object = object
            self.tableView.deselectRowAtIndexPath(indexPath!, animated: true)
            
            
        }
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
                    self.fetchAllObjectsFromLocalDataStore()
            self.fetchAllObject()
        
    }
    

    func fetchAllObjectsFromLocalDataStore() {
        var query: PFQuery = PFQuery(className: "Note")
        query.fromLocalDatastore()
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil)
            {
                var temp: NSArray = objects as! NSArray
                
                self.noteObjects = temp.mutableCopy() as! NSMutableArray
                
                self.tableView.reloadData()
                
            }else {
                print(error?.userInfo)
            }
        
    }
    
    
}
    func fetchAllObject() {
        
        PFObject.unpinAllObjectsInBackgroundWithBlock(nil)
       
        var query :PFQuery = PFQuery(className: "Note")
       
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
       
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
         
            if(error == nil) {
                
                PFObject.pinAllInBackground(objects, block: nil)
                
                self.fetchAllObjectsFromLocalDataStore()
                
            }else{  print(error?.userInfo)
                
            }
        }
        
        
    }
}