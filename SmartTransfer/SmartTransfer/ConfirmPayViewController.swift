//
//  ConfirmPayViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 13/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import MessageUI.MFMessageComposeViewController
import Parse

class ConfirmPayViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    var firstName = ""
    var lastName = ""
    var contactString = ""
    var typeString = ""
    var picImage = UIImage(named: "Empty Person.jpg")!
    var strCurrency = ""
    var strAmount = ""
    var cost = 0.0
    var strPasscode = ""
    
    @IBOutlet weak var imagePic: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Send SMS
        sendSMS(self)
        
        imagePic.image = picImage
        imagePic.layer.cornerRadius = 50.0
        imagePic.clipsToBounds = true
        labelName.text = firstName + " " + lastName
        labelType.text = typeString
        labelContact.text = contactString
        
        txtView.text = "Currency: \(strCurrency) \nAmount: \(strAmount)\nPasscode: \(strPasscode)\n\n\(firstName) \(lastName) will receive a notification of this payment. \n\nThank you for using SmartTransfer.\n\nYou have saved HKD\(cost * 0.2) compared to transfer through banks!"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        if (MFMessageComposeViewController.canSendText()) {
//            let controller = MFMessageComposeViewController()
//            controller.body = "Message Body - Test"
//            controller.recipients = ["98587731"]
//            controller.messageComposeDelegate = self
//            self.presentViewController(controller, animated: true, completion: nil)
//        }
//    }
//    
//    @IBAction func sendSMS(sender: AnyObject) {
////        UIApplication.sharedApplication.openURL("sms:98587731")
//    }
    
//    }
    func sendSMS(sender: AnyObject) {
        var user = PFUser.currentUser()
        var sender = ""
        var fromFirstName = ""
        var fromLastName = ""

        if let tempString = user?["FirstName"] as? String {
            fromFirstName = tempString
        }
        
        if let tempString = user?["LastName"] as? String {
            fromLastName = tempString
        }
        
        if firstName != "" || lastName != "" {
            sender = fromFirstName + " " + fromLastName
        }
        else {
            sender = user?.username as String!
        }
        
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "\(strCurrency)\(strAmount) has been sent to you from \(sender).  Retrieve the amount by using SMART Transfer app from AppStore!"
            controller.recipients = ["+85296623593"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
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
