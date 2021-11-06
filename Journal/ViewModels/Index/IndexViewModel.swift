//
//  IndexViewModel.swift
//  Journal
//
//  Created by Christian McMullin on 10/9/21.
//

import Foundation
import UIKit

class IndexViewModel: Identifiable, ObservableObject {
    
    @Published var jIndex: JournalIndex
    
    init(journalRef: String) {
        self.jIndex = JournalIndex(journalRef: journalRef)
        self.fetchJournalIndex {
            self.entryIndex = self.jIndex.entryIndex
        }
    }
    
    var id: UUID {
        return jIndex.id
    }
    
    @Published var entryIndex: [EntryIndex] = []
    
//    func setEntryTitles(titles: JournalIndexEntryDictionary) {
//        jIndex.entryTitles = titles
//        setIndex()
//    }
    
    func setTitle(entryRef: String, entryTitle: String) {
        let newEntryIndex = EntryIndex(entryRef: entryRef, title: entryTitle)
        self.entryIndex.append(newEntryIndex)
        jIndex.entryIndex.append(newEntryIndex)
        setIndex()
    }
    
    var journalRef: String {
        return jIndex.journalRef
    }
    
    func fetchJournalIndex(completion: @escaping() -> Void) {
        DispatchQueue.main.async {
        let fbc = FirebaseController()
            fbc.getDocuments(collection: .jIndex, whereField: .journalRefKey, isEqualTo: self.journalRef) { documents, error in
            if let error = error {
                print(error.localizedDescription)
            } else if documents.count > 0 {
                do {
                    self.jIndex = try documents[0].data(as: JournalIndex.self)!
                } catch {
                    print("Counldn't fetch index")
                }
            }
            completion()
        }
        }
    }
    
    func setIndex() {
        let fbc = FirebaseController()
        fbc.setIndexDocument(document: id.uuidString, jIndex: jIndex) {
            
        }
    }
    
    func deleteIndex() {
        let fbc = FirebaseController()
        fbc.deleteDocument(collection: .jIndex, document: id.uuidString)
    }
}
