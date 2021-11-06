//
//  EntryViewModel.swift
//  Journal
//
//  Created by Christian McMullin on 10/9/21.
//

import Foundation
import SwiftUI

class EntryViewModel: ObservableObject  {
    
    @Published var entry: Entry
    
    init(entry: Entry) {
        self.entry = entry
    }
    
    var id: UUID {
        return entry.id
    }
    
    var body: String {
        return entry.body
    }
    
    func setBody(body: String) {
        entry.body = body
    }
    
    var title: String? {
        return entry.title
    }
    
    func setTitle(title: String) {
        entry.title = title
    }
    
    var created: Date {
        return entry.created
    }
    
    var updated: Date {
        return entry.updated
    }
    
    func setUpdated(updated: Date) {
        entry.updated = updated
    }
    
    var journalRef: String {
        return entry.journalRef
    }
    
    
    
    // Create new or update journal
    func setEntry() {
        DispatchQueue.main.async {
            let fbc = FirebaseController()
            fbc.setEntryDocument(document: self.entry.id.uuidString, entry: self.entry) {
                
            }
        }
    }
    
    func deleteEntry() {
        DispatchQueue.main.async {
        let fbc = FirebaseController()
            fbc.deleteDocument(collection: .entry, document: self.id.uuidString)
    }
    }
}

