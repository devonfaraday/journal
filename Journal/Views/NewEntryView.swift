//
//  NewEntryView.swift
//  Journal
//
//  Created by Christian McMullin on 10/11/21.
//

import SwiftUI

struct NewEntryView: View {
    
    @Binding var entryTitle: String
    @Binding var entryBody: String
    @Binding var isNewEntry: Bool
    
    var tag: Int = 0 
    
    var body: some View {
        VStack {
            TextField("Enter Title", text: $entryTitle)
            TextEditor(text: $entryBody)
        }
        .tag(tag)
        .onDisappear() {
            isNewEntry = false
        }
    }
    
    
}
