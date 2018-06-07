//
//  Contact+CoreDataProperties.swift
//  PhoneBook
//
//  Created by Neelam on 07/06/18.
//  Copyright © 2018 Neelam. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var favorite: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var profilePic: String?
    @NSManaged public var url: String?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?

}
