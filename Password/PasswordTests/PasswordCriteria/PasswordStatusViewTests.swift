//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Mohamed Elatabany on 23/03/2022.
//

import Foundation
import XCTest

@testable import Password
class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {
    
    var passwordStatusView: PasswordStatusView!
    
    var tooShortText = "abc"
    var tooLongText = "123456789123456789123456789123456789"
    var validText = "12345678"
    
    override func setUp() {
        super.setUp()
        passwordStatusView = PasswordStatusView()
        passwordStatusView.shouldResetCriteria = true
    }
    
    func test_TooShortLengthCriteriaView() throws {
        passwordStatusView.updateDiplay(tooShortText)
        XCTAssertFalse(passwordStatusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isResetImage)
    }
    
    
    func test_TooLongLengthCriteriaView() throws {
        passwordStatusView.updateDiplay(tooLongText)
        XCTAssertFalse(passwordStatusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isResetImage)
    }
    
    
    func test_ValidLengthCriteriaView() throws {
        passwordStatusView.updateDiplay(validText)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isCheckMarkImage)
    }

}


class PasswordStatusViewTests_ShowCheckmarkOrCheckMark_When_Validation_Is_LossFocus: XCTestCase {
    
    var passwordStatusView: PasswordStatusView!
    
    var tooShortText = "abc"
    var tooLongText = "123456789123456789123456789123456789"
    var validText = "12345678"
    
    override func setUp() {
        super.setUp()
        passwordStatusView = PasswordStatusView()
        passwordStatusView.shouldResetCriteria = false
    }
    
    func test_TooShortLengthCriteriaView() throws {
        passwordStatusView.updateDiplay(tooShortText)
        XCTAssertFalse(passwordStatusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isXmarkImage)
    }
    
    
    func test_TooLongLengthCriteriaView() throws {
        passwordStatusView.updateDiplay(tooLongText)
        XCTAssertFalse(passwordStatusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isXmarkImage)
    }
    
    
    func test_ValidLengthCriteriaView() throws {
        passwordStatusView.updateDiplay(validText)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(passwordStatusView.lengthCriteriaView.isCheckMarkImage)
    }

}



class PasswordStatusViewTests_ValidateThreeOfFour: XCTestCase {
    
    var passwordStatusView: PasswordStatusView!
    
    var notValidLengthText = "abc"
    var validLenghtHasSpacesText = "abc123 45678"
    var hasSpecialCharcter = "123456789123456789123456789@"
    var hasDigit = "12345678"
    var hasUpperCase = "1234567A"
    var hasLowerCase = "123456a8"
    var validText = "12345678aA@"
    
    
    
    var oneOfFour = "12345678"
    var twoOfFour = "bc1234567a"
    var threeOfFour = "abc12345678@"
    var fourOfFour = "abc12345678@A"

    
    
    
    override func setUp() {
        super.setUp()
        passwordStatusView = PasswordStatusView()
    }
    
    func test_notValidLength() throws {
        XCTAssertFalse(passwordStatusView.validate(notValidLengthText))
    }
    
    
    func test_validLenghtHasSpacesText() throws {
        XCTAssertFalse(passwordStatusView.validate(validLenghtHasSpacesText))
    }
    
    
    func test_hasSpecialCharcter() throws {
        XCTAssertFalse(passwordStatusView.validate(hasSpecialCharcter))
    }
    
    func test_hasDigit() throws {
        XCTAssertFalse(passwordStatusView.validate(hasDigit))
    }
    

    func test_hasUpperCase() throws {
        XCTAssertFalse(passwordStatusView.validate(hasUpperCase))
    }
    
    

    func test_hasLowerCase() throws {
        XCTAssertFalse(passwordStatusView.validate(hasLowerCase))
    }
    
    
    func test_validText() throws {
        XCTAssertTrue(passwordStatusView.validate(validText))
    }
    
    

    func test_oneOfFour() throws {
        XCTAssertFalse(passwordStatusView.validate(oneOfFour))
    }
    
    

    func test_twoOfFour() throws {
        XCTAssertFalse(passwordStatusView.validate(twoOfFour))
    }
    
    
    func test_threeOfFour() throws {
        XCTAssertTrue(passwordStatusView.validate(threeOfFour))
    }
    
    
    func test_fourOfFour() throws {
        XCTAssertTrue(passwordStatusView.validate(fourOfFour))
    }
}
