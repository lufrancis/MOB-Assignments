//
//  ConfirmViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 13/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class ConfirmViewController: UIViewController {

    //declare variables from segue
    var firstName = ""
    var lastName = ""
    var contactString = ""
    var typeString = ""
    var picImage = UIImage(named: "Empty Person.jpg")!
    var strCurrency = ""
    var strAmount = ""
    var cost =  0.0
    var strPasscode = ""
    
    //declare additional variables
    var strBaseCurrency = "HKD"
    var balance = 0.0
    
    //Outlet from View
    @IBOutlet weak var labelCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelCost.text = "\(strBaseCurrency) \(cost)"
        
    }

    @IBAction func payPressed(sender: AnyObject) {
        var user = PFUser.currentUser()
        var currencies: [String] = [""]
        var balances:[Double] = []
        var username = ""
        var fromFirstname = ""
        var fromLastname = ""
        
        // get user details
        if let user = user {
            if let tempString = user["username"] as? String {
                username = tempString
            }
            if let tempString = user["FirstName"] as? String {
                fromFirstname = tempString
            }
            if let tempString = user["LastName"] as? String {
                fromLastname = tempString
            }
            if let validArr = user["Currency"] as? [String] {
                currencies = validArr as [String]!
            }
            if let validArr = user["Balance"] as? [Double] {
                balances = validArr as [Double]!
            }
        }
        
        // check if user has sufficient funds to transfer payment
        var count = 0
        if contains(currencies, strBaseCurrency.uppercaseString) {
            
        }
        else {
                let alert = UIAlertController(title: "Insufficient fund", message: "Balance in your \(strBaseCurrency) account is \(balance)", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
    
        // deduct cost from balance and save new balance
        while count < currencies.count {
            println("in while \(currencies[count])  \(balances[count])")
            if currencies[count] == strBaseCurrency {
                if balances[count] >= cost {
                    balances[count] = balances[count] - cost
                    balance = balances[count]
                    user?.setObject(balances, forKey: "Balance")
                    user?.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            var payment = PFObject(className: "Payment")
                            payment["From"] = username
                            payment["To"] = self.contactString
                            payment["Currency"] = self.strCurrency
                            payment["Amount"] = (self.strAmount as NSString).doubleValue
                            payment["Passcode"] = self.strPasscode.toInt()
                            payment["Status"] = "Pending"
                            payment["FromFirstName"] = fromFirstname
                            payment["FromLastName"] = fromLastname
                            payment["ToFirstName"] = self.firstName
                            payment["ToLastName"] = self.lastName
                            payment.saveInBackgroundWithBlock({ (sucess, error) -> Void in})
                        }
                    })
            
                } else {
                    let alert = UIAlertController(title: "Insufficient fund", message: "Balance in your \(strBaseCurrency) account is \(balance)", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            count++
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! ConfirmPayViewController
        
        destinationVC.firstName = firstName
        destinationVC.lastName = lastName
        destinationVC.contactString = contactString
        destinationVC.typeString = typeString
        destinationVC.picImage = picImage
        destinationVC.strCurrency = strCurrency
        destinationVC.strAmount = strAmount
        destinationVC.cost = cost
        destinationVC.strPasscode = strPasscode
        
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
