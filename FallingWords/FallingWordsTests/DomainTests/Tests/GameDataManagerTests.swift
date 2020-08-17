//
//  GameDataManagerTests.swift
//  FallingWordsTests
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import XCTest
@testable import FallingWords

class GameDataManagerTests: XCTestCase {
    
    let manager = GameDataManager()
    
    func test_whenEmptyArrayPassToPrepareData_ItProduceCorrectResults() {
        manager.prepareGameData(words: [])
        XCTAssertEqual(manager.data.count, 0)
        XCTAssertEqual(manager.dataDict.count, 0)
        XCTAssertEqual(manager.originalWords.count, 0)
        XCTAssertEqual(manager.translations.count, 0)
        
    }
    
    func test_whenArrayWithLessThanFourElementsIsPassToPrepareData_ItProduceCorrectResults() {
        manager.prepareGameData(words: FakeData.wordsSample1)
        XCTAssertEqual(manager.data.count, 3)
        XCTAssertEqual(manager.data[0].options.count, 3)
        XCTAssertEqual(manager.dataDict.count, 3)
        XCTAssertEqual(manager.originalWords.count, 3)
        XCTAssertEqual(manager.translations.count, 3)
        
    }
    
    func test_whenArrayWithFourElementsIsPassToPrepareData_ItProduceCorrectResults() {
        manager.prepareGameData(words: FakeData.wordsSample2)
        XCTAssertEqual(manager.data.count, 4)
        XCTAssertEqual(manager.data[0].options.count, 4)
        XCTAssertEqual(manager.dataDict.count, 4)
        XCTAssertEqual(manager.originalWords.count, 4)
        XCTAssertEqual(manager.translations.count, 4)
        
    }
    
    func test_whenArrayWithMoreThanFourElementsIsPassToPrepareData_ItProduceCorrectResults() {
        
        manager.prepareGameData(words: FakeData.wordsSample3)
        XCTAssertEqual(manager.data.count, 5)
        XCTAssertEqual(manager.data[0].options.count, 4)
        XCTAssertEqual(manager.dataDict.count, 5)
        XCTAssertEqual(manager.originalWords.count, 5)
        XCTAssertEqual(manager.translations.count, 5)
        
    }
    
}
