//
//  AuthenticationService.swift
//  TwelveFlags
//
//  Created by RnD on 1/16/21.
//

import Foundation
import Firebase

class AuthenticationService: ObservableObject {
    // Defines `user` which contains the `User` object when the auth process happens
    @Published var user: User?
    // Defines `authenticationStateHandler` to catch changes in the user object, such as when the user signs in/out
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        // `addListeners()` called when the class is instantiated
        addListeners()
    }
    
    /// Sign in to Firebase
    static func signIn() {
        // Check if there is a current user to avoid unnecessary calls
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }
    }
    
    private func addListeners() {
        // Check if there is a handler instantiated and if so, remove it
        if let handle = authenticationStateHandler {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        
        // Assign listener to `authenticationStateHandler`
        authenticationStateHandler = Auth.auth().addStateDidChangeListener { _, user in
                self.user = user
        }
    }
}
