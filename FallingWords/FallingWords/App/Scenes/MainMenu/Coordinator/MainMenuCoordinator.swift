//
//  MainMenuCoordinator.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

protocol MainMenuCoordinatorProtocol {
    func toGameScreen()
}

final class MainMenuCoordinator {
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension MainMenuCoordinator: MainMenuCoordinatorProtocol {
    func toGameScreen() {
        print("I am called")
    }
}
