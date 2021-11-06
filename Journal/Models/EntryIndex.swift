//
//  EntryIndex.swift
//  Journal
//
//  Created by Christian McMullin on 10/16/21.
//

import Foundation

struct EntryIndex: Codable, Hashable {
    
    let entryRef: String
    var title: String
    var created: Date = Date()
    var updated: Date = Date()
    
    enum CodingKeys: String, CodingKey {
        case entryRef
        case title
        case created
        case updated
    }
}
