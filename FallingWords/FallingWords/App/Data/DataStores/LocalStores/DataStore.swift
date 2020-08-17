//
//  DataStore.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

protocol Storable { }

protocol Readable { func getAll(predicate: NSPredicate?) -> [Storable] }

protocol DataStore: Readable {
    
}
