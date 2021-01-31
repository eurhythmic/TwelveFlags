//
//  ScoreViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 1/10/21.
//

import Combine

class ScoreViewModel: ObservableObject, Identifiable {
    private let scoreRepository = ScoreRepository()
    @Published var score: Score
    private var cancellables: Set<AnyCancellable> = []
    var id = ""
    
    init(score: Score) {
        self.score = score
        
        // Set up binding for score between the score's id and the view model's id.  Store the object in cancellables so it can be cancelled later on.
        $score
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func update(score: Score) {
        scoreRepository.update(score)
    }
    
    func remove() {
        scoreRepository.remove(score)
    }
}
