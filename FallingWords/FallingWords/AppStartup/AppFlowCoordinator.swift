//
//  AppFlowCoordinator.swift
//  FallingWords
//
//  Created by Osama Bashir on 9/26/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

final class AppFlowCoordinator {
    
    let window: UIWindow
    let appDIContainer: AppDIContainer
    
    init(window: UIWindow, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let gameSceneDIContainer = appDIContainer.makeGameSceneDIContainer()
        let mainMenuFlowCoordinator = gameSceneDIContainer.makeMainMenuFlowCoordinator(window: window)
        mainMenuFlowCoordinator.start()
    }
}
