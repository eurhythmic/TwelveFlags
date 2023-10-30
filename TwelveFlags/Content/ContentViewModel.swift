//
//  ContentViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 11/25/20.
//

import Foundation
import Combine

@Observable class ContentViewModel {
    private var flagArray: [String] = []
    private var generator: Generator
    private var cancellable: AnyCancellable?
    
    init(generator: Generator = FlagGenerator()) {
        self.generator = generator
        cancellable = generator
            .flagPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.flagArray = $0
            }
    }
    
    var correctAnswer = Int.random(in: 0...2)
    var showingNotice = false
    var isAnswerSelected = false
    var showSubmitScoreView = false
    var animateShadow = false
    var showSettingsView = false
    
    func allFlags() -> [String] {
        return flagArray
    }
    
    func randomizeFlags() {
        flagArray.shuffle()
    }
}
