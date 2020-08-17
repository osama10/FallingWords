//
//  GamePlayUseCaseTests.swift
//  FallingWordsTests
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import XCTest
@testable import FallingWords

class GamePlayUseCaseTests: XCTestCase {
    
    let useCase = GamePlayUseCase(wordsRepository: MockWordRepository())
    let testingDesc = "GamePlayUseCaseTests"
    
    func test_getScore() {
        XCTAssertEqual(useCase.getScore(), "0")
    }
    
    func test_whenUserTapRightAndAnswerIsCorrect_checkProduceCorrectResults() {
        let expectation = self.expectation(description: testingDesc)
        useCase.check(userChoice: .right(answer: "One")) { (result) in
            XCTAssertTrue(result)
            XCTAssertEqual(self.useCase.getScore(), "1")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserTapRightAndAnswerIsNotCorrect_checkProduceCorrectResults() {
        let expectation = self.expectation(description: testingDesc)
        useCase.check(userChoice: .right(answer: "Two")) { (result) in
            XCTAssertFalse(result)
            XCTAssertEqual(self.useCase.getScore(), "0")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserTapRightAndAnswerIsCorrect_updateGameDataIsCalled() {
        let expectation = self.expectation(description: testingDesc)
        let viewModel = MockViewModel(useCase: useCase)
        let oldData = viewModel.data
        useCase.check(userChoice: .right(answer: "One")) { (result) in
            XCTAssertEqual(viewModel.data.word, "2")
            XCTAssertNotEqual(viewModel.data.word, oldData.word)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserTapWrongAndIsCorrect_checkProduceCorrectResults() {
        let expectation = self.expectation(description: testingDesc)
        useCase.check(userChoice: .wrong(answer: "Two")) { (result) in
            XCTAssertTrue(result)
            XCTAssertEqual(self.useCase.getScore(), "1")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    
    func test_whenUserTapWrongandIsNotCorrect_thenUpdateGameDataUpdatesNewData() {
        let expectation = self.expectation(description: testingDesc)
        useCase.check(userChoice: .wrong(answer: "One")) { (result) in
            XCTAssertFalse(result)
            XCTAssertEqual(self.useCase.getScore(), "0")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserTapWrongAndAnswerIsCorrect_updateGameDataIsCalled() {
        let expectation = self.expectation(description: testingDesc)
        let viewModel = MockViewModel(useCase: useCase)
        let oldData = viewModel.data
        useCase.check(userChoice: .wrong(answer: "One")) { (result) in
            XCTAssertEqual(viewModel.data.word, "2")
            XCTAssertNotEqual(viewModel.data.word, oldData.word)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserDoesntAnswer_ScoreStaysSame() {
        let expectation = self.expectation(description: testingDesc)
        useCase.check(userChoice: .none(translation: "One")) { (result) in
            XCTAssertFalse(result)
            XCTAssertEqual(self.useCase.getScore(), "0")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserDoesntAnswerForAllOptions_thenUpdateGameDataIsCalled() {
        let expectation = self.expectation(description: testingDesc)
        let viewModel = MockViewModel(useCase: useCase)
        let oldData = viewModel.data
        useCase.check(userChoice: .none(translation: viewModel.data.options.last!)) { (result) in
            XCTAssertEqual(viewModel.data.word, "2")
            XCTAssertNotEqual(viewModel.data.word, oldData.word)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_whenUserAnswersAllTheTranslations_thenEndGameIsCalled() {
        let answers = ["One", "Two", "Three", "Four", "Five"]
        let viewModel = MockViewModel(useCase: useCase)
        for ans in answers {
            useCase.check(userChoice: .right(answer: ans)) { (result) in }
        }
        
        XCTAssertTrue(viewModel.endGameCalled)
    }
}
