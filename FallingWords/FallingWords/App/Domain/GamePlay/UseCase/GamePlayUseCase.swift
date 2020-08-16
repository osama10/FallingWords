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
    func check(userChoice: UserChoice, result: @escaping (Bool) -> Void)
    func getScore() -> String
}

final class GamePlayUseCase: GamePlayUseCaseProtocol {
  
   func getWord() -> GameData { GameData(word: "primary school", options: ["asdasd", "asdasd","escuela primaria","adssad"]) }
    
    func check(userChoice: UserChoice, result: @escaping (Bool) -> Void) { result(Bool.random()) }
      
    func getScore() -> String { "20" }
    
}
