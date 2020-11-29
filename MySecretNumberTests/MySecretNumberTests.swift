//
//  MySecretNumberTests.swift
//  MySecretNumberTests
//
//  Created by GUERNEVÉ Sébastien on 28/11/2020.
//

import XCTest
@testable import MySecretNumber

class MySecretNumberTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testCreateSecretNumberWithMyNumber() {
        let game = SecretNumberManager()
        XCTAssertEqual(game.lowBoundary, SecretNumberManager.MIN_BOUNDARY)
        XCTAssertEqual(game.highBoundary, SecretNumberManager.MAX_BOUNDARY)
        XCTAssertNil(game.secretNumber)
        XCTAssertFalse(game.IsInProgress)
        XCTAssertNil(game.lastUserProposal)
        game.starNewGame(withMyNumber: 50)
        XCTAssertEqual(game.secretNumber!, 50)
        XCTAssertNotNil(game.lowBoundary)
        XCTAssertEqual(game.lowBoundary, SecretNumberManager.MIN_BOUNDARY)
        XCTAssertNotNil(game.highBoundary)
        XCTAssertEqual(game.highBoundary, SecretNumberManager.MAX_BOUNDARY)
        XCTAssertNotNil(game.secretNumber!)
        XCTAssertTrue(game.IsInProgress)
        XCTAssertNil(game.lastUserProposal)
        game.testUserProposal(10)
        XCTAssertTrue(game.IsInProgress)
        XCTAssertNotNil(game.lastUserProposal!)
        XCTAssertEqual(game.lowBoundary, game.lastUserProposal!)
        game.testUserProposal(70)
        XCTAssertTrue(game.IsInProgress)
        XCTAssertNotNil(game.lastUserProposal!)
        XCTAssertEqual(game.highBoundary, game.lastUserProposal!)
        game.testUserProposal(50)
        XCTAssertNil(game.secretNumber)
        XCTAssertFalse(game.IsInProgress)
        game.starNewGame(withMyNumber: 50)
        XCTAssertNotNil(game.lowBoundary)
        XCTAssertEqual(game.lowBoundary, SecretNumberManager.MIN_BOUNDARY, "The lowBoundary will be equal to the MIN BOUNDARY at new game")
        XCTAssertNotNil(game.highBoundary)
        XCTAssertEqual(game.highBoundary, SecretNumberManager.MAX_BOUNDARY, "The highBoundary will be equal to the MAX BOUNDARY at new game")
        XCTAssertNotNil(game.secretNumber!)
        XCTAssertTrue(game.IsInProgress)
        XCTAssertNil(game.lastUserProposal)
    }
    
    func testWithRandomSecretNumber() {
        let game = SecretNumberManager()
        game.starNewGame()
        let firstGameSecretNumber = game.secretNumber
        game.starNewGame()
        let secondGameSecretNumber = game.secretNumber
        XCTAssertNotEqual(firstGameSecretNumber!, secondGameSecretNumber!, "the two secret numbers must not be equal. do at least two tests if there is an error that appears.")
    }
    
}
