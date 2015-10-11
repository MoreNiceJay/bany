//
//  NewUploadTitle.swift
//  bany
//
//  Created by Lee Janghyup on 10/11/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class NewUploadTitle: UIViewController {

    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
   
    @IBOutlet weak var titleTextField: UITextField!
       @IBOutlet weak var tagTextField: UITextField!
        @IBOutlet weak var bookSwitch: UISwitch!
    @IBOutlet weak var iclickerSwitch: UISwitch!
    @IBOutlet weak var otherSwitch: UISwitch!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var category : Int = 0
   
    @IBOutlet weak var classLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tagTextField.placeholder?.write("good")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    @IBAction func bookSwitchIsOn(sender: AnyObject) {
        if (bookSwitch.on == true)
        {
            category = 1
            iclickerSwitch.on = false
            otherSwitch.on = false
            
        }
    }
    
    @IBAction func iclickerSwitchIsOn(sender: AnyObject) {
        if (iclickerSwitch.on == true)
        {
            category = 2
            bookSwitch.on = false
            otherSwitch.on = false
            
        }
    }
    
    @IBAction func otherSwitchIsOn(sender: AnyObject) {
        
        if (otherSwitch.on == true)
        {
            category = 3
            bookSwitch.on = false
            iclickerSwitch.on = false
        }
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let titleText = titleTextField.text
        let tagText = tagTextField.text
        
       
        
        
        
        if(!bookSwitch.on && !iclickerSwitch.on && !otherSwitch.on){
            
            self.alert("invalid", message : "you must choose a category")
        }else{
        if titleText!.isEmpty || tagText!.isEmpty {
            
            
            //유저에게 채워넣으라고 알럴트
            self.alert("invalid", message : "you must fill in the blank")
            
        }else {
            
                self.performSegueWithIdentifier("uploadTitleToUploadImage", sender: self)
           
            }
            
                    
                    
        }
 
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "uploadTitleToUploadImage") {
            
            
            let destViewController : NewUploadPhoto = segue.destinationViewController as! NewUploadPhoto
            destViewController.category = category
            destViewController.titleText = titleTextField.text!
            destViewController.tagText = tagTextField.text!
            
        }
        
        
        }

    
    func startActivityIndicator() {
        self.actInd.hidden = false
        self.actInd.startAnimating()
        
    }
    
    func stopActivityIndicator() {
        self.actInd.hidden = true
        self.actInd.stopAnimating()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        titleTextField.resignFirstResponder()
        tagTextField.resignFirstResponder()
       
        
    }
    
    
    func luxuryAlert(userMessage:String) {
        
        let myAlert = UIAlertController(title: "Success", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            
            self.performSegueWithIdentifier("uploadSuccess", sender: self)
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    
    
}

