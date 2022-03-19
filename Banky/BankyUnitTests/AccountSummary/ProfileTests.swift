//
//  ProfileTests.swift
//  BankyUnitTests
//
//  Created by Mohamed Elatabany on 19/03/2022.
//


import XCTest
@testable import Banky

class ProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func test_CanParse() throws {
        
        let json = """
        {
            "id": "1",
            "first_name": "Mohamed",
            "last_name": "Elatabany",
        }
        """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Mohamed")
        XCTAssertEqual(result.lastName, "Elatabany")
    }
    
    
    
}
