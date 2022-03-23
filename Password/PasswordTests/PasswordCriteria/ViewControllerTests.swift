//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Mohamed Elatabany on 23/03/2022.
//

import Foundation
import XCTest

@testable import Password
class ViewControllerTests_NewPasswordTests: XCTestCase {
    
    var vc: ViewController!
    
    var validPassword = "12345678Aa@"
    
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    

    /*
     
     Here we trigger those criteria blocks by entering text,
     clicking the rest password button, and check if the error label
     show valid message
     
     */
    
    
    func testEmptyPassword() throws {
        vc.newPassword = ""
        vc.resetPasswordButtonTapped()
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Enter your password")
    }
    
    
    
    func testInvalidPassword() throws {
        vc.newPassword = "👏"
        vc.resetPasswordButtonTapped()
        XCTAssertTrue(!vc.newPasswordTextField.errorLabel.isHidden)
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }
    
    
    func testCriteriaNotMet() throws {
        vc.newPassword = "asdfghjl@"
        vc.resetPasswordButtonTapped()
        XCTAssertTrue(!vc.newPasswordTextField.errorLabel.isHidden)
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Your password must meet the requirements below")
    }
    

    func testCriteriaMet() throws {
        vc.newPassword = "asdfghjl@A1"
        vc.resetPasswordButtonTapped()
        XCTAssertTrue(vc.newPasswordTextField.errorLabel.isHidden)
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "")
    }
    
    
}



class ViewControllerTests_ConfirmPasswordValidation: XCTestCase {
    
    var vc: ViewController!

    var shortPassword = "12345"
    var validPassword = "Aa@1231456"

    
    override func setUp() {
        super.setUp()
        vc = ViewController()
        vc.newPassword = "ABCDEFGH"
    }
    

    /*
     Here we trigger those criteria blocks by entering text,
     clicking the rest password button, and check if the error label
     show right message
     */
    
    
    func testEmptyPassword() throws {
        vc.confirmPassword = ""
        vc.resetPasswordButtonTapped()
        XCTAssertTrue(!vc.newPasswordTextField.errorLabel.isHidden)
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "enter confirm password")
    }
    
    
    func testPasswordsNotMatch() throws {
        vc.newPassword = validPassword
        vc.confirmPassword = shortPassword
        vc.resetPasswordButtonTapped()
        XCTAssertTrue(!vc.confirmPasswordTextField.errorLabel.isHidden)
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "Passwords do not match")
    }
    
    
    func testPasswordsMatch() throws {
        vc.newPassword = validPassword
        vc.confirmPassword = validPassword
        vc.resetPasswordButtonTapped()
        XCTAssertTrue(vc.confirmPasswordTextField.errorLabel.isHidden)
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "")
    }

    
}
