//
//  SettingsView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/24/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    
    @State var linkAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: Constants.verticalSpacing){
                    
                    //MARK: - BOOK
                    
                    GroupBox() {
                        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                            Text("Ready to embark on an unforgettable journey? Click below to secure your spot today!")
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Button(action: {
                                linkAlert = true
                            }) {
                                Text("Book Now")
                            }
                            .buttonStyle(CapsuleButtonStyle())
                            .alert(isPresented: $linkAlert) {
                                openExternalLink("https://junipercreative.co/", alert: $linkAlert)
                            }
                            .accessibilityLabel("Book your cruise")
                            .accessibilityHint("Opens the booking page in an external browser.")
                        }//:VSTACK
                        .padding(.vertical)
                    }//:GROUPBOX
                    
                    
                    
                    //MARK: - CONTACT INFO
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Contact Us", labelImage: "envelope")
                    ) {
                        Divider().padding(.vertical, 4)
                        HStack {
                            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                                Text("Need assistance? Reach out to us:")
                                Text("Phone: +1-800-ROYAL-SEA")
                                Text("Email: support@royalseajourneys.com")
                            }
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        
                    }
                    
                    
                    //MARK: - ABOUT
                    
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Royal Sea Journeys Port Explorer", labelImage: "info.circle")
                    )   {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(Constants.cornerRadius)
                            Text("Use our app as your digital compass to discover, plan, and immerse yourself in Royal Sea Journey's most breathtaking ports of call.")
                                .font(.footnote)
                        }
                    }
                    
                    
                    
                    //MARK: - SECTION 3
                    
                    GroupBox(
                        
                        label:
                            SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                    ) {
                        
                        SettingsRowView(name: "Developer", content: "Jessica Parsons")
                        SettingsRowView(name: "Compatibility", content: "iOS 18.2+")
                        SettingsRowView(name: "Website", linkLabel: "Juniper Creative Co.", linkDestination: "junipercreative.co")
                        SettingsRowView(name: "Portfolio", linkLabel: "GitHub", linkDestination: "github.com/jessicaparsons")
                        SettingsRowView(name: "SwiftUI", content: "Swift 5.0")
                        SettingsRowView(name: "Version", content: "1.1.0")
                    }
                    
                }//:VSTACK
                .navigationBarTitle(Text("Book Your Cruise"), displayMode: .inline)
                .padding()
            }//:SCROLLVIEW
        }//:NAVIGATION
    }
}

#Preview {
    SettingsView()
}

