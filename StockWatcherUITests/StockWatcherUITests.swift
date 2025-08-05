//
//  StockWatcherUITests.swift
//  StockWatcherUITests
//
//  Created by David on 7/19/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import XCTest

class StockWatcherUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Verify that the main navigation title exists
        XCTAssertTrue(app.navigationBars["My Stocks"].exists)
        
        // Verify that basic UI elements are present
        XCTAssertTrue(app.buttons["Refresh"].exists || app.buttons.containing(NSPredicate(format: "label CONTAINS 'Refresh'")).count > 0)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            let launchMetric = XCTOSSignpostMetric.applicationLaunch
            let measureOptions = XCTMeasureOptions.default
            // Relax constraints for CI environment
            measureOptions.maxPercentRelativeStandardDeviation = 25.0
            measureOptions.maxPercentRegression = 25.0
            
            measure(metrics: [launchMetric], options: measureOptions) {
                XCUIApplication().launch()
            }
        }
    }
}
