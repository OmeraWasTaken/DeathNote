//
//  DeathNoteUITests.swift
//  DeathNoteUITests
//
//  Created by Quentin Richard on 28/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import XCTest

class DeathNoteUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddDeath() {
        app.navigationBars["DeathNote.ListOfDeathView"].buttons["+"].tap()
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Jhon")
        var textField = app.textFields["Name"]
        XCTAssertEqual(textField.value as? String ?? "", "Jhon")
        app.textFields["LastName"].tap()
        app.textFields["LastName"].typeText("Smith")
        textField = app.textFields["LastName"]
        XCTAssertEqual(textField.value as? String ?? "", "Smith")
        app.buttons["Kill"].tap()
        let nameLabel = app.staticTexts["Jhon"]
        let lastNameLabel = app.staticTexts["Smith"]
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(lastNameLabel.exists)
    }
}
