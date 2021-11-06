//
//  Home.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var journalListVM: JournalListViewModel
    @State var isCreatingNewJournal: Bool = false
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        self.journalListVM = JournalListViewModel()
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 20) {
                        
                        Button(action: { toggleCreatingNewJournal() } ) {
                            Text("+")
                                .font(.system(size: 25))
                                .frame(width: 150, height: 250)
                        }
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                        ForEach(journalListVM.journals) { journal in
                            NavigationLink(destination: JournalView(journalRef: journal.id.uuidString)) {
                                let jvm = JournalViewModel(journal: journal)
                                VStack {
                                    Text(jvm.name)
                                        .font(.system(size: 25))
                                        .frame(width: 150, height: 250)
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        if jvm.isLocked == true {
                                            Image(systemName: "lock")
                                                .padding(4)
                                        }
                                    }
                                }
                                .frame(width: 150, height: 250)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                            }
                        }
                        
                        
                    }
                    .navigationTitle("Journals")
                    .navigationBarBackButtonHidden(true)
                    
                }
                Button(action: logout) {
                    Text("Log out (debug only)")
                }
            }
            .blur(radius: isCreatingNewJournal ? 10 : 0)
            if isCreatingNewJournal {
                VStack {
                    Text(isCreatingNewJournal ? "True" : "False")
                    CreateNewJournalView(jlvm: journalListVM, isCreating: $isCreatingNewJournal)
                }
            }
        }
    }
    
    func toggleCreatingNewJournal() {
        isCreatingNewJournal = !isCreatingNewJournal
    }
    
    func logout() {
        do {
            try Firebase.Auth.auth().signOut()
            self.presentation.wrappedValue.dismiss()
        } catch {
            print("oops")
        }
    }
}

struct CreateNewJournalView: View {
    
    @State var journalName: String = ""
    @ObservedObject var jlvm: JournalListViewModel
    @Binding var isCreating: Bool
    
    var body: some View {
        VStack {
            TextField("Journal Title", text: $journalName)
                .padding()
                .border(Color.black, width: 1)
            Button(action: saveJournal ) {
                Text(isCreating ? "Save" : "blah")
            }
            .buttonStyle(GreenButton(width: 50, height: 30))
        }
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
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
