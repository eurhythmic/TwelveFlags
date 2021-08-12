//
//  Generator.swift
//  TwelveFlags
//
//  Created by RnD on 8/11/21.
//

import Foundation

protocol Generator {
    var flagNames: [String] { get }
    
    var flagPublisher: Published<[String]>.Publisher { get }
    
    func generate()
}
