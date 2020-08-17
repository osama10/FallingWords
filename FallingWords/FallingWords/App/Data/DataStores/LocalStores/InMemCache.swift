//
//  InMemCache.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/17/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import Foundation

final class InMemCache: DataStore {
    
    private lazy var cache: [IMWord] = { getWords() }()
    
    func getAll(predicate: NSPredicate?) -> [Storable] {
        return cache
    }
    
    private func getWords() -> [IMWord] {
        do {
            let url = Bundle.main.url(forResource: "words", withExtension: "json")!
             let data = try Data(contentsOf: url)
             let res = try JSONDecoder().decode([IMWord].self, from: data)
             return res

        }
        catch {
            print(error)
            return []
        }
    }
    
    
}
