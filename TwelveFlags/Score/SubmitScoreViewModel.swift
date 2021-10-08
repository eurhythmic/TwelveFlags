//
//  SubmitScoreViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 5/7/21.
//

import Foundation
import Combine

class SubmitScoreViewModel: ObservableObject {
    @Published var playerName = ""
    @Published var scoreSent = false
    var textFieldLabel: String {
        scoreSent ? "SUBMITTED" : "ENTER 1UP INITIALS!"
    }
    let characterLimit = 25
    var cancellable: AnyCancellable?
    
    init() {
        trimTextFieldCharacters()
    }
}

private extension SubmitScoreViewModel {
    /// Trims whitespace from the beginning of the text field value
    func trimTextFieldCharacters() {
        cancellable = $playerName
            .sink {
                if $0.first == " " {
                    let newValue = String($0.dropFirst())

                    DispatchQueue.main.async {
                        self.playerName = newValue
                    }
                }
            }
    }
}
