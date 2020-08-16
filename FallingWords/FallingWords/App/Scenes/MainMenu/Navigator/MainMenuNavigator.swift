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
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension MainMenuNavigator: MainMenuNavigatorProtocol {
    func toGameScreen() {
        print("I am called")
    }
}
