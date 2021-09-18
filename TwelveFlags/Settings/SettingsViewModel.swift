//
//  SettingsViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 9/17/21.
//

import Foundation

class SettingsViewModel: ObservableObject {
    var playerNotoriety: String {
            // Return one star if both scores are 0, three stars if either score is 1 or greater
        switch (settings.playerScore, settings.rankedPlayerScore) {
            case (0, 0):
                return "⭐"
            case (1..., _), (_, 1...):
                return "⭐⭐⭐"
            default:
                preconditionFailure("Unexpected score: playerScore \(settings.playerScore), rankedPlayerScore \(settings.rankedPlayerScore)")
            }
        }
    
    @Published var showingAlert = false
    @Published var settings = Settings()
}
