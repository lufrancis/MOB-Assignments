//
//  ConfirmSendViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 13/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit

class ConfirmSendViewController: UIViewController {

    var firstName = ""
    var lastName = ""
    var contactString = ""
    var typeString = ""
    var picImage = UIImage(named: "Empty Person.jpg")!
    var strCurrency = ""
    var strAmount = ""
    var strPasscode = ""
    var cost = 0.0
    
    @IBOutlet weak var imagePic: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePic.image = picImage
        imagePic.layer.cornerRadius = 50.0
        imagePic.clipsToBounds = true
        labelName.text = firstName + " " + lastName
        labelType.text = typeString
        labelContact.text = contactString
        
        var rate = 0.0
        if strCurrency == "USD" {
            rate = 7.75
        }
        if strCurrency == "HKD" {
            rate = 1
        }
        if strCurrency == "GBP" {
            rate = 12.11
        }

        cost = rate * (strAmount as NSString).doubleValue
        
        txtView.text = "Currency: \(strCurrency) \nAmount: \(strAmount)\nPasscode: \(strPasscode)\n\nExchange Rate: HKD \(rate) \nFees and Charges: ZERO\nTotal Cost: HKD \(cost)"
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! ConfirmViewController
        
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
