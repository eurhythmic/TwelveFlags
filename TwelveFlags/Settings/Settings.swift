//
//  Settings.swift
//  TwelveFlags
//
//  Created by RnD on 9/17/21.
//

import Foundation

struct Settings {
    private enum Key {
        static let playerName = "playerName"
        static let playerScore = "playerScore"
        static let rankedPlayerScore = "rankedPlayerScore"
        static let returningPlayer = "returningPlayer"
        static let lastActive = "lastActive"
    }

    @SettingsStorage(Settings.Key.playerName) var playerName = "1Up"
    @SettingsStorage(Settings.Key.playerScore) var playerScore = 0
    @SettingsStorage(Settings.Key.rankedPlayerScore) var rankedPlayerScore = 0
    @SettingsStorage(Settings.Key.returningPlayer) var returningPlayer = false
    @SettingsStorage(Settings.Key.lastActive) var lastActive = Date.now
}
