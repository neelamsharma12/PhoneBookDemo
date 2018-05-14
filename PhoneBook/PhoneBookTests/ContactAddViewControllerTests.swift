//
//  ContactAddViewControllerTests.swift
//  PhoneBookTests
//
//  Created by Neelam on 14/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import XCTest
@testable import PhoneBook

class ContactAddViewControllerTests: XCTestCase {
     var contactAddVC = ContactAddViewController()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        contactAddVC = (storyboard.instantiateViewController(withIdentifier: "contactAddVC") as? ContactAddViewController)!
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testThatViewLoads() {
        XCTAssertNotNil(contactAddVC.view, "View not initiated properly")
    }
    
    func testThatParentViewHasTableViewSubview() {
        let views = contactAddVC.view
        XCTAssertTrue((views?.contains(contactAddVC.addContactDetailTableView))!, "View does not have a table subview")
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(contactAddVC.conforms(to:UITableViewDataSource.self),"View does not conform to UITableView datasource protocol")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue(contactAddVC.conforms(to:UITableViewDelegate.self),"View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewCellForRowAtIndexPath() {
        let _ = contactAddVC.view
        let indexPath = IndexPath(row: 0, section: 0)
        let _ = contactAddVC.tableView(contactAddVC.addContactDetailTableView, cellForRowAt: indexPath)
        XCTAssert(true)
    }
    
    func testTableViewHeightForRowAtIndexPath() {
        let _ = contactAddVC.view
        let indexPath = IndexPath(row: 0, section: 0)
        let _ = contactAddVC.tableView(contactAddVC.addContactDetailTableView, heightForRowAt: indexPath)
        XCTAssert(true)
    }
    
    func testTableViewNumberForRowAtIndexPath() {
        let _ = contactAddVC.view
        let _ = contactAddVC.tableView(contactAddVC.addContactDetailTableView, numberOfRowsInSection: 0)
        XCTAssert(true)
    }
    
    func testDidFinishEditingContactDetails() {
        contactAddVC.didFinishEditingContactDetails(updatedData: "Test", propertyTag: 0)
        XCTAssert(true)
    }
}
