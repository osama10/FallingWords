//
//  GameScreenNavigator.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/16/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

protocol GameScreenNavigatorProtocol {
    func dismiss(totalScore: String)
}

final class GameScreenNavigator {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GameScreenNavigator: GameScreenNavigatorProtocol {
    func dismiss(totalScore: String) {
        NotificationCenter.default.post(name: .totalScore, object: nil, userInfo: [Constant.totalScore:totalScore])
        viewController.dismiss(animated: true, completion: nil)
    }
}
