//
//  WordsRepository.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

final class WordsRepository: WordsRepositoryInterface {
    
    let localDataStore: DataStore
    
    init(localDataStore: DataStore) {
        self.localDataStore = localDataStore
    }
    
    func getWords(words: @escaping ([Word]) -> ()) {
        let data = localDataStore.getAll(predicate: nil)
        words(toWord(from: data))
    }
    
    private func toWord(from storable: [Storable]) -> [Word] {
        guard let data = storable as? [IMWord] else { return [] }
        return data.compactMap { Word(word: $0.word, translation: $0.translation) }
    }
}
