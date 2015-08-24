//
//  ProfileViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 14/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    
    @IBOutlet weak var labelCurrency2: UILabel!
    @IBOutlet weak var labelBalance2: UILabel!
    
    @IBOutlet weak var labelCurrency3: UILabel!
    @IBOutlet weak var labelBalance3: UILabel!
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet weak var balanceView: UIView!
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Profile"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtLastName.delegate = self
        self.txtFirstName.delegate = self
        self.txtCountry.delegate = self
        self.txtAddress.delegate = self
        self.txtPostCode.delegate = self
        self.txtCity.delegate = self
        self.txtDOB.delegate = self
        
        balanceView.layer.cornerRadius = 30.0
        balanceView.clipsToBounds = true
        
        // Search for current user balances
        var user = PFUser.currentUser()
        var currencies: [String] = []
        var balances: [Double] = []
        
        // set labels with user's balances
        if let user = user {
            if let strCurrencies = user["Currency"] as? [String] {
                currencies = strCurrencies
            }
            if let doubleBalances = user["Balance"] as? [Double] {
                balances = doubleBalances
                var count = 0
                while count < currencies.count {
                    if currencies[count] == "HKD" {
                        labelBalance.text = String(format: "%.2f", balances[count])
                    }
                    else if currencies[count] == "GBP" {
                        labelBalance2.text = String(format: "%.2f", balances[count])
                    }
                    else if currencies[count] == "USD" {
                        labelBalance3.text = String(format: "%.2f", balances[count])
                    }
                    count++
                }
            }

            // set text boxes with existing user information
            if let lastName = user["LastName"] as? String {                    txtLastName.text = lastName
            }
            if let firstName = user["FirstName"] as? String {
             txtFirstName.text = firstName            }
            if let country = user["Country"] as? String {
                txtCountry.text = country
            }
            if let address = user["Address"] as? String {
                txtAddress.text = address
            }
            if let postCode = user["PostCode"] as? String {
                txtPostCode.text = postCode
            }
            if let city = user["City"] as? String {
                txtCity.text = city
            }

            if let doB = user["DOB"] as? NSDate {
                let formatter = NSDateFormatter()
                formatter.stringFromDate(doB)
                formatter.dateFormat = "dd/MM/yyyy"
                txtDOB.text = formatter.stringFromDate(doB)
            }
            
        }
        else {
            // user not logged in !
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)

        return false
    }

    // save updated details to User class
    @IBAction func savePressed(sender: AnyObject) {
        var user = PFUser.currentUser()
        if let user = user {
            user["LastName"] = txtLastName.text
            user["FirstName"] = txtFirstName.text
            user["Country"] = txtCountry.text
            user["Address"] = txtAddress.text
            user["PostCode"] = txtPostCode.text
            user["City"] = txtCity.text
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "dd/MM/yyyy"
            dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            if txtDOB.text != "" {
                if let doB = dateStringFormatter.dateFromString(txtDOB.text) as NSDate! {
                    user["DOB"] = doB
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Date", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            user.saveInBackgroundWithBlock({ (saved, error) -> Void in
                
            })
            self.view.endEditing(true)
        }
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
