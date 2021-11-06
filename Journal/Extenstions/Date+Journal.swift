//
//  Date+Journal.swift
//  Journal
//
//  Created by Christian McMullin on 10/6/21.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
