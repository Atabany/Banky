//
//  PasswordCriteria.swift
//  PasswordTests
//
//  Created by Mohamed Elatabany on 22/03/2022.
//

import Foundation
import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
    
    // Boundary conditions  8-32
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }
    
    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789101112131415161718192122"))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }
     
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678910111213141516171819211"))
    }
    
    
}
class PasswordOtherCriteriaTests: XCTestCase {




    func testNoSpacesCriteriaMet() throws  {
        XCTAssertTrue(PasswordCriteria.noSpacesCriteriaMet("abc"))
    }
    
    
    func testSpacesCriteria() throws  {
        XCTAssertFalse(PasswordCriteria.noSpacesCriteriaMet("a bc"))
    }


    func testValidLengthAndHaveSpaces() throws  {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpacesMet("ab1234567"))
    }
    
    
    func testNotValidLengthAndHaveNoSpaces() throws  {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpacesMet("ab1234567"))
    }
    
    


    func testUpperCaseMet() throws  {
        XCTAssertTrue(PasswordCriteria.upperCaseMet("abBc"))
    }

    func testHasNoUpperCase() throws  {
        XCTAssertFalse(PasswordCriteria.upperCaseMet("abc"))
    }




    func testLowerCaseMet() throws  {
        XCTAssertTrue(PasswordCriteria.lowerCaseMet("ABCb"))
    }

    
    func testHasNoLowerCase() throws  {
        XCTAssertFalse(PasswordCriteria.lowerCaseMet("ABC"))
    }

    

    func testDigitCaseMet() throws  {
        XCTAssertTrue(PasswordCriteria.digitCaseMet("aBC4"))

    }
    
    
    func testHasNoDigitCase() throws  {
        XCTAssertFalse(PasswordCriteria.digitCaseMet("aBC"))
    }
    

    

    func testSpecialCharacterMet() throws  {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("aBC12Q@"))
    }
    
    
    func testNoSpecialCharacter() throws  {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("aBC12"))
    }

}


