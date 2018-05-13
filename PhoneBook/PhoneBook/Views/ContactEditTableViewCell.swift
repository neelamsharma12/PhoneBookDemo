//
//  ContactEditTableViewCell.swift
//  PhoneBook
//
//  Created by Neelam on 13/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

protocol UpdateContactDetailsProtocol: class {
    /**
     Protocol method get called to update the contact details
     - parameter contactData: ContactDetailModel
     - returns:
     */
    func didFinishEditingContactDetails(updatedData: String?, propertyTag: Int)
}

class ContactEditTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var editContactPropertyNameLabel: UILabel!
    @IBOutlet weak var editContactPropertyInfoLabel: UITextField!
    
    //MARK :- Variable declaration
    weak var delegate: UpdateContactDetailsProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editContactPropertyInfoLabel.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ContactEditTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editContactPropertyInfoLabel.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didFinishEditingContactDetails(updatedData: textField.text, propertyTag: textField.tag)
    }
}

