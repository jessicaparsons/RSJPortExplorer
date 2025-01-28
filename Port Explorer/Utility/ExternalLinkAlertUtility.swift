//
//  ExternalLinkAlertUtility.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/28/25.
//

import SwiftUI

func openExternalLink(_ urlString: String, alert: Binding<Bool>) -> Alert {
    return Alert(
        title: Text("External Link"),
        message: Text("This action will open your browser to an external site."),
        primaryButton: .default(Text("Continue")) {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
            alert.wrappedValue = false
        },
        secondaryButton: .cancel()
    )
}
