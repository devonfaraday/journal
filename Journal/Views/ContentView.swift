//
//  ContentView.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var isSigningUp: Bool = false
    var isAuthenticated: Bool
    @State var journals: [Journal] = []
    var jIndex: JournalIndex = JournalIndex(journalRef: "")
    
    init(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
    
    var body: some View {
        NavigationView {
            if isAuthenticated {
                Home()
            } else if isSigningUp {
                Signup()
            } else {
                Login()
            }
        }
    }
    
    func getJournals(completion: @escaping() -> Void) {
        if let userId = Firebase.Auth.auth().currentUser?.uid {
            let fbc = FirebaseController()
            fbc.getDocuments(collection: .journal, whereField: "userRef", isEqualTo: userId) { objects, Error in
                if let journals = objects as? [Journal] {
                    self.journals = journals
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isAuthenticated: true)
    }
}
