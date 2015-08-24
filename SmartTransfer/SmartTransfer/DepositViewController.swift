//
//  DepositViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 16/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class DepositViewController: UIViewController {

    var currency = ""
    var amount = 0.0
    var newBalance = 0.0
    var objId = ""
    var currencies: [String] = []
    var balances: [Double] = []
    var row = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedOK(sender: AnyObject) {
        // display moving progress circle
        let hud = MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true)
        
        // get current user balances and update the deposit currency and amount
        var user = PFUser.currentUser()
        if let user = user {
            if let arrayCurrency = user["Currency"] as? [String] {
                currencies = user["Currency"].flatMap{ $0 } as! [String]
                println("currencies are \(currencies) currency is \(currency)")
                let index = find(currencies, currency)
                if index != nil {
                    row = index as Int!
                    println("row is \(row) index is \(index)")
                }
                else {
                    println("appending currency \(currency)")
                    currencies.append(currency)
                    println(currencies)
                    user.setObject(currencies, forKey: "Currency")
                }
                println(currencies.count)
            }
            else {
                println("appending currency \(currency)")
                currencies.append(currency)
                println(currencies)
                user.setObject(currencies, forKey: "Currency")
            }
            
            if let arrayBalance = user["Balance"] as? [Double] {
                balances = arrayBalance
                println("row is \(row)")
                if row >= 0 {
                    println("adding \(amount)")
                balances[row] = balances[row] + amount
                user.setObject(balances, forKey: "Balance")
                newBalance = balances[row]
                    println("new balance is \(newBalance)")
                    
                }
                else {
                    println("appending balance\(amount)")
                    balances.append(amount)
                    println(balances)
                    user.setObject(balances, forKey: "Balance")
                    newBalance = amount
                   println("new balance 2 is \(newBalance)") 
                   
                    
                }
            }
            else {
                println("appending balance\(amount)")
                balances.append(amount)
                println(balances)
                user.setObject(balances, forKey: "Balance")
                newBalance = amount
                println("new balance 2 is \(newBalance)")
            }
            
            user.saveInBackgroundWithBlock({ (success, error) -> Void in
                println("saved successfully!")
                MBProgressHUD.hideAllHUDsForView(self.navigationController?.view, animated: true)
            })
            
            //Update payment status to Deposited
            var query = PFQuery (className: "Payment")
            var object = query.getObjectWithId(objId)
            let obj = object as PFObject!
            obj["Status"] = "Deposited"
            obj.saveInBackgroundWithBlock({ (success, error) -> Void in
                println("Deposited!!")
            })
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! DepositCompleteViewController
        
        destinationVC.currency = self.currency
        destinationVC.amount = self.amount

    }

}
