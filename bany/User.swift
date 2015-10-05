//
//  User.swift
//  bany
//
//  Created by Lee Janghyup on 10/4/15.
//  Copyright © 2015 jay. All rights reserved.
//

import Foundation
import UIKit
import Parse

class User {
    
    var objectId : String
    var username : String
    
    //var createdAt : NSDate
    //var updatedAt : NSDate
    
    //var profile_picture : UIImage

    init(objectId:String, username:String) {
        
        
    self.objectId = (PFUser.currentUser()?.objectId)!
    self.username = (PFUser.currentUser()?.username)!
    
  }

}





  