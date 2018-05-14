//
//  ContactsListViewControllerTests.swift
//  PhoneBookTests
//
//  Created by Neelam on 14/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import XCTest
@testable import PhoneBook

class ContactsListViewControllerTests: XCTestCase {
    var contactListVC = ContactsListViewController()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        contactListVC = (storyboard.instantiateViewController(withIdentifier: "contactListVC") as? ContactsListViewController)!
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
        XCTAssertNotNil(contactListVC.view, "View not initiated properly")
    }
    
    func testThatParentViewHasTableViewSubview() {
        let views = contactListVC.view
        XCTAssertTrue((views?.contains(contactListVC.contactsListTableView))!, "View does not have a table subview")
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(contactListVC.conforms(to:UITableViewDataSource.self),"View does not conform to UITableView datasource protocol")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue(contactListVC.conforms(to:UITableViewDelegate.self),"View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewCellForRowAtIndexPath() {
        let _ = contactListVC.view
        let indexPath = IndexPath(row: 0, section: 0)
        let _ = contactListVC.tableView(contactListVC.contactsListTableView, cellForRowAt: indexPath)
        XCTAssert(true)
    }
    
    func testTableViewHeightForRowAtIndexPath() {
        let _ = contactListVC.view
        let indexPath = IndexPath(row: 0, section: 0)
        let _ = contactListVC.tableView(contactListVC.contactsListTableView, heightForRowAt: indexPath)
        XCTAssert(true)
    }
    
    func testTableViewNumberForRowAtIndexPath() {
        let _ = contactListVC.view
        let _ = contactListVC.tableView(contactListVC.contactsListTableView, numberOfRowsInSection: 0)
        XCTAssert(true)
    }
}
