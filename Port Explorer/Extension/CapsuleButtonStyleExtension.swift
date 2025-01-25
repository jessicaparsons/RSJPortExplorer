//
//  CapsuleButtonStyleExtension.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/23/25.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    var shadowColor: Color = Color.black.opacity(0.3)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(10)
    }
}
