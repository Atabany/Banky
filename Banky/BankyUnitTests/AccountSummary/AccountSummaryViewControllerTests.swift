//
//  AccountSummaryViewControllerTests.swift
//  BankyUnitTests
//
//  Created by Mohamed Elatabany on 20/03/2022.
//

import Foundation
import XCTest

@testable import Banky
class AccountSummaryViewControllerTests: XCTestCase {
    
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!

    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if let error = error {
                completion(.failure(error))
                return
            }
            profile = Profile(id: "1", firstName: "", lastName: "")
            completion(.success(profile!))
        }
    }
    
    
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        mockManager = MockProfileManager()
        vc.profileManger = mockManager
    }
    

    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.title)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.message)
    }
    

    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessage.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.message)
    }

    

    func testAlertForServerError() throws {
        mockManager.error = .serverError
        vc.forceFetchProfile()
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
    
    
    func testAlertForDecodingError() throws {
        mockManager.error = .decodingError
        vc.forceFetchProfile()
        XCTAssertEqual("Network Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
}
