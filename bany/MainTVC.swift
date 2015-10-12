//
//  MainVCTableViewController.swift
//  bany
//
//  Created by Lee Janghyup on 9/25/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MainTVC: UITableViewController {
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    
    
    
    lazy var mainPhoto = [PFFile]()
    lazy var profilePhoto = [PFFile]()
    lazy var titleText = [String]()
    lazy var nickName = [String]()
    lazy var time = [String]()
    lazy var price = [String]()
    lazy var viewed = [String]()
    lazy var saved = [String]()
    
    var objectArray = [String]()
   // var objectId = String()
    var parentObjectID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        bringAllDatafromParse()
            }
    
    
    @IBAction func segmentTapped(sender: AnyObject) {
       
        
        
        mainPhoto = []
        profilePhoto = []
        titleText = []
        nickName = []
        time = []
        price = []
        objectArray = []
        parentObjectID = String()

        switch categorySegment.selectedSegmentIndex {
        case 0 :
            bringAllDatafromParse()
        case 1 :
            bringCategoryDataFromParse(1)
            
        case 2 :
            bringCategoryDataFromParse(2)
            
        case 3 :
            bringCategoryDataFromParse(3)
            
        default :
            bringAllDatafromParse()
            
            
        
        }
        self.tableView.reloadData()
        
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
        return titleText.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTVCE

        
        // 제목
        cell.titleLabel.text = titleText[indexPath.row]
        // 닉네임
        cell.nickNameLabel.text = nickName[indexPath.row]
        // 시간
        cell.timeLabel.text = String(time[indexPath.row])
        // 가격
        cell.priceLable.text = price[indexPath.row]
        // 뷰
        //cell.timeLabel.text = titleText[indexPath.row]
        // 라이크
        //cell.nickNameLabel.text = nickName[indexPath.row]
        
        
        // 이미지
        mainPhoto[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData!)
            cell.mainPhoto.image = image
        }
        
        
        return cell
    }
    
    func bringAllDatafromParse() {
        //activityIndicatorOn()
        
        let query = PFQuery(className: "Posts")
        
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if error == nil {
                
                for post in posts! {
                    
                    
                    
                   

                    
                    self.titleText.append(post["titleText"] as! String)
                    self.nickName.append(post["userNickName"] as! String)
                    //시간
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    self.time.append(dateFormatter.stringFromDate(post.createdAt!))
                    self.price.append(post["priceText"] as! String)
                    
                    self.objectArray.append((post.objectId)! as String!)
                    
                    //self.viewed.append(post["view"] as! Int)
                    //  self.saved.append(post["like"] as! Int)
                    
                    self.mainPhoto.append(post["front_image"] as! PFFile)
                    //self.profilePhoto.append(post["profilePhoto"] as! PFFile)
                    
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    func bringCategoryDataFromParse(category : Int) {
        
        
        let query = PFQuery(className: "Posts")
        
        query.whereKey("category", equalTo: category)
        
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if (error == nil) {
                //에러없는 경우
                for post in posts! {

                    //시간
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    self.time.append(dateFormatter.stringFromDate(post.createdAt!))

                    self.titleText.append(post["titleText"] as! String)
                    self.nickName.append(post["userNickName"] as! String)
                    self.price.append(post["priceText"] as! String)
                    self.mainPhoto.append(post["front_image"] as! PFFile)
                    self.objectArray.append((post.objectId)! as String!)
                    
                    self.tableView.reloadData()

        }
            }else{
                print(error)
            }

         //   self.activityIndicatorOff()

}
}

    
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

if (segue.identifier == "mainToComment") {


let destViewController : CommentVC = segue.destinationViewController as! CommentVC
destViewController.parentObjectID = parentObjectID

    }
    
    if (segue.identifier == "mainToDetail") {
        
        let selectedRowIndex = self.tableView.indexPathForSelectedRow
        let destViewController : DetailVC = segue.destinationViewController as! DetailVC
        destViewController.parentObjectID = objectArray[(selectedRowIndex?.row)!]
    

}
}

    @IBAction func commentButtonTapped(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! MainTVCE
        let indexPath = tableView.indexPathForCell(cell)
        parentObjectID = objectArray[(indexPath?.row)!]
        
        self.performSegueWithIdentifier("mainToComment", sender: self)
    }
    
    
    
    /*func howaboutThis() {
        let query = PFQuery(className: "User")
        query.whereKey("objectId", equalTo: (PFUser.currentUser()?.objectId)!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if(error == nil) {
                var temp: NSArray = objects as! NSArray
                
                self.userArray = temp.mutableCopy() as! NSMutableArray
                self.tableView.reloadData()
                
            }else {
                print(error?.userInfo)
            }
        }
       //테이블 뷰 셀에 쓸꺼
    var object: PFObject = self.uerArray.objectIndex(indexPath.row) as PFObject
    cell.titleLabel.text = object["nickName"] as? String
    
    return cell
    
    //preparefor segue
    if (segue.identifier == "editNote") {
    let indexPath = self.tableView.indexPathForSelectedRow()!
    var object : PFObject = self.noteObjects.objectAtIndex(indexPath.row) as PFObject
    upcoming.object = object
    self.tableView.deselectRowAtIndexPath(indexPath, animated : true)
*/

}