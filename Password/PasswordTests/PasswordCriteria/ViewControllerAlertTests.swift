//
//  ViewControllerAlertTests.swift
//  PasswordTests
//
//  Created by Mohamed Elatabany on 23/03/2022.
//

import Foundation
import XCTest

@testable import Password
class AlertTests: XCTestCase {
    
    var vc: ViewController!
    
    var validPassword = "abc123456@"
    var shortPassword = "12345@"

    
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    
    func testShowSuccess() throws {
        vc.newPassword = validPassword
        vc.confirmPassword = validPassword
        vc.resetPasswordButtonTapped()

        XCTAssertNotNil(vc.alert)
    }
    
    
    func testShowError() throws {
        vc.newPassword = validPassword
        vc.confirmPassword = shortPassword

        vc.resetPasswordButtonTapped()
        XCTAssertNil(vc.alert)
    }
    
    

    
    
}


