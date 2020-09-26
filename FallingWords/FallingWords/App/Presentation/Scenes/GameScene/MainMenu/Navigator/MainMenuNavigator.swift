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
    
    private weak var window: UIWindow!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(storyboard: .main)
        let mainMenuViewController: MainMenuViewController = storyboard.initialViewController()
        let coordinator = MainMenuNavigator(window: window)
        let actions = MainMenuViewModelActions(showGameScreen: coordinator.toGameScreen)
        mainMenuViewController.viewModel = MainMenuViewModel(actions: actions)
        window.rootViewController = mainMenuViewController
        window?.makeKeyAndVisible()
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
        window.rootViewController?.present(gameScreenVC, animated: true, completion: nil)
    }
}
