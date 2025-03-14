//
//  CreditsView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/20/25.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            Text("""
    Copyright © Royal Sea Journeys Port Explorer
    All rights reserved
    Juniper Creative Co.
    """)
            .font(.footnote)
            .multilineTextAlignment(.center)
        }//:VSTACK
        .padding()
        .opacity(0.4)
    }
}

#Preview {
    CreditsView()
}
