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
                        Rectangle()
                            .frame(width: 150, height: 250)
                            .cornerRadius(4)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                            .overlay() {
                                Button(action: { toggleCreatingNewJournal() } ) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 25))
                                        .frame(width: 150, height: 250)
                                }
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(4)
                            }
                        ForEach(journalListVM.journals) { journal in
                            NavigationLink(destination: JournalView(journalRef: journal.id.uuidString)) {
                                let jvm = JournalViewModel(journal: journal)
                                Rectangle()
                                    .frame(width: 150, height: 250)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(4)
                                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                                    .overlay() {
                                        Text(jvm.name)
                                            .foregroundColor(.black)
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
                    NewJournalView(jlvm: journalListVM, isCreating: $isCreatingNewJournal)
            }
        }
        .background(Color.white)
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
