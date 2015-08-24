//
//  SetPassViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 13/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit


class SetPassViewController: UIViewController, UITextFieldDelegate {

    var firstName = ""
    var lastName = ""
    var contactString = ""
    var typeString = ""
    var picImage = UIImage(named: "Empty Person.jpg")!
    var strCurrency = ""
    var strAmount = ""
    var passCode = ""
    
    @IBOutlet weak var txtBox1: UITextField!
    @IBOutlet weak var txtBox2: UITextField!
    @IBOutlet weak var txtBox3: UITextField!
    @IBOutlet weak var txtBox4: UITextField!
    @IBOutlet weak var txtBox5: UITextField!
    @IBOutlet weak var txtBox6: UITextField!
    
    // coding for auto move to next text box after entry of one character
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
    
    @IBAction func txt5EditingChange(sender: UITextField) {
        var text = sender.text
        if (count(text) == 1) {
            txtBox6.becomeFirstResponder()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set cursor to first text box
        
        self.txtBox1.delegate = self
        self.txtBox2.delegate = self
        self.txtBox3.delegate = self
        self.txtBox4.delegate = self
        self.txtBox5.delegate = self
        self.txtBox6.delegate = self

        txtBox1.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // coding to limit max character to 1
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (range.length + range.location > count(textField.text) )
        {
            
            return false;
        }
        
        let newLength = count(textField.text) + count(string) - range.length
        return newLength <= 1
    }
    
    // move to next text box upon pressing return
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! ConfirmSendViewController
        
        passCode = txtBox1.text + txtBox2.text + txtBox3.text + txtBox4.text + txtBox5.text + txtBox6.text
        
        destinationVC.firstName = firstName
        destinationVC.lastName = lastName
        destinationVC.contactString = contactString
        destinationVC.typeString = typeString
        destinationVC.picImage = picImage
        destinationVC.strCurrency = strCurrency
        destinationVC.strAmount = strAmount
        destinationVC.strPasscode = passCode
        
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
