//
//  SettingsLabelView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/24/25.
//

import SwiftUI

struct SettingsLabelView: View {
    
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

#Preview {
    SettingsLabelView(labelText: "Royal Sea Journeys", labelImage: "info.circle")
}
