//
//  RegisterViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 9/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import  Parse

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelMobile: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make rounded text boxes
        self.txtEmailAddress.delegate = self
        self.txtPassword.delegate = self
        self.txtConfirmPassword.delegate = self
        self.txtMobile.delegate = self
        
        buttonRegister.layer.cornerRadius = 8.0
        buttonRegister.clipsToBounds = true
        self.txtMobile.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function to display error messages
    func errorMessage (errorMessage: String, textField:UITextField) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.Default, handler: { (action) -> Void in
            textField.becomeFirstResponder()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func pressedRegister(sender: AnyObject) {
        var user = PFUser ()
        
        // check user input error
        if txtMobile.text == "" {
            
            labelMobile.textColor = UIColor.redColor()
            lblEmailAddress.textColor = UIColor.whiteColor()
            lblPassword.textColor = UIColor.whiteColor()
            lblConfirmPassword.textColor = UIColor.whiteColor()
            errorMessage("Smart Phone Number is blank!", textField: txtMobile)
        }
        
        else if txtEmailAddress.text == "" {

            labelMobile.textColor = UIColor.whiteColor()
            lblEmailAddress.textColor = UIColor.redColor()
            lblPassword.textColor = UIColor.whiteColor()
            lblConfirmPassword.textColor = UIColor.whiteColor()
            errorMessage("Email Address is blank!", textField: txtEmailAddress)

        }
        
        else if txtPassword.text == "" {

            labelMobile.textColor = UIColor.whiteColor()
            lblPassword.textColor = UIColor.redColor()
            lblEmailAddress.textColor = UIColor.whiteColor()
            lblConfirmPassword.textColor = UIColor.whiteColor()
            errorMessage("Password is blank!", textField: txtPassword)

        }
        
        else if txtConfirmPassword.text == "" {

            labelMobile.textColor = UIColor.whiteColor()
            lblConfirmPassword.textColor = UIColor.redColor()
            lblEmailAddress.textColor = UIColor.whiteColor()
            lblPassword.textColor = UIColor.whiteColor()
            errorMessage("Please confirm Password!", textField: txtConfirmPassword)

            
        }
        
        else if txtPassword.text != txtConfirmPassword.text {
            lblPassword.textColor = UIColor.redColor()
            lblConfirmPassword.textColor = UIColor.redColor()
            lblEmailAddress.textColor = UIColor.whiteColor()
            labelMobile.textColor = UIColor.whiteColor()
            errorMessage("Password Mismatch!", textField: txtPassword)
            
        }
        
        else {
            user["Mobile"] = txtMobile.text
            user.username = txtEmailAddress.text
            user.password = txtPassword.text
            user.email = txtEmailAddress.text
        
            user.signUpInBackgroundWithBlock { (success, error) -> Void in
                if (error == nil) {
                    println("success")
                    PFUser.logInWithUsername(user.username!, password: user.password!)
                    self.performSegueWithIdentifier("segueToMainScreen2", sender: AnyObject?())
                }
                else {
                    println (error)
                    self.errorMessage("User already exist!", textField: self.txtMobile)
                }
            }
        }

        
    }
    
    
    // move to next text box upon pressing enter
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if textField == self.txtMobile {
            self.txtEmailAddress.becomeFirstResponder()
        }
        
        else if textField == self.txtEmailAddress {
            self.txtPassword.becomeFirstResponder()
        }
        else if textField == self.txtPassword {
            self.txtConfirmPassword.becomeFirstResponder()
        }
        else if textField == self.txtConfirmPassword {
            self.buttonRegister.becomeFirstResponder()
            pressedRegister(self)
        }
        
        return false
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
