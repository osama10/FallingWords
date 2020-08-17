//
//  IMWord.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

struct IMWord: Codable, Storable {
    let word: String
    let translation: String
    
    enum CodingKeys: String, CodingKey {
        case word = "text_eng"
        case translation = "text_spa"
    }
}
