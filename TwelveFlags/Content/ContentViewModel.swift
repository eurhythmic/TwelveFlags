//
//  ContentViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 11/25/20.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    var countries: [String] = []
    var generator: Generator
    var cancellable: AnyCancellable?
    
    init(generator: Generator = FlagGenerator()) {
        self.generator = generator
        cancellable = generator
            .flagPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.countries = $0
            }
    }
    
    @Published var correctAnswer = Int.random(in: 0...2)
    @Published var showingNotice = false
    @Published var isAnswerSelected = false
    @Published var showSubmitScoreView = false
    @Published var animateShadow = false
    @Published var showSettingsView = false
}
