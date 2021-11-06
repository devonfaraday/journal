//
//  NewButton.swift
//  Journal
//
//  Created by Christian McMullin on 10/5/21.
//

import SwiftUI

struct NewButton: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("New Entry")
        }
        .padding()
        .background(Color.green)
        .cornerRadius(10)
        .foregroundColor(Color.white)
    }
}

struct NewButton_Previews: PreviewProvider {
    static var previews: some View {
        NewButton()
    }
}
