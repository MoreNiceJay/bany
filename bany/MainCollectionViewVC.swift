//
//  MainCollectionViewVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/10/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MainCollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet var layout : UICollectionViewFlowLayout!
    
    
    lazy var mainPhoto = [PFFile]()
    lazy var profilePhoto = [PFFile]()
    lazy var titleText = [String]()
    lazy var nickName = [String]()
    lazy var time = [String]()
    lazy var price = [String]()
    lazy var viewed = [String]()
    lazy var saved = [String]()
    
    var objectArray = [String]()
    var parentObjectID = String()

    @IBOutlet weak var collectionView: UICollectionView!
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
        self.collectionView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleText.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MainCollectionViewCell
        
        // 제목
        cell.titleLabel.text = titleText[indexPath.row]
        // 닉네임
       // cell.nickNameLabel.text = nickName[indexPath.row]
        // 시간
       // cell.timeLabel.text = String(time[indexPath.row])
        // 가격
        cell.priceLabel.text = price[indexPath.row]
        
        // 이미지
        mainPhoto[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData!)
            cell.imageView.image = image
        }
        
        
        return cell

        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showImage"{
//            let indexPaths = self.collectionView.indexPathsForSelectedItems()
//            let indexPath = indexPaths[0] as NSIndexPath
//            
//            let vc = segue.destinationViewController as! CollectionViewDetailVC
//            
//            vc.image = self.imageArray[indexPath.row!]
// 
//            vc.title = self.apple[indexPath.row]
//    }
        if (segue.identifier == "mainToComment") {
            
            
            let destViewController : CommentVC = segue.destinationViewController as! CommentVC
            destViewController.parentObjectID = parentObjectID
            
        }
        
        if (segue.identifier == "mainToDetail") {
            
            let selectedRowIndex = self.collectionView.indexPathsForSelectedItems()!
            
            let indexPath = selectedRowIndex[0] as NSIndexPath
            let destViewController : DetailVC = segue.destinationViewController as! DetailVC
            destViewController.parentObjectID = objectArray[(indexPath.row)]
            
            
        }

    }
    
    func bringAllDatafromParse() {
        //activityIndicatorOn()
        
        let query = PFQuery(className: "Posts")
        
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if error == nil {
                
                for post in posts! {
                    
                    
                    
                    
                    
                    
                    self.titleText.append(post["titleText"] as! String)
                    self.nickName.append(post["nickName"] as! String)
                    //시간
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    self.time.append(dateFormatter.stringFromDate(post.createdAt!))
                    self.price.append(post["priceText"] as! String)
                    
                    self.objectArray.append((post.objectId)! as String!)
                    
                    //self.viewed.append(post["view"] as! Int)
                    //  self.saved.append(post["like"] as! Int)
                    
                    self.mainPhoto.append(post["imageFile"] as! PFFile)
                    //self.profilePhoto.append(post["profilePhoto"] as! PFFile)
                    
                    self.collectionView.reloadData()
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
                    self.nickName.append(post["nickName"] as! String)
                    self.price.append(post["priceText"] as! String)
                    self.mainPhoto.append(post["imageFile"] as! PFFile)
                    self.objectArray.append((post.objectId)! as String!)
                    
                    self.collectionView.reloadData()
                    
                }
            }else{
                print(error)
            }
            
            //   self.activityIndicatorOff()
            
        }

    
    }
}
