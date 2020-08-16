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
        let coordinator = MainMenuCoordinator(viewController: mainMenuViewController)
        mainMenuViewController.viewModel = MainMenuViewModel(coordinator: coordinator)
        window.rootViewController = mainMenuViewController
    }
}
