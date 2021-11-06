//
//  User.swift
//  Journal
//
//  Created by Christian McMullin on 10/5/21.
//

import Foundation

class User: Codable {
    
    var givenName: String
    var familyName: String
    var streetAddress: String = ""
    var zipCode: String = ""
    var city: String = ""
    var phoneNumber: String = ""
    let id = UUID()
    
    init(givenName: String, familyName: String) {
        self.givenName = givenName
        self.familyName = familyName
    }
    
    enum CodingKeys: String, CodingKey {
        case givenName
        case familyName
        case streetAddress
        case zipCode
        case city
        case phoneNumber
        case id
    }
}
