//
//  Journal.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import Foundation
import Firebase

class Journal: Identifiable, Codable {

    var id = UUID()
    var name: String
    let created: Date = Date()
    var updated: Date = Date()
    var isLocked: Bool = false
    var password: String? = nil
    var didPrint: Bool = false
    var userRef: String
    
    var firebaseData: [String:Any] {
        return [
            "name": name,
            "created": Timestamp(date: created),
            "updated": Timestamp(date: updated),
            "isLocked": isLocked,
            "password": password ?? "",
            "didPrint": didPrint,
            "userRef": userRef
        ]
    }
    
    init(name: String, userRef: String) {
        self.name = name
        self.userRef = userRef
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case created
        case updated
        case isLocked
        case password
        case didPrint
        case userRef
    }
}
