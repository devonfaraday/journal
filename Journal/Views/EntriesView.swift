//
//  EntriesView.swift
//  Journal
//
//  Created by Christian McMullin on 10/11/21.
//

import SwiftUI

struct EntriesView: View {
    
    @Binding var isEditing: Bool
    @State var entryBody: String
    @State var entryTitle: String
    
    var body: some View {

        VStack {
            TextField("", text: $entryTitle)
                .disabled(!isEditing)
            TextEditor(text: $entryBody)
                .disabled(!isEditing)
        }
    }
}
