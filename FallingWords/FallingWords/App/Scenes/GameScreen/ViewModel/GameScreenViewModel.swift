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
    var translation: ((String) -> ())? { get set }
    var updateTimer: ((String) -> ())? { get set }
    var wordTitle: String { get }
    var showTranslation: (() -> ())? { get set }
    var hideTranslation: (() -> ())? { get set }
    var setTranslationPosition: (() -> ())? { get set }
    var disableButtonInteractions : (() -> ())? { get set }
    
    func viewDidLoad()
    func viewDidAppear()
    func calculateTranslationPosition(translationWidth: Double, totalWidth:Double) -> Double
    func didTranslationOutOfScreen()
    func didTapOnCloseButton()
    func didTapOnRightAnswerButton()
    func didTapOnWrongAnserButton()
}

final class GameScreenViewModel: GameScreenViewModelProtocol {
    
    var answer: ((String) -> ())?
    var word: ((String) -> ())?
    var translation: ((String) -> ())?
    var updateTimer: ((String) -> ())?
    var wordTitle: String { "Word" }
    var showTranslation: (() -> ())?
    var hideTranslation: (() -> ())?
    var setTranslationPosition: (() -> ())?
    var disableButtonInteractions: (() -> ())?
    
    var useCase: GamePlayUseCaseProtocol
    let navigator: GameScreenNavigatorProtocol
    private var gameData: GameData
    private var counter = 0
    private let nextVal :((Int, Int) -> Int) = { $0 % $1 }
    private var timerVal = 0
    private var timer: Timer!
    
    init(useCase: GamePlayUseCaseProtocol, navigator: GameScreenNavigatorProtocol) {
        self.useCase = useCase
        self.navigator = navigator
        self.gameData = useCase.initialGameData
        self.useCase.updateGameData = { [weak self] (gameData) in self?.updateGameData(gameData: gameData) }
        self.useCase.endGame = {[weak self] in self?.navigator.dismiss(totalScore: self?.useCase.getScore() ?? "0")}
    }
    
    func viewDidLoad() {
        answer?("")
        word?(gameData.word)
        translation?(gameData.options.first ?? "")
        setTranslationPosition?()
        disableButtonInteractions?()
        updateTimer?("")
    }
    
    func viewDidAppear() {
        showTranslation?()
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
        counter = nextVal(counter + 1, gameData.options.count)
        hideTranslation?()
        translation?(gameData.options[counter])
        setTranslationPosition?()
        checkUserChoice(userChoice: .none(translation: option))
        showTranslation?()
        invalidateTimer()
        startTimer()
    }
    
    func didTapOnRightAnswerButton() {
        let userChoice = gameData.options[counter]
        counter = nextVal(counter + 1, gameData.options.count)
        hideTranslation?()
        translation?(gameData.options[counter])
        setTranslationPosition?()
        checkUserChoice(userChoice: .right(answer: userChoice))
        showTranslation?()
        invalidateTimer()
        startTimer()

    }
    
    func didTapOnWrongAnserButton() {
        let userChoice = gameData.options[counter]
        counter = nextVal(counter + 1, gameData.options.count)
        hideTranslation?()
        translation?(gameData.options[counter])
        setTranslationPosition?()
        checkUserChoice(userChoice: .wrong(answer: userChoice))
        showTranslation?()
        invalidateTimer()
        startTimer()
    }
    
    func didTapOnCloseButton() {
         let totalScore = useCase.getScore()
         navigator.dismiss(totalScore: totalScore)
     }
    
    private func updateGameData(gameData: GameData) {
        self.gameData = gameData
        counter = 0
        word?(gameData.word)
        translation?(gameData.options[0])
        setTranslationPosition?()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: handleTimer)
    }
    
    private func handleTimer(timer: Timer) {
        timerVal += 1
        updateTimer?("Time left: \(self.timerVal)")
        if timerVal == 11 { invalidateTimer() }
    }
    
    private func invalidateTimer() {
        timer.invalidate()
        timerVal = 0
        updateTimer?("")
    }
    
    private func checkUserChoice(userChoice: UserChoice) {
        useCase.check(userChoice: userChoice) { [weak self] (result) in
            switch userChoice {
            case .none:
                self?.answer?("No Answer")
            default:
                self?.answer?(result ? "Right Answer" : "Wrong Answer")
            }
        }
    }
}
