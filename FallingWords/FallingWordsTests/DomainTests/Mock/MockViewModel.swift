//
//  MockViewModel.swift
//  FallingWordsTests
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation
@testable import FallingWords

final class MockViewModel {
    
    var useCase: GamePlayUseCaseProtocol
    var data: GameData
    var endGameCalled = false
    
    init(useCase: GamePlayUseCaseProtocol) {
        self.useCase = useCase
        self.data = useCase.initialGameData
        self.useCase.endGame = { [weak self] in self?.endGameCalled = true }
        self.useCase.updateGameData = { [weak self] (newData) in self?.data = newData }
    }
    
}
