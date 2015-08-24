//
//  ReceiveViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 15/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class ReceiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var payments: [PFObject] = []
    var arrObjId: [String] = []
    var arrFrom: [String] = []
    var arrFromFirstName: [String] = []
    var arrFromLastName: [String] = []
    var arrCurrency: [String] = []
    var arrAmount: [Double] = []
    var arrPasscode: [Int] = []
    var arrStatus: [String] = []
    var arrCreated: [NSDate] = []
    var firstname = ""
    var lastname = ""
    var fullname = ""
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Receive"
        
        // search for pending payments for deposit
        searchForPayments()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func searchForPayments () {
        payments = []
        arrObjId = []
        arrFrom = []
        arrFromFirstName = []
        arrFromLastName = []
        arrCurrency = []
        arrAmount = []
        arrPasscode = []
        arrStatus = []
        arrCreated = []
        firstname = ""
        lastname = ""
        fullname = ""
        
        // show moving progress circle
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        // get current user's email address and mobile phone number
        var user = PFUser.currentUser()
        var username = ""
        var mobile = ""
        if let user = user {
            if let tempString = user["username"] as? String {
                username = tempString
            }
            if let tempString = user["Mobile"] as? String {
                mobile = tempString
            }
        }
        
        // search for payments using user's email address and mobile phone number
        var query1 = PFQuery (className: "Payment")
        query1.whereKey("To", equalTo: username)
        println(username)
        
        var query2 = PFQuery (className: "Payment")
        query2.whereKey("To", equalTo: mobile)
        println(mobile)
        
        var orQuery = PFQuery.orQueryWithSubqueries([query1,query2])
        
        // store pending payment details in arrays
        orQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                println("success!")
                println(objects)
                let payments = objects as! [PFObject]
                println("payments")

                var count = 0
                while count < payments.count {
                    var status = payments[count]["Status"] as! String
                    if status == "Pending" {
                        var objId = payments[count].objectId as String!
                        
                        self.arrObjId.append(objId)
                        
                        var from = payments[count]["From"] as! String
                        self.arrFrom.append(from)
                        
                        
                        var fromFirst = ""
                        if let tempString = payments[count]["FromFirstName"] as? String {
                            fromFirst = tempString
                        }
                        self.arrFromFirstName.append(fromFirst)
                        
                        var fromLast = ""
                        if let tempString = payments[count]["FromLastName"] as? String {
                            fromLast = tempString
                        }
                        self.arrFromLastName.append(fromLast)
                        
                        var currency = payments[count]["Currency"] as! String
                        self.arrCurrency.append(currency)
                        var amount = payments[count]["Amount"] as! Double
                        self.arrAmount.append(amount)
                        var passcode =
                        payments[count]["Passcode"] as! Int
                        var created = payments[count].createdAt
                        self.arrCreated.append(created!)
                    }
                    count++
                }
                
                if self.arrFrom.count == 0 {
                    let alert = UIAlertController(title: "No Payments", message: "There are no payments to you!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                // reloading table
                println("reloading table")
                self.tableView.reloadData()
            }
            else {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                println("error!")
            }
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("rows: \(arrFrom.count)")
        println(arrFrom)

        return arrFrom.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        let row = indexPath.row
        
        //prepare full name for display in table cell title
        firstname = arrFromFirstName[row]
        lastname = arrFromLastName[row]
        if firstname == "" || lastname == "" {
           fullname = self.arrFrom[row] as String
        }
        else {
            fullname = firstname + " " + lastname
        }
        cell.textLabel?.text = fullname + " sent " + arrCurrency[row] + String(format: "%.2f", arrAmount[row])

        // prepare date for display in table cell subtitle
        let formatter = NSDateFormatter()
        
        // Only the date style is defined:
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .LongStyle
        cell.detailTextLabel?.text = formatter.stringFromDate(arrCreated[row])
        
        println("From: \(arrFrom[row])")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! EnterPasscodeViewController
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            destinationVC.objId = self.arrObjId[indexPath.row]
            destinationVC.currency = self.arrCurrency[indexPath.row]
            destinationVC.amount = self.arrAmount[indexPath.row]
            
            
        }
    }
}

