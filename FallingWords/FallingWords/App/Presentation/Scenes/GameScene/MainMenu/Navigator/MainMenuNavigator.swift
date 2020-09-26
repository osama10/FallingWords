//
//  MainMenuCoordinator.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

protocol MainMenuFlowCoordinatorDependencies {
    func makeMainMenuViewController(actions: MainMenuViewModelActions) -> MainMenuViewController
    func makeGameScreenViewController() -> GameScreenViewController
}

final class MainMenuNavigator {
    
    private weak var window: UIWindow!
    private let dependencies: MainMenuFlowCoordinatorDependencies
    
    init(window: UIWindow, dependencies: MainMenuFlowCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MainMenuViewModelActions(showGameScreen: toGameScreen)
        let mainMenuViewController = dependencies.makeMainMenuViewController(actions: actions)
        window.rootViewController = mainMenuViewController
        window?.makeKeyAndVisible()
    }
}

extension MainMenuNavigator {
    func toGameScreen() {
        let gameScreenVC = dependencies.makeGameScreenViewController()
        window.rootViewController?.present(gameScreenVC, animated: true, completion: nil)
    }
}
