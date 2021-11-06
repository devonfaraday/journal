//
//  Entry.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import Foundation

class Entry: Identifiable, Equatable, Codable {
    var id = UUID()
    var body: String
    var title: String?
    var created: Date = Date()
    var updated: Date = Date()
    let journalRef: String
    var dateString: String {
        return created.toString()
    }
    
    init(body: String, title: String?, journalRef: String) {
        self.body = body
        self.title = title
        self.journalRef = journalRef
    }
    
    func getCreatedDate() -> String {
        return created.toString()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case body
        case title
        case created
        case updated
        case journalRef
    }
}

func ==(lhs: Entry, rhs: Entry) -> Bool {
    return lhs.id == rhs.id
}
