//
//  DepositCompleteViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 17/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class DepositCompleteViewController: UIViewController {

    var currency = ""
    var amount = 0.00
    var newBalance = 0.0

    
    @IBOutlet weak var txtBoxView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get user balance
        var user = PFUser.currentUser()
        if let user = user {
            let currencies = user["Currency"] as! [String]
            let balances = user["Balance"] as! [Double]
            var count = 0
            while count < currencies.count {
                if currencies[count] == currency {
                newBalance = balances[count]
                }
                count++
            }
        }
        
        
        println("newBalance is \(newBalance)")
        
        txtBoxView.text = ("\(currency)\(amount) has been successfully deposited!\n\nYour new balance is \(currency)\(newBalance)\n\nThank you for using SmartTransfer and you too can save money by sending through SmartTransfer.")
        
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
