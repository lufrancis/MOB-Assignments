//
//  ContactDetailTableViewCell.swift
//  SmartTransfer
//
//  Created by Francis Lu on 12/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit

class ContactDetailTableViewCell: UITableViewCell {


    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
