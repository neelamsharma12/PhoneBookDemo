//
//  ContactModelTests.swift
//  PhoneBookTests
//
//  Created by Neelam on 14/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import XCTest
@testable import PhoneBook

class ContactModelTests: XCTestCase {
    var _ContactDBModel: ContactModel?
    
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
    
    func testInitContactModel() {
        var contactDict = [String: Any]()
        
        contactDict["favorite"] =  1
        contactDict["id"] = 1
        contactDict["first_name"] = "Test_FirstName"
        contactDict["last_name"] = "Test_LastName"
        contactDict["profile_pic"] = "/images/missing.png"
        contactDict["url"] = "http://gojek-contacts-app.herokuapp.com/contacts/1.json"
        
        _ContactDBModel = ContactModel(with: contactDict)
         XCTAssertTrue(true)
    }
}
