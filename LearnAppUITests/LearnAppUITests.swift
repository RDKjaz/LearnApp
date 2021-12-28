//
//  LearnAppUITests.swift
//  LearnAppUITests
//
//  Created by Radik Gazetdinov on 28.12.2021.
//

import XCTest

class LearnAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    func testNavigationOnMenuView() throws {
        app.buttons["Новая игра"].tap()
        XCTAssert(app.staticTexts["Игра началась"].exists)
        
        app.buttons["Меню"].tap()
        app.buttons["Настройки"].tap()
        XCTAssert(app.staticTexts["Таймер"].exists)
        
        app.buttons["Меню"].tap()
        app.buttons["Рекорд"].tap()
        XCTAssert(app.navigationBars["Рекорд"].exists)
    }
    
    func testTapOnDefaultSettingsButton() throws {
        app.buttons["Настройки"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["30 сек"]/*[[".cells.staticTexts[\"30 сек\"]",".staticTexts[\"30 сек\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["20"]/*[[".cells.staticTexts[\"20\"]",".staticTexts[\"20\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.buttons["Настройки по умолчанию"].tap()
        XCTAssert(app.tables.staticTexts["30 сек"].exists)
    }
}
