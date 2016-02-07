//
//  DataSourceTests.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/7/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import XCTest
@testable import FoodMob

class DataSourceTests: XCTestCase {
    
    var dataSource: FoodMobDataSource!
    
    // Similar to @Before
    override func setUp() {
        super.setUp()
        dataSource = MockDataSource()
    }
    
    // Similar to @After
    override func tearDown() {
        super.tearDown()
        dataSource = nil
    }
    
    func testValidateEmail() {
        let email = "jonathan@foodmob.me"
        XCTAssertTrue(dataSource.validateEmailAddress(email))
    }
    
    func testValidateInvalidEmail() {
        let email = "jonathan"
        XCTAssertFalse(dataSource.validateEmailAddress(email))
    }
    
    func testValidateName() {
        let name = "Jonathan"
        XCTAssertTrue(dataSource.validateName(name))
    }
    
    func testValidateNameInvalidName() {
        let name = ""
        XCTAssertFalse(dataSource.validateName(name))
    }
    
    func testValidatePasswordGoodAlphanumeric() {
        let password = "ThisIsAG00DP4ssW0rd"
        XCTAssertTrue(dataSource.validatePassword(password))
    }
    
    func testValidatePasswordGoodSymbols() {
        let password = "ThisIs@GoodPassword"
        XCTAssertTrue(dataSource.validatePassword(password))
    }
    
    func testValidatePasswordBadSingleClassLower() {
        let password = "passwordbros"
        XCTAssertFalse(dataSource.validatePassword(password))
    }
    
    func testValidatePasswordBadSingleClassUpper() {
        let password = "PASSWORD"
        XCTAssertFalse(dataSource.validatePassword(password))
    }
    
    func testValidatePasswordBadDoubleClass() {
        let password = "Password"
        XCTAssertFalse(dataSource.validatePassword(password))
    }
    
    func testValidatePasswordBadShort() {
        let password = "shorty"
        XCTAssertFalse(dataSource.validatePassword(password))
    }
    
    func testPasswordPerformance() {
        let password = "ThisIsAR3ALLyL0ngPass4Word4TestingPerf0rmAnceIssueSS"
        self.measureBlock { [unowned self] in
             self.dataSource.validatePassword(password)
        }
    }
    
}
