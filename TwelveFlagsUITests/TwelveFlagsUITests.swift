//
//  TwelveFlagsUITests.swift
//  TwelveFlagsUITests
//
//  Created by RnD on 3/6/21.
//

import XCTest

class TwelveFlagsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        continueAfterFailure = false
    }

    func testGenerateScreenshots() throws {
        // Automate capturing of screenshots
        snapshot("01HomeScreen")
        
        app.buttons["Single Player"].tap()
        
        snapshot("02SinglePlayer")
        
        app.buttons["Quit to Main Menu"].tap()
        
        app.buttons["Ranked Mode, COMPETE WITH PLAYERS WORLDWIDE"].tap()
        
        snapshot("03RankedMode")
        
        app.buttons["Settings"].tap()
        
        snapshot("04Settings")
        
        app.swipeDown(velocity: .fast)
        
        app.buttons["Submit Ranked Score"].tap()
        
        snapshot("05TopScores", timeWaitingForIdle: 3)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch the application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
