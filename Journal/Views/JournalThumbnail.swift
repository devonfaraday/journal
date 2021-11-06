//
//  JournalThumbnail.swift
//  Journal
//
//  Created by Christian McMullin on 10/4/21.
//

import SwiftUI

struct JournalThumbnail: View {
    
    @State var journalVM: JournalViewModel
    var color: Color
    var isAddNew: Bool = false
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Color.blue
                .ignoresSafeArea()
                .overlay {
                    VStack {
                        if journalVM.isLocked {
                            Spacer()
                        }
                        Spacer()
                        if isAddNew {
                            Text("+")
                        } else {
                            Text(journalVM.name)
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            if journalVM.isLocked == true {
                                Image(systemName: "lock")
                                    .padding(4)
                            }
                        }
                    }
                }
        } else {
            // Fallback on earlier versions
            Text(journalVM.name)
        }
    }
    
    
    
}

struct JournalThumbnail_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let jVM = JournalViewModel(journal: Journal(name: "name", userRef: ""))
        
        JournalThumbnail(journalVM: jVM, color: Color.blue)
    }
}
