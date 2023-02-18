//
//  PrelogViewUITests.swift
//  Simple-Remote-Shopping-ListUITests
//
//  Created by Keith C on 2/17/23.
//

import Foundation
import XCTest

class PrelogViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCreateButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Check that the create button is visible when the user is not logged in
        XCTAssert(app.buttons["CREATE"].exists)
        
        // Tap the create button and verify that the CreateAccountView is presented
        app.buttons["CREATE"].tap()
        XCTAssert(app.staticTexts["CREATE ACCOUNT"].exists)
    }
    
    func testLoginButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        // check that the login button is visible when the user is not logged in
        XCTAssert(app.buttons["LOGIN"].exists)
        
        // tap the login button
        app.buttons["LOGIN"].tap()
        
        // type email and password
        let emailField = app.textFields["loginEmailField"]
        emailField.tap()
        emailField.typeText("test@test.test")
        let passwordTextField = app.secureTextFields["loginPasswordField"]
        passwordTextField.tap()
        passwordTextField.typeText("testtest")
        
        // tap login button
        let loginButton = app.buttons["LOGIN"].firstMatch
        XCTAssert(loginButton.exists)
        loginButton.tap()
        sleep(3)
        
        let logoutButton = app.buttons["logoutButton"]
        XCTAssert(logoutButton.exists)
    }
}
