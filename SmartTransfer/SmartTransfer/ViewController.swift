//
//  ViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 28/7/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewSignin: UIView!
    @IBOutlet weak var labelLogo: UILabel!
    @IBOutlet weak var buttonSignin: UIButton!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtEmailAddress.delegate = self;
        self.txtPassword.delegate = self;
        
        // Give round corners to the text boxes
        viewSignin.layer.cornerRadius = 30.0
        viewSignin.clipsToBounds = true
        
        labelLogo.layer.cornerRadius = 20.0
        labelLogo.clipsToBounds = true
        
        buttonSignin.layer.cornerRadius = 8.0
        buttonSignin.clipsToBounds = true
        
        // Set cursor to first field
        self.txtEmailAddress.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == self.txtEmailAddress {
            self.txtPassword.becomeFirstResponder()
        }
        else if textField == self.txtPassword {
            self.buttonSignin.becomeFirstResponder()
            pressedSignIn(self)
        }
        
        
        return false
    }
    
    @IBAction func pressedSignIn(sender: AnyObject) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        var user = PFUser()
     
        PFUser.logInWithUsernameInBackground(txtEmailAddress.text, password: txtPassword.text) { (user, error) -> Void in
            if (error == nil) {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.performSegueWithIdentifier("segueToMainScreen", sender: AnyObject?())
            }
            else {
                let alert = UIAlertController(title: "Login Error", message: "Invalid Email Address or Password", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        }
    }
}

