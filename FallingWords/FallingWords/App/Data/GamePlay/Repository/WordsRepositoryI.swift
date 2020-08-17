//
//  WordsRepositoryI.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

final class WordsRepository: WordsRepositoryInterface {
    func getWords(words: @escaping ([Word]) -> ()) {
        words([Word(word: "Osama", translation: "Lalal"),
        Word(word: "Tooba", translation:"klkjl"),
        Word(word: "hamza", translation: "575665"),
        Word(word: "primary school", translation: "escuela primaria"),
        Word(word: "teacher", translation: "profesor / profesora"),
        Word(word: "pupil", translation: "alumno / alumna"),
        Word(word: "holidays", translation: "vacaciones")
        ])
    }
}
