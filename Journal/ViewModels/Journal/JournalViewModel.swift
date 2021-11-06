//
//  JournalViewModel.swift
//  Journal
//
//  Created by Christian McMullin on 10/9/21.
//

import Foundation

class JournalViewModel: Identifiable {
    
    @Published var journal: Journal
    
    init(journal: Journal) {
        self.journal = journal
    }
    
    var id: UUID {
        return journal.id
    }
    
    var name: String {
        return journal.name
    }
    
    func setName(name: String) {
        journal.name = name
    }
    
    var created: Date {
        return journal.created
    }
    
    var updated: Date {
        return journal.updated
    }
    
    func setUpdated() {
        journal.updated = Date()
    }
    
    var isLocked: Bool {
        return journal.isLocked
    }
    
    func setIsLocked(isLocked: Bool) {
        journal.isLocked = isLocked
    }
    
    var password: String? {
        return journal.password
    }
    
    func setPassword(password: String) {
        journal.password = password
    }
    
    var didPrint: Bool {
        return journal.didPrint
    }
    
    func setDidPrint(didPrint: Bool) {
        journal.didPrint = didPrint
    }
    
    var userRef: String {
        return journal.userRef
    }
    
    // Create new or update journal
    func setJournal() {
        DispatchQueue.main.async {
            let fbc = FirebaseController()
            if fbc.userId != nil {
                fbc.setJournalDocument(document: self.id.uuidString, journal: self.journal) {
                    
                }
            }
        }
    }
    
    func deleteJournal() {
        DispatchQueue.main.async {
            let fbc = FirebaseController()
            fbc.deleteDocument(collection: .journal, document: self.id.uuidString)
        }
    }
    
}

