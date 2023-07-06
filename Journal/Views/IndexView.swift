//
//  IndexView.swift
//  Journal
//
//  Created by Christian McMullin on 10/11/21.
//

import SwiftUI

struct IndexView: View {
    
    @ObservedObject var indexVM: IndexViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Settings")
                    .padding(.horizontal, 25)
            }
            List(indexVM.entryIndex, id: \.self) { entry in
                HStack {
                    Button(entry.title) {
                        tabSelection = (indexVM.entryIndex.firstIndex(of: entry) ?? 0) + 1
                    }
                    Spacer()
                    Text(entry.created.toString())
                }
                .onTapGesture {
                    MemoryMonitor().reportMemory()
                    tabSelection = (indexVM.entryIndex.firstIndex(of: entry) ?? 0) + 1
                    print("TabSelection in IndexView: \(tabSelection)")
                }
            }
        }
    }
}


struct IndexView_Previews: PreviewProvider {
    
    static var ivm = IndexViewModel(journalRef: "")
    @State static var tab = 0
    
    static var previews: some View {
        IndexView(indexVM: ivm, tabSelection: $tab)
    }
}
