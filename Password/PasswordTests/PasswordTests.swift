//
//  PasswordTests.swift
//  PasswordTests
//
//  Created by Mohamed Elatabany on 21/03/2022.
//

import Foundation
import XCTest

@testable import Password
class Test: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
        vc.loadViewIfNeeded()
    }
    
    
    func testShouldBeVisible() throws {
        let isViewLoaded = vc.isViewLoaded
        XCTAssertTrue(isViewLoaded)
    }
    
}


