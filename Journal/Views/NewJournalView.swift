//
//  NewJournalView.swift
//  Journal
//
//  Created by Christian McMullin on 8/26/22.
//

import SwiftUI
import Firebase

struct NewJournalView: View {
    
    @State var journalName: String = ""
    @ObservedObject var jlvm: JournalListViewModel
    @Binding var isCreating: Bool
    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity - 20, maxHeight: 400)
            .cornerRadius(8)
            .shadow(color: .black, radius: 5, x: 0, y: 0)
            .overlay() {
                VStack {
                    Text("New Journal")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                    Text("Enter journal title below")
                        .foregroundColor(.black)
                        .font(.system(size: 11))
                    HStack {
                        Spacer()
                                TextField("Journal Title", text: $journalName)
                                    .padding()
                                    .border(Color.black, width: 2)
                                Spacer()
                            }
                            .padding()
                    HStack {
                        Button(action: saveJournal ) {
                            Text("Save")
                        }
                        .buttonStyle(GreenButton(width: 80, height: 30))
                        
                        Button(action: cancel) {
                            Text("Cancel")
                        }
                        .buttonStyle(GreenButton(width: 80, height: 30))
                    }
                }
            }
            .padding(45)
    }
    
    func saveJournal() {
        if let userId = Firebase.Auth.auth().currentUser?.uid {
            let journal = Journal(name: journalName, userRef: userId)
            let jvm = JournalViewModel(journal: journal)
            jlvm.journals.append(journal)
            jvm.setJournal()
            saveJournalIndex(journalRef: jvm.id.uuidString)
        }
        isCreating = false
    }
    
    func saveJournalIndex(journalRef: String) {
        let jivm = IndexViewModel(journalRef: journalRef)
        jivm.setIndex()
    }
    
    func cancel() {
        isCreating = false
    }
}

struct NewJournalView_Previews: PreviewProvider {
    
    @State static var isCreating: Bool = true
    static var jlvm = JournalListViewModel()
    
    static var previews: some View {
        NewJournalView(jlvm: jlvm, isCreating: $isCreating)
    }
}
