//
//  ContactDetailTableViewCell.swift
//  PhoneBook
//
//  Created by Neelam on 13/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactDetailTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var contactPropertyNameLabel: UILabel!
    @IBOutlet weak var contactPropertyInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
