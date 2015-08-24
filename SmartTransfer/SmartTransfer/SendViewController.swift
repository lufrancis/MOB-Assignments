//
//  SendViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 2/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var firstName: String = ""
    var lastName: String = ""
    var contactString: String = ""
    var typeString: String = ""
    var picImage: UIImage = UIImage(named: "Empty Person.jpg")!
    var pickerDataSource = ["USD", "HKD", "GBP"]
    var strCurrency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // set label values for display
        name.text = firstName + " " + lastName
        labelType.text = typeString + ":"
        contact.text = contactString
        // make rounded corners for picture
        pic.image = picImage
        pic.layer.cornerRadius = 50.0
        pic.clipsToBounds = true
        
        // set delegates
        currencyPicker.dataSource = self
        self.currencyPicker.delegate = self
        self.txtAmount.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        var row = 0
        var repeatPickerData: NSArray = []
        
        row = currencyPicker.selectedRowInComponent(0)
        strCurrency = pickerDataSource[row]
        
        // set exchange rates
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
        var amount = (txtAmount.text as NSString).doubleValue
        
        
        // display cost for the transfer amount
        textView.text = "Send Amount: \(strCurrency) \(txtAmount.text)\nRate: HKD \(rate) \nAmount in HKD: \(rate * amount) \n\nTransfer Fees: FREE\nHandling Charges: FEEE\nOther Hidden Cost: Zero\n\nTotal Cost HKD: \(rate * amount)"
        
        return false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        var pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = pickerDataSource[row]
        // set custom fonts
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 18)
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! SetPassViewController
        
            destinationVC.firstName = firstName
            destinationVC.lastName = lastName
            destinationVC.contactString = contactString
            destinationVC.typeString = typeString
            destinationVC.picImage = pic.image!
            destinationVC.strCurrency = strCurrency
            destinationVC.strAmount = txtAmount.text
        
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
