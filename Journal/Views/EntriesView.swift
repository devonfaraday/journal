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
    @State var date: String
    
    var body: some View {

        VStack {
            HStack {
                Spacer()
                Text(date)
                    .padding(.horizontal)
            }
            TextField("", text: $entryTitle)
                .multilineTextAlignment(.leading)
                .disabled(!isEditing)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
            ScrollView {
                TextEditor(text: $entryBody)
                    .multilineTextAlignment(.leading)
                    .disabled(!isEditing)
            }
        }
    }
}

struct EntriesView_Previews: PreviewProvider {
    
    @State static var isEditing: Bool = false
    
    static var previews: some View {
        EntriesView(isEditing: $isEditing, entryBody: "Body", entryTitle: "Title", date: "10/01/2022")
    }
}
