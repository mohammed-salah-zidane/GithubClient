//
//  HomeVMTests.swift
//  GithubClientTests
//
//  Created by prog_zidane on 5/2/21.
//

import XCTest
import RxSwift
import RxCocoa
@testable import GithubClient

class HomeVMTests: XCTestCase {

    var systemUnderTest: HomeVM!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = HomeVM(dataManager: DataManager.create())
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        systemUnderTest = nil
        disposeBag = nil
    }
    
    func testSetSearchTerm_ViewModelShouldHaveTheRightSearchTerm() {
        systemUnderTest.setSearchTerm(text: "Swift")
        XCTAssertEqual(systemUnderTest.getSearchTerm(), "Swift")
    }
    
    func testSearchForReposWithNameSwift_ShouldHaveSwiftInFullName() {
        let sessionAnsweredExpectation = expectation(description: "Session")
        systemUnderTest.setSearchTerm(text: "Swift")
        systemUnderTest.search()
        systemUnderTest
            .reposFetched
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {
                    XCTFail("Repos not fetched")
                    return
                }
                sessionAnsweredExpectation.fulfill()
                let reposWithSwiftTitle = self?.systemUnderTest.getReposotpries()?.first(where: {$0.fullName.contains("Swift")})
                XCTAssertNotNil(reposWithSwiftTitle)
            }).disposed(by: disposeBag)
        waitForExpectations(timeout: 10, handler: nil)
    }
}
