//
//  MainMenuCoordinator.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

protocol MainMenuNavigatorProtocol {
    func toGameScreen()
}

final class MainMenuNavigator {
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MainMenuNavigator: MainMenuNavigatorProtocol {
    func toGameScreen() {
        let storyboard = UIStoryboard(storyboard: .main)
        let gameScreenVC: GameScreenViewController = storyboard.instantiateViewController()
        let repository = WordsRepository(localDataStore: InMemCache())
        let useCase = GamePlayUseCase(wordsRepository: repository)
        let navigator = GameScreenNavigator(viewController: gameScreenVC)
        let actions = GameScreenActions(dismiss: navigator.dismiss)
        let viewModel = GameScreenViewModel(useCase: useCase, actions: actions)
        gameScreenVC.viewModel = viewModel
        gameScreenVC.modalPresentationStyle = .fullScreen
        viewController.present(gameScreenVC, animated: true, completion: nil)
    }
}
