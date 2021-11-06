//
//  JournalApp.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import SwiftUI
import Firebase

@main
struct JournalApp: App {
    
    var isAuthenticated: Bool = false
    
    init() {
        FirebaseApp.configure()
        isAuthenticated = Firebase.Auth.auth().currentUser != nil
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(isAuthenticated: isAuthenticated)
        }
    }
}
