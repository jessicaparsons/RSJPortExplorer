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
            .font(.footnote)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .clipShape(Capsule())
            .shadow(color: shadowColor, radius: configuration.isPressed ? 2 : 4, x: 2, y: 2)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .foregroundColor(.white)
            .overlay(
                Capsule()
                    .stroke(Color.accentColor, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
