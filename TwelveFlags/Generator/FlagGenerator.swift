//
//  FlagGenerator.swift
//  TwelveFlags
//
//  Created by RnD on 8/11/21.
//

import Foundation

class FlagGenerator: Generator, ObservableObject {
    @Published private(set) var flagNames: [String] = []
    
    var flagPublisher: Published<[String]>.Publisher { $flagNames }
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    init() {
        generate()
    }
    
    func generate() {
        self.flagNames = countries.shuffled()
    }
    
    
}
