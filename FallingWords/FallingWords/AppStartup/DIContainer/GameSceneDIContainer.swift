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
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) { self.dependencies = dependencies }
    
    func makeMainMenuFlowCoordinator(window: UIWindow) -> MainMenuNavigator { MainMenuNavigator(window: window) }
}
