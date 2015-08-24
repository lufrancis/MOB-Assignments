//
//  LogViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 19/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class LogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var payments: [PFObject] = []
    var arrObjId: [String] = []
    var arrFrom: [String] = []
    var arrFromFirstName: [String] = []
    var arrFromLastName: [String] = []
    var arrToFirstName: [String] = []
    var arrToLastName: [String] = []
    var arrCurrency: [String] = []
    var arrAmount: [Double] = []
    var arrPasscode: [Int] = []
    var arrStatus: [String] = []
    var arrCreated: [NSDate] = []
    var firstname = ""
    var lastname = ""
    var fullname = ""
    var username = ""
    var mobile = ""
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Log"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Show moving progress circle
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        var user = PFUser.currentUser()
        if let user = user {
            if let tempString = user["username"] as? String {
                username = tempString
            }
            if let tempString = user["Mobile"] as? String {
                mobile = tempString
            }
        }
        
        // set queries to search for current user payments in Payment Class
        var query1 = PFQuery (className: "Payment")
        query1.whereKey("To", equalTo: username)
        println("username is \(username)")
        
        var query2 = PFQuery (className: "Payment")
        query2.whereKey("To", equalTo: mobile)
        println("mobile is \(mobile)")
        
        var query3 = PFQuery(className: "Payment")
        query3.whereKey("From", equalTo: username)
        
        var query4 = PFQuery(className: "Payment")
        query4.whereKey("From", equalTo: mobile)
        
        // launch OR Query in Parse
        var orQuery = PFQuery.orQueryWithSubqueries([query1,query2, query3, query4])
        orQuery.addDescendingOrder("updatedAt")
        orQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                // remove the mocing progress circle
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                println("success!")
                println(objects)
                
                let payments = objects as! [PFObject]
                println("payments")
                
                // get payment detaisl into arrays
                var count = 0
                while count < payments.count {
                    var status = payments[count]["Status"] as! String
                    if status == "Deposited" || status == "Pending" {
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
                        if let var tempString = payments[count]["FromLastName"] as? String {
                            fromLast = tempString
                        }

                        self.arrFromLastName.append(fromLast)
                        
                        var toFirst = ""
                        if let tempString = payments[count]["ToFirstName"] as? String {
                            toFirst = tempString
                        }
                        self.arrToFirstName.append(toFirst)
                        
                        var toLast = ""
                        if let tempString = payments[count]["ToLastName"] as? String {
                            toLast = tempString
                        }
                        self.arrToLastName.append(toLast)
                        
                        var currency = payments[count]["Currency"] as! String
                        self.arrCurrency.append(currency)
                        
                        var amount = payments[count]["Amount"] as! Double
                        self.arrAmount.append(amount)
                        
                        var passcode =
                        payments[count]["Passcode"] as! Int
                        var created = payments[count].createdAt
                        self.arrCreated.append(created!)
                        
                        var status = payments[count]["Status"] as! String
                        self.arrStatus.append(status)
                    }
                    count++
                }
                
                // error message if no records
                if self.arrFrom.count == 0 {
                    let alert = UIAlertController(title: "No Transactions", message: "There are no Transactions!", preferredStyle: UIAlertControllerStyle.Alert)
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
        
        // Set values for the table cells
        firstname = arrFromFirstName[row]
        lastname = arrFromLastName[row]
        
        if firstname == "" || lastname == "" {
            fullname = self.arrFrom[row] as String
        }
        else {
            fullname = firstname + " " + lastname
        }
        
        if arrStatus[row] == "Pending" {
            cell.textLabel?.textColor = UIColor.redColor()
        }
        
        if arrFrom[row] == username || arrFrom[row] == mobile {
            cell.textLabel?.text = "Sent to \(arrToFirstName[row]) \(arrToLastName[row]) " + arrCurrency[row] + String(format: "%.2f", arrAmount[row])

        }
        else {
            cell.textLabel?.text = "Received from \(fullname) " + arrCurrency[row] + String(format: "%.2f", arrAmount[row])
        }
        
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .LongStyle
        cell.detailTextLabel?.text = formatter.stringFromDate(arrCreated[row])
        
        println("From: \(arrFrom[row])")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
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
