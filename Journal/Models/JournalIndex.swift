//
//  Index.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import Foundation

// Key = Entry ID value = Entry title
typealias JournalIndexEntryDictionary = [String: String]

struct JournalIndex: Identifiable, Codable {
    var id = UUID()
    var entryIndex:  [EntryIndex] = []
    let journalRef: String
    var created: Date = Date()
    var updated: Date = Date()
    
    enum CodingKeys: String, CodingKey {
        case id
        case entryIndex
        case journalRef
        case created
        case updated
    }
}
