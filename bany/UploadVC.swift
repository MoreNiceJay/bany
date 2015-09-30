//
//  UploadVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/29/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class UploadVC: UIViewController {

    @IBOutlet weak var uploadedPhotoImage: UIImageView!
    var uploadPhotoImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadedPhotoImage.image = uploadPhotoImageView.image
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
