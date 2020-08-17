//
//  GameDataManager.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

final class GameDataManager {
    
    var originalWords = [String]()
    var translations = [String]()
    var dataDict = [String: String]()
    var data = [GameData]()
    
    func prepareGameData(words: [Word]) {
        words.forEach { word in dataDict[word.word] = word.translation }
        originalWords = words.compactMap{ $0.word }
        translations = words.compactMap{ $0.translation }
        data = generateGameData(originalWords: originalWords, translations: translations)
    }
    
    private func generateGameData(originalWords: [String], translations: [String]) -> [GameData] {
        var result = [GameData]()
        let totalWords = originalWords.count
        let maxNum = min(3, totalWords)
        
        originalWords.forEach { word in
            var option = Set<String>()
            option.insert(dataDict[word]!)
            var counter = 0
            while counter != maxNum {
                let translation = translations.randomElement() ?? ""
                if translation != dataDict[word]! && !option.contains(translation) {
                    option.insert(translation)
                    counter += 1
                }
            }
            var finalData = Array(option)
            finalData.shuffle()
            result.append(GameData(word: word, options: finalData))
        }
        
        return result
    }
}
