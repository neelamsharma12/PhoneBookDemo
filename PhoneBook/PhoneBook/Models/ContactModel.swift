//
//  ContactModel.swift
//  PhoneBook
//
//  Created by Neelam on 13/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactModel: NSObject {
    var favorite: Int?
    var ID: Int?
    var firstName: String?
    var lastName: String?
    var profilePic: String?
    var url: String?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        favorite = dictionary["favorite"] as? Int
        ID = dictionary["id"] as? Int
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        profilePic = dictionary["profile_pic"] as? String
        url = dictionary["url"] as? String
    }
}
