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
    
    @IBOutlet weak var nextButton: UIButton!
    var category : Int = 0
   
    @IBOutlet weak var classLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd.hidden = true
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
            titleLabel.text = "book title"
            classLabel.text = "class/author"
            tagTextField.placeholder = "ex) Acom203, author name"
            
        }
    }
    
    @IBAction func iclickerSwitchIsOn(sender: AnyObject) {
        if (iclickerSwitch.on == true)
        {
            category = 2
            bookSwitch.on = false
            otherSwitch.on = false
            titleLabel.text = "iclicker"
            classLabel.text = "battery"
            tagTextField.placeholder = "ex) no battery or yes battery"

            
        }
    }
    
    @IBAction func otherSwitchIsOn(sender: AnyObject) {
        
        if (otherSwitch.on == true)
        {
            category = 3
            bookSwitch.on = false
            iclickerSwitch.on = false
            titleLabel.text = "brand/model"
            classLabel.text = "model/model number"
            tagTextField.placeholder = "ex) Mac mini a1347"
        }
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        
        startActivityIndicator()
        buttonDisabeld(nextButton)
        
        let titleText = titleTextField.text
        let tagText = tagTextField.text
        
       
        
        
        
        if(!bookSwitch.on && !iclickerSwitch.on && !otherSwitch.on){
            
            buttonEnabled(nextButton)
            
            stopActivityIndicator()
            
            self.alert("invalid", message : "you must choose a category")
        }else{
        if titleText!.isEmpty || tagText!.isEmpty {
            
            
            buttonEnabled(nextButton)
            
            stopActivityIndicator()
            
            //유저에게 채워넣으라고 알럴트
            self.alert("invalid", message : "you must fill in the blank")
            
            
            
        }else {
            
            if !(titleText!.utf16.count <= 26 && titleText!.utf16.count >= 2 ) {
                // 3보다 크고 16보다 작은게 아니라면
                alert("Invalid", message : "nickname 2 ~ 26")
                buttonEnabled(nextButton)
                
                stopActivityIndicator()
                
            }else{
                //ㅇㅋ
                
                if !(tagText!.utf16.count <= 26 && tagText!.utf16.count >= 2 ) {
                    
                    alert("Invalid", message : "first name 2 ~ 26")
                    buttonEnabled(nextButton)
                    
                    stopActivityIndicator()
                    
                    
                    
                    
                    }else{
                        //굿투고

            
                self.performSegueWithIdentifier("uploadTitleToUploadImage", sender: self)
           
            }
            
                
                
        }
 
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
    
            func buttonEnabled(buttonName: UIButton){
                
                buttonName.enabled = true
            }
            func buttonDisabeld(buttonName: UIButton){
                
                buttonName.enabled = false
            }

    
}

