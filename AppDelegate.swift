//
//  AppDelegate.swift
//  TwelveFlags
//
//  Created by RnD on 12/28/20.
//

import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        FirebaseApp.configure()
        AuthenticationService.signIn()
        
        return true
    }
}
