//
//  PazaramaCloneAppUITests.swift
//  PazaramaCloneAppUITests
//
//  Created by bora ateş on 26.07.2023.
//

import XCTest

final class PazaramaCloneAppUITests: XCTestCase {

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

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testCart() {
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews",".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 2 pages\")",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.staticText, identifier:"Women dresses").buttons["sepete ekle"].tap()
        app/*@START_MENU_TOKEN@*/.collectionViews/*[[".scrollViews.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.staticText, identifier:"Womens dress").element.tap()
        app.buttons["sepete ekle"].tap()
        app.navigationBars["Pazarama.ProductDetailView"].buttons["Back"].tap()
        
        let table = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.swipeDown()
        app.tables.staticTexts["Women dresses"].swipeDown()
        
        table.swipeDown()
        app.buttons["Sepeti Onayla"].tap()
        app.alerts["Sepeti Onayla"].scrollViews.otherElements.buttons["Yes"].tap()
                
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
