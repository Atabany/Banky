//
//  AccountTests.swift
//  BankyUnitTests
//
//  Created by Mohamed Elatabany on 19/03/2022.
//
import Foundation
import XCTest

@testable import Banky

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """

        // Game on here 🕹
        
        let data = json.data(using: .utf8)
     
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let result = try! decoder.decode([Account].self, from: data!)
        
        
        XCTAssertEqual(result.count , 2)

        let firstAccount = result.first!
        
        XCTAssertEqual(firstAccount.id, "1")
        XCTAssertEqual(firstAccount.type, .banking)
        XCTAssertEqual(firstAccount.name, "Basic Savings")
        XCTAssertEqual(firstAccount.amount, 929466.23)
        XCTAssertEqual(firstAccount.createdDateTime.monthDayYearString, "Jun 21, 2010")
        
    }
}
