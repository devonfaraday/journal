//
//  GreenButton.swift
//  Journal
//
//  Created by Christian McMullin on 10/9/21.
//

import Foundation
import SwiftUI

struct GreenButton: ButtonStyle {
    
    var width: CGFloat
    var height: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
        }
}
