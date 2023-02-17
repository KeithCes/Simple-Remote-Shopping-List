//
//  LandingViewUITests.swift
//  Simple-Remote-Shopping-ListUITests
//
//  Created by Keith C on 2/17/23.
//

import Foundation
import XCTest

class LandingViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testCreateList() throws {
        let app = XCUIApplication()
        app.launchArguments += ["-TestUserLoggedIn"]
        app.launch()
        
        // tap create new list button
        let createListButton = app.buttons["createListButton"]
        XCTAssert(createListButton.exists)
        createListButton.tap()
        sleep(3)
        
        // check save button exists (we made it to edit list view and can save)
        XCTAssert(app.buttons["SAVE"].exists)
    }
    
    func testLogoutButton() throws {
        let app = XCUIApplication()
        app.launchArguments += ["-TestUserLoggedIn"]
        app.launch()
        
        // tap logout button
        let logoutButton = app.buttons["logoutButton"]
        XCTAssert(logoutButton.exists)
        logoutButton.tap()
        sleep(3)
        
        // check login button exists (we logged out successfully)
        XCTAssert(app.buttons["LOGIN"].exists)
    }
}
