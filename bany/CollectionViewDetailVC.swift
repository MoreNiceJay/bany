//
//  CollectionViewDetailVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/10/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class CollectionViewDetailVC: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.detailImage.image = self.image
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

}
