//
//  GamePlayUseCase.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

protocol GamePlayUseCaseProtocol {
    var updateGameData: ((GameData)->())? { get set }
    var endGame: (()->())? { get set }
    var initialGameData: GameData { get }
    func check(userChoice: UserChoice, result: @escaping (Bool) -> Void)
    func getScore() -> String
}

final class GamePlayUseCase: GamePlayUseCaseProtocol {
    
    let wordsRepository: WordsRepositoryInterface
    var updateGameData: ((GameData) -> ())?
    var endGame: (() -> ())?
    var initialGameData: GameData { gameDataManager.data.first ?? GameData(word: "Something went wrong... Please try again", options: []) }
   
    private var score = 0
    private var counter = 0
    private var inProcessGameDataIndex = 0
    private let gameDataManager: GameDataManager
    
    init(wordsRepository: WordsRepositoryInterface, gameDataManager: GameDataManager = GameDataManager()) {
        self.wordsRepository = wordsRepository
        self.gameDataManager = gameDataManager
        self.wordsRepository.getWords { [weak self] (words) in self?.gameDataManager.prepareGameData(words: words) }
    }
    
    func check(userChoice: UserChoice, result: @escaping (Bool) -> Void) {
        guard !gameDataManager.data.isEmpty else {
            result(false)
            return
        }
        checkUserChoice(userChoice: userChoice, result: result)
    }
    
    
    func getScore() -> String { "\(score)" }
    
    private func checkUserChoice(userChoice: UserChoice, result: @escaping (Bool) -> Void) {
        switch userChoice {
        case .right(let answer):
            handleRightAnswerCase(answer: answer, result: result)
        case .wrong(let answer):
            handleWrongAnswerCase(answer: answer, result: result)
        case .none(let translation):
            handleNoAnswerCase(translation: translation, result: result)
        }
    }
    
    private func updateData() {
       inProcessGameDataIndex += 1
        updateGameData?(gameDataManager.data[inProcessGameDataIndex])
    }
    
    private func handleRightAnswerCase(answer: String, result: @escaping (Bool) -> Void) {
        if (gameDataManager.dataDict[gameDataManager.data[inProcessGameDataIndex].word]! == answer) {
            score += 1
            if inProcessGameDataIndex == (gameDataManager.data.count - 1) { endGame?() }
            else { updateData() }
            result(true)
        }
        else { result(false) }
    }
    
    private func handleWrongAnswerCase(answer: String, result: @escaping (Bool) -> Void) {
        if (gameDataManager.dataDict[gameDataManager.data[inProcessGameDataIndex].word]! != answer) {
            score += 1
            result(true)
        } else {
            if inProcessGameDataIndex == (gameDataManager.data.count - 1) { endGame?() }
            else { updateData() }
            result(false)
        }
    }
    
    private func handleNoAnswerCase(translation: String, result: @escaping (Bool) -> Void) {
        if inProcessGameDataIndex == (gameDataManager.data.count - 1) { endGame?() }
        else { if gameDataManager.data[inProcessGameDataIndex].options.last! == translation { updateData() } }
        result(false)
    }
    
}
