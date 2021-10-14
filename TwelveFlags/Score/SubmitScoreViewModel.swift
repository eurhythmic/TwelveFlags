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
    private var cancellable: AnyCancellable?
    
    init() {
        trimTextFieldCharacters()
    }
    
    /// Limit text field characters
    /// - Parameters:
    ///   - value: The text field value
    ///   - upperLimit: The maximum number of characters to allow
    func limitTextFieldCharacters(for value: String, with upperLimit: Int) -> String {
        if value.count > upperLimit {
            return String(value.prefix(upperLimit))
        }
        
        return value
    }
    
    /// Trims whitespace from the beginning of the player name text field value
    private func trimTextFieldCharacters() {
        cancellable = $playerName
            .sink { [weak self] in
                if $0.first == " " {
                    let newValue = String($0.dropFirst())

                    DispatchQueue.main.async {
                        self?.playerName = newValue
                    }
                }
            }
    }
}
