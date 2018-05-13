//
//  ContactDetailModel.swift
//  PhoneBook
//
//  Created by Neelam on 13/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactDetailModel: NSObject {

    var ID: Int?
    var firstName: String?
    var email: String?
    var lastName: String?
    var phoneNumber: String?
    var profilePic: String?
    var favorite: Bool?
    var createdAt: String?
    var updatedAt: String?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        
        ID = dictionary["id"] as? Int
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        phoneNumber = dictionary["phone_number"] as? String
        profilePic = dictionary["profile_pic"] as? String
        favorite = dictionary["favorite"] as? Bool
        createdAt = dictionary["created_at"] as? String
        updatedAt = dictionary["updated_at"] as? String
    }
}
