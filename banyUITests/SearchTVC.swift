//
//  searchViewController.swift
//  bany
//
//  Created by Lee Janghyup on 10/3/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class SearchTVC: UIViewController, UITableViewDataSource ,UITableViewDelegate, UISearchBarDelegate,UISearchDisplayDelegate {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    
    var postsArray : NSMutableArray = NSMutableArray()
    
    
    var mainPhoto = [PFFile]()
    var time = [String]()
    var price = [String]()
    var searchResults = [String]()
    var objectArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bringAllDatafromParse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! SearchTVCE
        //cell.textLabel!.text = searchResults[indexPath.row]
        
        // 제목
        cell.titleLabel.text = searchResults[indexPath.row]
        // 시간
        cell.timeLabel.text = String(time[indexPath.row])
        // 가격
        cell.priceLabel.text = price[indexPath.row]
        //이미지
        
        mainPhoto[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData!)
        
            cell.mainImageView.image = image
        }
    
    
        
        
        return cell
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        
        searchResults = []
        mainPhoto = []
        time = []
        price = []
       postsArray = []
        
        let firstNameQuery = PFQuery(className: "Posts")
        
        firstNameQuery.whereKey("tagText", containsString: searchBar.text)
        
        //firstNameQuery.whereKey("tagText", matchesRegex : "(?i)\(searchBar.text)")
        
        let lastNameQuery = PFQuery(className: "Posts")
        lastNameQuery.whereKey("titleText", containsString: searchBar.text)
        //lastNameQuery.whereKey("titleText", matchesRegex : "(?i)\(searchBar.text)")

        let query = PFQuery.orQueryWithSubqueries([firstNameQuery, lastNameQuery])
        
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if error != nil{
                
                self.alert("Alert", message : (error?.localizedDescription)!)
                
                return
            }
            if let objects = results as [PFObject]? {
                
                self.searchResults.removeAll(keepCapacity: false)
                
                for object in objects {
                    let tagText = object.objectForKey("tagText") as! String
                    let titleText = object.objectForKey("titleText") as! String
                    
                    
                    
                    
                                        //시간
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    self.time.append(dateFormatter.stringFromDate(object.createdAt!))
                    self.price.append(object["priceText"] as! String)
                    
                    self.objectArray.append((object.objectId)! as String!)
                    
                    //self.viewed.append(post["view"] as! Int)
                    //  self.saved.append(post["like"] as! Int)
                    
                    self.mainPhoto.append(object["imageFile"] as! PFFile)
                    //self.profilePhoto.append(post["profilePhoto"] as! PFFile)

                    
                    
                    
                    
                    
                    let fullResult = tagText + "" + titleText
                    
                    self.searchResults.append(fullResult)
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.myTable.reloadData()
                    self.mySearchBar.resignFirstResponder()
                })
                
            }
        }
        
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
    }
    
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }

    @IBAction func refreshButtonTapped(sender: AnyObject) {
        
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
        searchResults.removeAll(keepCapacity: false)
        myTable.reloadData()
        
    }
    
    func bringAllDatafromParse() {
        //activityIndicatorOn()
        
        
        
        postsArray = []
        let query = PFQuery(className: "Posts")
        
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
            if error == nil && objects != nil{
                
                for object : PFObject in objects! {
                    
                    self.postsArray.addObject(object)
                    
                }
                
                let array : Array = self.postsArray.reverseObjectEnumerator().allObjects
                
                
                self.postsArray = array as! NSMutableArray
                
                
            }
            self.myTable.reloadData()
            

        
    }
    
        
        
        
//        let query = PFQuery(className: "Posts")
//        
//        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
//            if error == nil {
//                
//                for post in posts! {
//                    
//                    
//                    
//                    
//                    
//                    
//                    self.searchResults.append(post["titleText"] as! String)
//                    //시간
//                    let dateFormatter:NSDateFormatter = NSDateFormatter()
//                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
//                    self.time.append(dateFormatter.stringFromDate(post.createdAt!))
//                    self.price.append(post["priceText"] as! String)
//                    
//                    self.objectArray.append((post.objectId)! as String!)
//                    
//                    //self.viewed.append(post["view"] as! Int)
//                    //  self.saved.append(post["like"] as! Int)
//                    
//                    self.mainPhoto.append(post["front_image"] as! PFFile)
//                    //self.profilePhoto.append(post["profilePhoto"] as! PFFile)
//                    
//                    self.myTable.reloadData()
//                }
//            }
//        }
    
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "searchToDetail") {
            
            
            let selectedRowIndex = self.myTable.indexPathForSelectedRow
            let destViewController : DetailVC = segue.destinationViewController as! DetailVC
            destViewController.object = postsArray[(selectedRowIndex?.row)!] as! PFObject

            
        }
    }
    
    
    
}