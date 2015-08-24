//
//  EnterPasscodeViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 16/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class EnterPasscodeViewController: UIViewController {

    @IBOutlet weak var txtBox1: UITextField!
    @IBOutlet weak var txtBox2: UITextField!
    @IBOutlet weak var txtBox3: UITextField!
    @IBOutlet weak var txtBox4: UITextField!
    @IBOutlet weak var txtBox5: UITextField!
    @IBOutlet weak var txtBox6: UITextField!
    
    // coding for auto move to next text field
    @IBAction func txt1EditingChanged(sender: UITextField) {
        var text = sender.text
        if (count(text) == 1) {
            txtBox2.becomeFirstResponder()
        }
    }
    
    @IBAction func txt2EditingChanged(sender: UITextField) {
        var text = sender.text
        if (count(text) == 1) {
            txtBox3.becomeFirstResponder()
        }
    }
    
    @IBAction func txt3EditingChanged(sender: UITextField) {
        var text = sender.text
        if (count(text) == 1) {
            txtBox4.becomeFirstResponder()
        }
    }
    
    @IBAction func txt4EditingChanged(sender: UITextField) {
        var text = sender.text
        if (count(text) == 1) {
            txtBox5.becomeFirstResponder()
        }
    }
    
    @IBAction func txt5EditingChanged(sender: UITextField) {
        var text = sender.text
        if (count(text) == 1) {
            txtBox6.becomeFirstResponder()
        }
    }
    
    // coding to limit text length to 1
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        if (range.length + range.location > count(textField.text) ) {
            return false;
        }
        let newLength = count(textField.text) + count(string) - range.length
        return newLength <= 1
    }
    
    // auto move to next text field when press enter
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == self.txtBox1 {
            self.txtBox2.becomeFirstResponder()
        }
        else if textField == self.txtBox2 {
            self.txtBox3.becomeFirstResponder()
        }
        else if textField == self.txtBox3 {
            self.txtBox4.becomeFirstResponder()
        }
        else if textField == self.txtBox4 {
            self.txtBox5.becomeFirstResponder()
        }
        else if textField == self.txtBox5 {
            self.txtBox6.becomeFirstResponder()
        }
        
        return false
    }

    
    var currency = ""
    var amount = 0.0
    var objId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedOK(sender: AnyObject) {
        // show moving progress circle
        let hud = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        
        // get passcode from input text boxes
        var passCode = txtBox1.text + txtBox2.text + txtBox3.text + txtBox4.text + txtBox5.text + txtBox6.text
        println(passCode)
        println(objId)
        
        // get payment object
        var query = PFQuery (className: "Payment")
        query.whereKey("objectId", equalTo: objId)
        var object = query.getObjectWithId(objId)
        
        // hide moving progress circle
        MBProgressHUD.hideAllHUDsForView(self.navigationController?.view, animated: true)
        
        //check passcode of payment
        println("successful query")
        let obj = object as PFObject!
        var pass = obj["Passcode"] as! Int
        if pass == passCode.toInt() {
            self.performSegueWithIdentifier("segueFromPasscode", sender: AnyObject?())
        }
        else {
            MBProgressHUD.hideAllHUDsForView(self.navigationController?.view, animated: true)
            let alert = UIAlertController(title: "Incorrect Passcode", message: "Enter correct passcode set by the sender", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! DepositViewController

            destinationVC.objId = self.objId
            destinationVC.currency = self.currency
            destinationVC.amount = self.amount
            
            
        }
    
    

}
