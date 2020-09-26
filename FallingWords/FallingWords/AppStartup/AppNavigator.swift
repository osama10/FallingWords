//
//  AppStartup.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

struct AppNavigator {
    func installRoot(into window: UIWindow) {
        let storyboard = UIStoryboard(storyboard: .main)
        let mainMenuViewController: MainMenuViewController = storyboard.initialViewController()
        let coordinator = MainMenuNavigator(viewController: mainMenuViewController)
        let actions = MainMenuViewModelActions(showGameScreen: coordinator.toGameScreen)
        mainMenuViewController.viewModel = MainMenuViewModel(actions: actions)
        window.rootViewController = mainMenuViewController
    }
}
