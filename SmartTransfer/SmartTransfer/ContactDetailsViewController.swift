//
//  ContactDetailsViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 1/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nameFull: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label1Number: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    

    var firstName: String = ""
    var lastName: String = ""
    var typeText: [String] = []
    var numberText: [String] = []
    var contactType: [String] = []
    var contactNumber: [String] = []
    var pic: UIImage = UIImage(named: "Empty Person.jpg")!
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // set labels for display
        nameFull.text = firstName + " " + lastName
        // make rounded corners for pictures
        picture.image = pic
        picture.layer.cornerRadius = 50.0
        picture.clipsToBounds = true
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return typeText.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        // Strip out excess text from the string
        let typeText1 = typeText[row].stringByReplacingOccurrencesOfString("_$!<", withString: "", options: nil, range: nil)
        let typeText2 = typeText1.stringByReplacingOccurrencesOfString(">!$_", withString: "", options: nil, range: nil)
        // Set label with contact details
        cell.textLabel?.text = typeText2 + " :  " + numberText[row]
        contactType.append(typeText2)
        contactNumber.append(numberText[row])
        
        // grey out details which are not mobile or emails
        if (typeText2 != "Email") && (typeText2 != "Mobile") && (typeText2 != "iPhone") {
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.userInteractionEnabled = false
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! SendViewController
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            destinationVC.firstName = firstName
            destinationVC.lastName = lastName
            destinationVC.contactString = contactNumber[indexPath.row]
            destinationVC.typeString = String(contactType[indexPath.row])
            destinationVC.picImage = pic
            
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
