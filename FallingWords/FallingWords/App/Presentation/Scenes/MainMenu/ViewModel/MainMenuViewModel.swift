//
//  MainMenuViewModel.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

protocol MainMenuViewModelProtocol {
    var title: String { get }
    var buttonTitle:String { get }
    var score: Observable<String>{ get set }
    
    func didTapOnPlay()
    func viewDidLoad()
}

final class MainMenuViewModel: MainMenuViewModelProtocol {
    
    private let coordinator: MainMenuNavigatorProtocol
   
    var title: String { "Falling Words" }
    var buttonTitle: String { "Play" }
    var score: Observable<String> = Observable("")
   
    init(coordinator: MainMenuNavigatorProtocol) {
        self.coordinator = coordinator
        NotificationCenter.default.addObserver(self, selector: #selector(showTotalScore(notification:)), name: .totalScore, object: nil)
    }
   
    func viewDidLoad() { score.value = "" }
    
    func didTapOnPlay() { coordinator.toGameScreen() }
    
    @objc private func showTotalScore(notification: Notification) {
        let totalScore = (notification.userInfo?[Constant.totalScore] as? String) ?? "0"
        score.value = "Total Score: \(totalScore)"
    }
    
}
