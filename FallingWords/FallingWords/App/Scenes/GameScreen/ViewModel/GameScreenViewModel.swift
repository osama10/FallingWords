//
//  GameScreenViewModel.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/16/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

protocol GameScreenViewModelProtocol {
    var answer: ((String) -> ())? { get set }
    var word: ((String) -> ())? { get set }
    var wordTitle: String { get }
    
    func viewDidLoad()
    func didTapOnCloseButton()
    func didTapOnRightAnswerButton()
    func didTapOnWrongAnserButton()
}

final class GameScreenViewModel: GameScreenViewModelProtocol {
  
    var answer: ((String) -> ())?
    var word: ((String) -> ())?
    var wordTitle: String { "Word" }
    let useCase: GamePlayUseCaseProtocol
    let navigator: GameScreenNavigatorProtocol
    
    private var gameData = GameData(word: "", options: [])
    init(useCase: GamePlayUseCaseProtocol, navigator: GameScreenNavigatorProtocol) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func viewDidLoad() {
        gameData = useCase.getWord()
        answer?("")
        word?(gameData.word)
    }
    
    func didTapOnCloseButton() {
        let totalScore = useCase.getScore()
        navigator.dismiss(totalScore: totalScore)
    }
    
    func didTapOnRightAnswerButton() {
        checkUserChoice()
    }
    
    func didTapOnWrongAnserButton() {
        checkUserChoice()
    }
    
    private func checkUserChoice() {
        useCase.check(userChoice: "") { [weak self] (result) in
            self?.answer?(result ? "Correct" : "InCorrect")
        }
    }
}
