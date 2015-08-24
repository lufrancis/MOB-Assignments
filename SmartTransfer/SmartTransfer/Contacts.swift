//
//  Contacts.swift
//  SmartTransfer
//
//  Created by Francis Lu on 1/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import Foundation
import UIKit

class Contact: NSObject {
    var pic: UIImage = UIImage(named: "Empty Person.jpg")!
    var firstName:String
    var lastName:String 
    var section: Int?
    var ContactType:[String] = []
    var ContactValue:[String] = []
    
    init(pic: UIImage, firstName: String, lastName: String, ContactType: [String], ContactValue: [String]) {
        self.pic = pic
        self.firstName = firstName
        self.lastName = lastName
        self.ContactType = ContactType
        self.ContactValue = ContactValue
    }
    
}
class ContactSection {
    var Contacts: [Contact] = []
        
    func addContact (contact:Contact) {
            self.Contacts.append(contact)
    }
}