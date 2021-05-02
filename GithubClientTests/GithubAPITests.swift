//
//  GithubAPITests.swift
//  GithubClientTests
//
//  Created by prog_zidane on 5/2/21.
//

import XCTest
import SwiftyNet
import Data

class GithubAPITests: XCTestCase {

    var systemUnderTest: NetworkRouter!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = NetworkRouter()
    }

    override func tearDown() {
        super.tearDown()
        systemUnderTest = nil
    }
    
    func testSearchRequest_ResponseShouldHaveResultWithTheSentSearchTerm() {
        let sessionAnsweredExpectation = expectation(description: "Session")
        let request = SearchRepositoriesRequest(q: "Swift", page: 1)
        let targetRequest = GithubAPI.search(request: request)
        
        systemUnderTest.request(
            targetRequest: targetRequest,
            responseObject: SearchRepositoriesResponse.self) { result in
            switch result {
            case .success(let data):
                sessionAnsweredExpectation.fulfill()
                let reposWithSwiftTitle = data.items.first(where: {$0.fullName.contains("Swift")})
                XCTAssertNotNil(reposWithSwiftTitle)
                
            case .failure(let error):
                XCTFail(error.errorDescription ?? "Error")
            @unknown default:
                XCTFail("Failed")
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
