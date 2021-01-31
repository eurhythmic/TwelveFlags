//
//  ScoreListViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 12/28/20.
//

import Combine

class ScoreListViewModel: ObservableObject {
    @Published var scoreRepository = ScoreRepository()
    @Published var scoreViewModels: [ScoreViewModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        scoreRepository.$scores.map { scores in
            scores.map(ScoreViewModel.init)
        }
        .assign(to: \.scoreViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func add(_ score: Score) {
        scoreRepository.add(score)
    }
}
