//
//  UserChoice.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/16/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

enum UserChoice {
    case right(answer: String)
    case wrong(answer: String)
    case none(translation:String)
}
