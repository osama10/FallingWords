//
//  GamePlayUseCase.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

protocol GamePlayUseCaseProtocol {
    func getWord() -> GameData
    func check(userChoice: String) -> Bool // TODO : Should be a completion
    func getScore() -> String
}

final class GamePlayUseCase: GamePlayUseCaseProtocol {
   
    func getWord() -> GameData { GameData(word: "primary school", options: ["asdasd", "asdasd","escuela primaria","adssad"]) }
    
    func check(userChoice: String) -> Bool { Bool.random() }
    
    func getScore() -> String { "20" }
    
}
