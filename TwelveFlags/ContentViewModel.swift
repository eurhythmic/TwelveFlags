//
//  ContentViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 11/25/20.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @Published var correctAnswer = Int.random(in: 0...2)
    @Published var showingNotice = false
    @Published var playerScore = 0
    @Published var isAnswerSelected = false
}
