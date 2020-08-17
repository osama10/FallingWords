//
//  MockWordRepository.swift
//  FallingWordsTests
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation
@testable import FallingWords

final class MockWordRepository: WordsRepositoryInterface {
    func getWords(words: @escaping ([Word]) -> ()) {
        words(FakeData.wordsSample3)
    }
}
