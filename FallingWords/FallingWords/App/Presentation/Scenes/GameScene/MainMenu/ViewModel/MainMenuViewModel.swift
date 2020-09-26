//
//  MainMenuViewModel.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

struct MainMenuViewModelActions {
    let showGameScreen: () -> ()
}

protocol  MainMenuViewModelOutput {
    var title: String { get }
    var buttonTitle:String { get }
    var score: Observable<String>{ get set }
}

protocol  MainMenuViewModelInput {
    func didTapOnPlay()
    func viewDidLoad()
}

protocol MainMenuViewModelProtocol: MainMenuViewModelInput, MainMenuViewModelOutput { }

final class MainMenuViewModel: MainMenuViewModelProtocol {
    
    private let actions: MainMenuViewModelActions
    
    var title: String { "Falling Words" }
    var buttonTitle: String { "Play" }
    var score: Observable<String> = Observable("")
   
    init(actions: MainMenuViewModelActions) {
        self.actions = actions
        NotificationCenter.default.addObserver(self, selector: #selector(showTotalScore(notification:)), name: .totalScore, object: nil)
    }
   
    @objc private func showTotalScore(notification: Notification) {
        let totalScore = (notification.userInfo?[Constant.totalScore] as? String) ?? "0"
        score.value = "Total Score: \(totalScore)"
    }
    
}

extension MainMenuViewModel {
    func viewDidLoad() { score.value = "" }
    func didTapOnPlay() { actions.showGameScreen() }
}
