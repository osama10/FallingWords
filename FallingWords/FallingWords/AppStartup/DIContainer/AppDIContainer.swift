//
//  AppDIContainer.swift
//  FallingWords
//
//  Created by Osama Bashir on 9/26/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

final class AppDIContainer {
    // MARK: - DataStores
    lazy var localDataStore: DataStore = { InMemCache() }()
    
    func makeGameSceneDIContainer() -> GameSceneDIContainer {
        let dependencies = GameSceneDIContainer.Dependencies(dataStore: localDataStore)
        return GameSceneDIContainer(dependencies: dependencies)
    }
}
