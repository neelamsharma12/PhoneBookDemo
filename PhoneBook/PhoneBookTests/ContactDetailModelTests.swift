//
//  ContactDetailModel.swift
//  PhoneBookTests
//
//  Created by Neelam on 14/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import XCTest
@testable import PhoneBook

class ContactDetailModelTests: XCTestCase {
     var _ContactDetailModel: ContactDetailModel?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInitContactDetailModel() {
        var contactDetailsDict = [String: Any]()
        
        contactDetailsDict["favorite"] =  true
        contactDetailsDict["id"] = 1
        contactDetailsDict["first_name"] = "Test_FirstName"
        contactDetailsDict["last_name"] = "Test_LastName"
        contactDetailsDict["phone_number"] = "+1234567890"
        contactDetailsDict["profile_pic"] = "/images/missing.png"
        contactDetailsDict["email"] = "test@gmail.com"
        contactDetailsDict["created_at"] = ""
        contactDetailsDict["updated_at"] = ""
        
        _ContactDetailModel = ContactDetailModel(with: contactDetailsDict)
        XCTAssertTrue(true)
    }
}
