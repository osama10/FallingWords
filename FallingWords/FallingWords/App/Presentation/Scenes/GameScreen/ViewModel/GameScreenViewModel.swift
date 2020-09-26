//
//  GameScreenViewModel.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/16/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

struct GameScreenActions {
    let dismiss: (String) -> ()
}

protocol GameScreenViewModelOutput {
    var answer: Observable<String> { get }
    var word: Observable<String> { get }
    var translation: Observable<String> { get }
    var remainingTime: Observable<String> { get }
    var isButtonInteractionsEnabled: Observable<Bool> { get }
    var positionTranslation: (() -> ())? { get set }
    var wordTitle: String { get }
    var showTranslation: (() -> ())? { get set }
    var hideTranslation: (() -> ())? { get set }
}

protocol GameScreenViewModelInput {
    func viewDidLoad()
    func viewDidAppear()
    func calculateTranslationPosition(translationWidth: Double, totalWidth:Double) -> Double
    func didTranslationOutOfScreen()
    func didTapOnCloseButton()
    func didTapOnRightAnswerButton()
    func didTapOnWrongAnserButton()
}

protocol GameScreenViewModelProtocol: class, GameScreenViewModelInput, GameScreenViewModelOutput { }

final class GameScreenViewModel: GameScreenViewModelProtocol {
    
    var word: Observable<String> = Observable("")
    var translation: Observable<String> = Observable("")
    var remainingTime: Observable<String> = Observable("")
    var answer: Observable<String> = Observable("")
    var isButtonInteractionsEnabled: Observable<Bool> = Observable(false)
    var animateTranslaions: Observable<Bool> = Observable(false)
    var wordTitle: String { "Word" }
    
    var showTranslation: (() -> ())?
    var hideTranslation: (() -> ())?
    var positionTranslation: (() -> ())?
    
    var useCase: GamePlayUseCaseProtocol
    private let actions: GameScreenActions
    
    private var gameData: GameData
    private var counter = 0
    private let nextVal :((Int, Int) -> Int) = { $0 % $1 }
    private var timerVal = 0
    private var timer: Timer!
    
    init(useCase: GamePlayUseCaseProtocol, actions: GameScreenActions) {
        self.useCase = useCase
        self.actions = actions
        self.gameData = useCase.initialGameData
        self.useCase.updateGameData = { [weak self] (gameData) in self?.updateGameData(gameData: gameData) }
        self.useCase.endGame = { [weak self] in self?.actions.dismiss(self?.useCase.getScore() ?? "0") }
    }
    
    func viewDidLoad() {
        answer.value = ""
        word.value = gameData.word
        translation.value = gameData.options.first ?? ""
        positionTranslation?()
        isButtonInteractionsEnabled.value = false
        remainingTime.value = ""
    }
    
    func viewDidAppear() {
        showTranslation?()
        isButtonInteractionsEnabled.value = true
        startTimer()
    }
    
    func calculateTranslationPosition(translationWidth: Double, totalWidth:Double) -> Double {
        let randomVal = Double.random(in: 0...totalWidth)
        let diff = randomVal - translationWidth
        if randomVal >= 0 && randomVal <= (totalWidth - translationWidth) {
            return randomVal
        } else {
            return (diff < 0) ? randomVal + diff : (totalWidth - translationWidth - 20)
        }
    }
    
    func didTranslationOutOfScreen() {
        let option = gameData.options[counter]
        handleUserResponse(userChoice: .none(translation: option))
    }
    
    func didTapOnRightAnswerButton() {
        let userChoice = gameData.options[counter]
        handleUserResponse(userChoice: .right(answer: userChoice))
    }
    
    func didTapOnWrongAnserButton() {
        let userChoice = gameData.options[counter]
        handleUserResponse(userChoice: .wrong(answer: userChoice))
    }
    
    private func handleUserResponse(userChoice: UserChoice) {
        counter = nextVal(counter + 1, gameData.options.count)
        hideTranslation?()
        translation.value = gameData.options[counter]
        positionTranslation?()
        checkUserChoice(userChoice: userChoice)
        showTranslation?()
        isButtonInteractionsEnabled.value = true
        invalidateTimer()
        startTimer()
    }
    
    func didTapOnCloseButton() {
         let totalScore = useCase.getScore()
         actions.dismiss(totalScore)
     }
    
    private func updateGameData(gameData: GameData) {
        self.gameData = gameData
        counter = 0
        word.value = gameData.word
        translation.value = gameData.options[0]
        positionTranslation?()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: handleTimer)
    }
    
    private func handleTimer(timer: Timer) {
        timerVal += 1
        remainingTime.value = "Time left: \(self.timerVal)"
        if timerVal == 11 { invalidateTimer() }
    }
    
    private func invalidateTimer() {
        timer.invalidate()
        timerVal = 0
        remainingTime.value = ""
    }
    
    private func checkUserChoice(userChoice: UserChoice) {
        useCase.check(userChoice: userChoice) { [weak self] (result) in
            switch userChoice {
            case .none:
                self?.answer.value = "No Answer"
            default:
                self?.answer.value = result ? "Right Answer" : "Wrong Answer"
            }
        }
    }
}
