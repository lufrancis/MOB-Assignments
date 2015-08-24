//
//  ContactsTableViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 28/7/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import AddressBook
import Parse

class ContactsTableViewController: UITableViewController {

        var ContactList:[Contact] = []
    
    
    // `UIKit` convenience class for sectioning a table
    let collation = UILocalizedIndexedCollation.currentCollation()
        as! UILocalizedIndexedCollation
    
    var contactSections: [ContactSection]  {
        // return if already initialized
        if self._sections != nil {
            return self._sections!
        }
        
        // create users from the name list
        var mycontacts: [Contact] = ContactList.map { mycontact in
            var mycontact = Contact(pic: mycontact.pic, firstName: mycontact.firstName, lastName: mycontact.lastName, ContactType: mycontact.ContactType, ContactValue: mycontact.ContactValue)
            mycontact.section = self.collation.sectionForObject(mycontact, collationStringSelector: "lastName")
            return mycontact
        }
        
        // create empty sections
        var contactSections = [ContactSection]()
        for i in 0..<self.collation.sectionIndexTitles.count {
            contactSections.append(ContactSection())
        }
        
        
        // put each user in a section
        for mycontact in mycontacts {
            contactSections[mycontact.section!].addContact(mycontact)
        }
        
        // sort each section
        for ContactSection in contactSections {
            ContactSection.Contacts = self.collation.sortedArrayFromArray(ContactSection.Contacts, collationStringSelector: "lastName") as! [Contact]
        }
        
        self._sections = contactSections
        
        return self._sections!
        
    }
    
    var _sections: [ContactSection]?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return self.contactSections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.contactSections[section].Contacts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contact = self.contactSections[indexPath.section].Contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! ContactTableViewCell
        
        // Configure the cell...
        cell.nameLabel?.text = self.contactSections[indexPath.section].Contacts[indexPath.row].firstName + " " + self.contactSections[indexPath.section].Contacts[indexPath.row].lastName
        cell.profilePic.image = self.contactSections[indexPath.section].Contacts[indexPath.row].pic
        cell.profilePic.layer.cornerRadius = 30.0
        cell.profilePic.clipsToBounds = true
        
        return cell
    }
    
    /* section headers
    appear above each `UITableView` section */
    override func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int)
        -> String {
            // do not display empty `Section`s
            if !self.contactSections[section].Contacts.isEmpty {
                return self.collation.sectionTitles[section] as! String
            }
            return ""
    }
    
    
    /* section index titles
    displayed to the right of the `UITableView` */
    override func sectionIndexTitlesForTableView(tableView: UITableView)
        -> [AnyObject] {
            return self.collation.sectionIndexTitles
    }
    
    
    override func tableView(tableView: UITableView,
        sectionForSectionIndexTitle title: String,
        atIndex index: Int)
        -> Int {
            return self.collation.sectionForSectionIndexTitleAtIndex(index)
    }
    

    // **************************
    // Working with address book
    // **************************
    lazy var addressBook: ABAddressBookRef = {
        var error: Unmanaged<CFError>?

        return ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue() as ABAddressBookRef
        }()
    
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Send"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // get authorization to access address book
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            print("Already authorized")
            readAllPeopleInAddressBook(addressBook)
        case .Denied:
            print("You are denied access to address book")
            
        case .NotDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook,
                {[weak self] (granted: Bool, error: CFError!) in
                    
                    if granted{
                        let strongSelf = self!
                        print("Access is granted")
                        strongSelf.readAllPeopleInAddressBook(strongSelf.addressBook)
                    } else {
                        print("Access is not granted")
                    }
                    
                })
        case .Restricted:
            print("Access is restricted")
            
        }
        
            }
    
    
    func readAllPeopleInAddressBook(addressBook: ABAddressBookRef) {
        
        /* Get all the people in the address book */
        let allPeople = ABAddressBookCopyArrayOfAllPeople(
            addressBook).takeRetainedValue() as NSArray

        var counter: Int = 0

        for person: ABRecordRef in allPeople{
            var AContact: Contact = Contact(pic: UIImage(named: "Empty Person.jpg")!, firstName: "", lastName: "", ContactType: [], ContactValue: [])
            var firstName: String = ""
            var lastName: String = ""

            // Get first and last name
            if let firstName = ABRecordCopyValue(person,
                kABPersonFirstNameProperty)?.takeRetainedValue() as? String {
            println(firstName)
            AContact.firstName = firstName
            }

            
            if let lastName  = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String {
                println(lastName)
                AContact.lastName = lastName
            }

            
            print("First name = \(firstName)")
            print("Last name = \(lastName)")
            

            // Get image
            var image =  ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)
            
            if image == nil{
                println("NIL FOUND")
            }
            else{
                println("PICTURE FOUND")
                var image2: NSObject? = Unmanaged<NSObject>.fromOpaque(image!.toOpaque()).takeRetainedValue()
                if image2 != nil {
                    AContact.pic = UIImage(data: image2! as! NSData)!
                }
            }
            
            // Get email addresses
            let emails: ABMultiValueRef = ABRecordCopyValue(person,
                kABPersonEmailProperty).takeRetainedValue()
            
            for counter in 0..<ABMultiValueGetCount(emails){
                let email = ABMultiValueCopyValueAtIndex(emails,
                    counter).takeRetainedValue() as! String
                println(email)
                AContact.ContactType.append("Email")
                AContact.ContactValue.append(email)
            }
            
            // Get phone numbers
            
            let phones: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
            
            for(var numberIndex : CFIndex = 0; numberIndex < ABMultiValueGetCount(phones); numberIndex++)
            {
                let phoneUnmanaged = ABMultiValueCopyValueAtIndex(phones, numberIndex)
                
                
                let phoneNumber : NSString = phoneUnmanaged.takeUnretainedValue() as! NSString
                
                let locLabel : CFStringRef = (ABMultiValueCopyLabelAtIndex(phones, numberIndex) != nil) ? ABMultiValueCopyLabelAtIndex(phones, numberIndex).takeUnretainedValue() as CFStringRef : ""
                
                var cfStr:CFTypeRef = locLabel
                var nsTypeString = cfStr as! NSString
                var swiftString:String = nsTypeString as String
                
                let customLabel = String (stringInterpolationSegment: ABAddressBookCopyLocalizedLabel(locLabel))
                
                // Store the phone number if it's a mobile
                let typeString: String = cfStr as! String

                AContact.ContactType.append(cfStr as! String)
                AContact.ContactValue.append(String(phoneNumber))

                
                println("Name :-\(locLabel) NO :-\(phoneNumber)" )
            }
            

            ContactList.append(AContact)
            
        }
        

    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            var destinationVC = segue.destinationViewController as! ContactDetailsViewController
            
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                destinationVC.firstName = self.contactSections[indexPath.section].Contacts[indexPath.row].firstName
                destinationVC.lastName = self.contactSections[indexPath.section].Contacts[indexPath.row].lastName
                
                destinationVC.pic = self.contactSections[indexPath.section].Contacts[indexPath.row].pic
            
                
                var counter3 = 0
                println(ContactList[indexPath.row].ContactType)
                for contactType in self.contactSections[indexPath.section].Contacts[indexPath.row].ContactType {
                    println(String(counter3))
                    destinationVC.typeText.append( self.contactSections[indexPath.section].Contacts[indexPath.row].ContactType[counter3])
                    destinationVC.numberText.append (self.contactSections[indexPath.section].Contacts[indexPath.row].ContactValue[counter3])
                    counter3++
                }
                
            }
        }
        
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.


}
