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
    
    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}
