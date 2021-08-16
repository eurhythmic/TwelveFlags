//
//  TwelveFlagsTests.swift
//  TwelveFlagsTests
//
//  Created by RnD on 3/29/21.
//

import XCTest
@testable import TwelveFlags

class TwelveFlagsTests: XCTestCase {
    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testInitialCountries() {
        // Given
        let model = ContentViewModel(generator: FlagGenerator())
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(model.countries.count, 12, "countries is not 12")
        }
    }
        
    func testUserIDLoaded() throws {
        // Given
        let repository = ScoreRepository()
        
        let exp = expectation(description: "Obtain user id from Firebase")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if !repository.userId.isEmpty {
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: 5)
    }
}

class ScoreTest: XCTestCase {
    // Given
    var sut: Score!
    let expectedHighScore = 11
    let expectedName = "Sir Fictitious"

    // When
    override func setUpWithError() throws {
        super.setUp()
        sut = Score(highScore: expectedHighScore, name: expectedName)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    // Then
    func testInitializesHighScore() {
        XCTAssertEqual(sut.highScore, expectedHighScore)
    }
    
    func testInitializesName() {
        XCTAssertEqual(sut.name, expectedName)
    }
}
