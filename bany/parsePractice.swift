//
//  parsePractice.swift
//  bany
//
//  Created by Lee Janghyup on 10/31/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class parsePractice : PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        parseClassName = "Posts"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        parseClassName = "Posts"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 20
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!)
        
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        //if self.objects!.count == 0 {
          //  query.cachePolicy = .CacheThenNetwork
       // }
        
        query.orderByDescending("createdAt")
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier = "Cell1"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MainTVCE
        
        // main Image for post
        let mainImages = object!["front_image"] as! PFFile
        mainImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            let image = UIImage(data: imageData!)
            cell?.mainPhoto.image = image
        }

//        if cell == nil {
//            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
//        }
        
//        // Configure the cell to show todo item with a priority at the bottom
//        if let object = object {
//            cell!.textLabel?.text = object["titleText"] as? String
//            
//        }
        
        return cell
    }
}