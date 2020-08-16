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
    var score: ((String) -> ())?{ get set }
    
    func didTapOnPlay()
    func viewDidLoad()
}

final class MainMenuViewModel: MainMenuViewModelProtocol {
    
    private let coordinator: MainMenuCoordinatorProtocol
   
    var title: String { "Falling Words" }
    var buttonTitle: String { "Play" }
    var score: ((String) -> ())?

    init(coordinator: MainMenuCoordinatorProtocol) {
        self.coordinator = coordinator
        NotificationCenter.default.addObserver(self, selector: #selector(showTotalScore(notification:)), name: .totalScore, object: nil)
    }
   
    func viewDidLoad() { score?("") }
    
    func didTapOnPlay() { coordinator.toGameScreen() }
    
    @objc private func showTotalScore(notification: Notification) {
        let totalScore = (notification.userInfo?["score"] as? String) ?? "0"
        score?("Total Score: \(totalScore)")
    }
    
}
