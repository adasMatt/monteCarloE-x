//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Jeff Terry on 12/31/20.
//

import XCTest

class Tests_macOS: XCTestCase {

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

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    /*
    func testBoundingBoxVolume() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let myBoundingBox = BoundingBox()
        let length = 1.0
        let width = 2.2
        let height = 4.3
        
        let volume = myBoundingBox.calculateVolume(lengthOfSide1: length, lengthOfSide2: width, lengthOfSide3: height)
        
        // Then
        XCTAssertEqual(volume, 9.46, accuracy: 0.000000001, "expected better from you")
    }
    
    func testBoundingBoxSurfaceArea() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let myBoundingBox = BoundingBox()
        let length = 1.0
        let width = 2.2
        let height = 4.3
        
        let surfaceArea = myBoundingBox.calculateSurfaceArea(numberOfSides: 6, lengthOfSide1: length, lengthOfSide2: width, lengthOfSide3: height)
        // Then
        XCTAssertEqual(surfaceArea, 31.92, accuracy: 0.000000001, "expected better from you")
    }
    
    func testMonteCarloIntegral() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let monteCarlo = MonteCarloCircle(withData: true)
        
        monteCarlo.guesses = 9120217
        monteCarlo.calculatePI()
        
        let ourPI = Double(monteCarlo.piString)
        
        // Then
        XCTAssertEqual(ourPI!, Double.pi, accuracy: 0.005, "expected better from you")
        
        let totalGuesses = Double(monteCarlo.totalGuesses)
        XCTAssertEqual(totalGuesses, 9120217, accuracy: 0.005, "expected better from you")
        
    }
*/

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
