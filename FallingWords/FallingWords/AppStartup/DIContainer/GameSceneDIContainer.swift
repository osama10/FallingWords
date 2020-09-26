//
//  GameSceneDIContainer.swift
//  FallingWords
//
//  Created by Osama Bashir on 9/26/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

final class GameSceneDIContainer {
    
    struct Dependencies {
        let dataStore: DataStore
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) { self.dependencies = dependencies }
    
    func makeMainMenuFlowCoordinator(window: UIWindow) -> MainMenuNavigator { MainMenuNavigator(window: window, dependencies: self) }
}

extension GameSceneDIContainer: MainMenuFlowCoordinatorDependencies {
    
    func makeMainMenuViewController(actions: MainMenuViewModelActions) -> MainMenuViewController {
        let storyboard = UIStoryboard(storyboard: .main)
        let mainMenuViewController: MainMenuViewController = storyboard.initialViewController()
        mainMenuViewController.viewModel = MainMenuViewModel(actions: actions)
        return mainMenuViewController
    }
    
    func makeGameScreenViewController() -> GameScreenViewController {
        let storyboard = UIStoryboard(storyboard: .main)
        let gameScreenVC: GameScreenViewController = storyboard.instantiateViewController()
        let repository = WordsRepository(localDataStore: dependencies.dataStore)
        let useCase = GamePlayUseCase(wordsRepository: repository)
        let navigator = GameScreenNavigator(viewController: gameScreenVC)
        let actions = GameScreenActions(dismiss: navigator.dismiss)
        let viewModel = GameScreenViewModel(useCase: useCase, actions: actions)
        gameScreenVC.viewModel = viewModel
        gameScreenVC.modalPresentationStyle = .fullScreen
        return gameScreenVC
    }
    
}
