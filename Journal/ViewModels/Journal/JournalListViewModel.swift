//
//  JournalListViewModel.swift
//  Journal
//
//  Created by Christian McMullin on 10/9/21.
//

import Foundation
import SwiftUI

class JournalListViewModel: ObservableObject  {
    
    @Published var journals: [Journal] = []
    
    init() {
        fetchJournals()
    }
    
    // forcing the unwrapping of documents o.O
    func fetchJournals() {
        DispatchQueue.global().async {
            let fbc = FirebaseController()
            if let userId = fbc.userId {
                fbc.getDocuments(collection: .journal, whereField: .userRefKey, isEqualTo: userId) { documents, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        do {
                            self.journals = try documents.map({ document in
                                try document.data(as: Journal.self)!
                            })
                            print(self.journals.count)
                        } catch {
                            print("Something went wrong")
                        }
                    }
                }
            }
        }
    }
    
}
