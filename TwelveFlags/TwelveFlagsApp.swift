//
//  TwelveFlagsApp.swift
//  TwelveFlags
//
//  Created by RnD on 10/3/20.
//

import SwiftUI

@main
struct TwelveFlagsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(settingsViewModel)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                settingsViewModel.settings.lastActive = Date.now
            case .inactive:
                break
            case .background:
                break
            @unknown default:
                break
            }
        }
    }
}
