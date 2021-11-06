//
//  JournalView.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import SwiftUI
import Foundation

struct JournalView: View {
    
    /*
     Journal View will have a layout as follows
     Front cover will the the title of the Journal
     Second page will be the index for the journal in which you can tap on an entry and it will take you to it.
     Third will start the entries.
     A new button will be somewhere that when tapped will navigate the user to the end of the journal and they will have the option of titling their new entry and then proceed to write it out.
     */
    
    var journalRef: String
    @ObservedObject var entriesListVM: EntryListViewModel
    @ObservedObject var indexVM: IndexViewModel
    @State var isNewEntry: Bool = false
    @State var isEditing: Bool = false
    @State var tabSelection = 0 {
        didSet {
            print("tabSelection updated to \(tabSelection)")
        }
    }
    @State private var currentSelection = 0
    @State private var entryTitle: String = ""
    @State private var entryBody: String = ""
    
    init(journalRef: String) {
        self.journalRef = journalRef
        self.entriesListVM = EntryListViewModel(journalRef: journalRef)
        self.indexVM = IndexViewModel(journalRef: journalRef)
    }
    
    var body: some View {
        
        VStack {
            TabView(selection: $tabSelection) {
                // tag 0 is the index of the journal 
                IndexView(indexVM: indexVM, tabSelection: $tabSelection)
                    .tag(0)
                ForEach(0..<entriesListVM.entries.count) { index in
                    // tag 1...x will be all of the journal entries
                    let tag = index + 1
                    EntriesView(isEditing: $isEditing, entryBody: entriesListVM.entries[index].body, entryTitle: entriesListVM.entries[index].title ?? "")
                        .tag(tag)
                }
                    // tab entries.count + 1 will be the last page and will be where you create your new entry
                    NewEntryView(entryTitle: $entryTitle, entryBody: $entryBody, tag: entriesListVM.entries.count + 1)
            }
            .multilineTextAlignment(.center)
            .tabViewStyle(.page)
            HStack {
                Spacer()
                Button(action: {returnToIndex()}) {
                    Image(systemName: "menucard")
                        .resizable()
                        .frame(width: 25, height: 30)
                }
                .buttonStyle(GreenButton(width: 25, height: 30))
                Spacer()
                Button(action: handleNewEntryCancelEntry) {
                    Text(isNewEntry ? "Cancel" : "New Entry")
                }
                .buttonStyle(GreenButton(width: 85, height: 30))
                if tabSelection != 0 {
                    Spacer()
                    Button(action: handleSaveEdit) {
                        Text(isNewEntry || isEditing ? "Save" : "Edit")
                    }
                    .buttonStyle(GreenButton(width: 85, height: 30))
                }
                Spacer()
            }
            .padding()
            .foregroundColor(Color.white)
        }
        
    }
    
    func returnToIndex() {
        tabSelection = 0
        currentSelection = 0
        isNewEntry = false
        isEditing = false
    }
    
    func handleSaveEdit() {
        isEditing || isNewEntry ? saveEntry() : editEntry()
    }
    
    func saveEntry() {
        if isNewEntry {
            handleSaveNewEntry()
        } else if isEditing {
            handleSaveEdit()
        }
        isEditing = false
        isNewEntry = false
    }
    
    func handleSaveNewEntry() {
        let newEntry = Entry(body: entryBody, title: entryTitle, journalRef: journalRef)
        entriesListVM.entries.append(newEntry)
        let evm = EntryViewModel(entry: newEntry)
        evm.setEntry()
        indexVM.setTitle(entryRef: evm.id.uuidString, entryTitle: evm.title ?? "")
    }
    
    func handleSaveEditEntry() {
        let currentEntriesIndex = currentSelection - 1
        let entriesVM = EntryViewModel(entry: entriesListVM.entries[currentEntriesIndex])
        entriesListVM.entries[currentEntriesIndex].title = entryTitle
        entriesListVM.entries[currentEntriesIndex].body = entryBody
        entriesVM.setBody(body: entryBody)
        entriesVM.setTitle(title: entryTitle)
        entriesVM.setEntry()
        indexVM.setTitle(entryRef: entriesVM.id.uuidString, entryTitle: entriesVM.title ?? "")
    }
    
    func editEntry() {
        currentSelection = tabSelection
        isEditing = true
    }
    
    func handleNewEntryCancelEntry() {
        isNewEntry ? handleCancelNewEntry() : toggleIsNewEntry()
        isNewEntry = !isNewEntry
    }
    
    func handleCancelNewEntry() {
        tabSelection = currentSelection
    }
    
    func toggleIsNewEntry() {
        currentSelection = tabSelection
        tabSelection = entriesListVM.entries.count + 1
    }
}


//struct JournalView_Previews: PreviewProvider {
//    
//    static var journal = Journal(name: "Recovory", userRef: "")
//    static var entries = [Entry(body: "This is the body", title: "Title one", journalRef: journal.id.uuidString), Entry(body: "This is the body 2", title: nil, journalRef: journal.id.uuidString), Entry(body: "This is the body 3", title: "Title two", journalRef: journal.id.uuidString)]
//   
//    static var previews: some View {
//       
//        JournalView(journalRef: "")
//    }
//    
//}

