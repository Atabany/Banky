//
//  CurrencyFormatterTests.swift
//  BankyUnitTests
//
//  Created by Mohamed Elatabany on 17/03/2022.
//

import Foundation
import XCTest

@testable import Banky
class CurrencyFormatterTests: XCTestCase {

    var formatter: CurrencyFormatter!
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }


    func testBreakIntoDollarsAndCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }


    func testConvertDollar() throws {
        let result = formatter.convertDollar(929466)
        XCTAssertEqual(result, "929,466")
    }


    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }


    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }


    func testDollarsFormattedWithCurrencySymbol() throws {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
    }
    
}
