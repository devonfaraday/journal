//
//  EntryListViewModel.swift
//  Journal
//
//  Created by Christian McMullin on 10/9/21.
//

import Foundation
import SwiftUI

class EntryListViewModel: ObservableObject {
    
    @Published var entries: [Entry] = []
    
    init(journalRef: String) {
        fetchEntries(journalRef: journalRef)
    }
    
    // forcing the unwrapping of documents o.O
    func fetchEntries(journalRef: String) {
        DispatchQueue.main.async {
            let fbc = FirebaseController()
            
            fbc.getDocuments(collection: .entry, whereField: .journalRefKey, isEqualTo: journalRef) { documents, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    do {
                        self.entries = try documents.map({ document in
                            try document.data(as: Entry.self)!
                        })
                        self.entries = self.entries.sorted { lhs, rhs in
                            return lhs.created < rhs.created
                        }
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
        }
    }
}
