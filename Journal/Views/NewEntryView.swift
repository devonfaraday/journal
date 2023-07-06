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
                .padding()
                .border(.white, width: 2)
            TextEditor(text: $entryBody)
                .padding()
                .border(.white, width: 2)
        }
        .padding()
        .tag(tag)
        .onDisappear() {
            isNewEntry = false
        }
    }
}

struct NewEntryView_Previews: PreviewProvider {
    
    @State static var entryTitle: String = "Title"
    @State static var entryBody: String = "Body"
    @State static var isNewEntry: Bool = true
    
    static var previews: some View {
        NewEntryView(entryTitle: $entryTitle, entryBody: $entryBody, isNewEntry: $isNewEntry)
    }
}
