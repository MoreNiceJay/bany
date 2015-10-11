//
//  MoreInfoContactVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/8/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MoreInfoContactVC: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var preferPhoneNumberSwitch: UISwitch!
    @IBOutlet weak var preferEmailSwitch: UISwitch!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        startActivityIndicator()
        
        let phoneNumber =  phoneNumberTextField.text!
        let email =  emailTextField.text!
        
        
        
        if (phoneNumber.isEmpty || email.isEmpty) {
            
            alert("Invalid", message : "All fields must be filled")
            buttonEnabled(skipButton)
            buttonEnabled(saveButton)
            stopActivityIndicator()
        }else{
            
            if !(phoneNumber.utf16.count == 10  ) {
                // 3보다 크고 16보다 작은게 아니라면
                alert("Invalid", message : "phoneNumber 10")
                buttonEnabled(skipButton)
                buttonEnabled(saveButton)
                stopActivityIndicator()
                
            }else{
                //ㅇㅋ
                
                if !(email.utf16.count > 7 ) {
                    
                    alert("Invalid", message : "email more than 7")
                    buttonEnabled(skipButton)
                    buttonEnabled(saveButton)
                    stopActivityIndicator()
                    
                    
                    }else{
                        //굿투고
                        
                        
                        
                        //파스저장
                        let  user = PFUser.currentUser()!
                        
                        user.setObject(email, forKey: "email")
                        user.setObject(phoneNumber, forKey: "phoneNumber")
                    
                    if preferEmailSwitch.on == true{
                        user.setObject(email, forKey: "preferEmail")
                    }
                    if preferPhoneNumberSwitch.on == true{
                         user.setObject(phoneNumber, forKey: "preferPhoneNumber")
                        
                    }
                    
                        user.saveInBackgroundWithBlock { (success, error) -> Void in
                            self.stopActivityIndicator()
                            
                            if (error != nil)
                            {
                                self.alert("alert", message: (error?.localizedDescription)!)
                            }
                            
                            if(success) {
                                
                                self.performSegueWithIdentifier("moreInfoContactToMain", sender: self)
                                
                                
                                
                                self.alert("Success", message: "Your information save in your account")
                                
                            }
                        }
                    }
                }
                
         
        
        
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



func alert(title : String, message : String) {
    
    let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
    myAlert.addAction(okAction)
    self.presentViewController(myAlert, animated: true, completion: nil)
    
}

override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    phoneNumberTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
   
    
    
}
    func buttonEnabled(buttonName: UIButton){
        
        buttonName.enabled = true
    }
    func buttonDisabeld(buttonName: UIButton){
        
        buttonName.enabled = false
    }



//        user.setObject(phoneNumber, forKey: "phoneNumber")
//
//        //저장전 맞는 형식이 저장 됬나 확인 해야함.
//
//        if (preferPhoneNumberSwitch.on == true){
//            user.setObject(preferPhoneNumber, forKey: "preferPhoneNumber")
//        }
//        if (preferEmailSwitch.on == true){
//            user.setObject(preferEmailAddress, forKey: "preferEmail")
//        }
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
