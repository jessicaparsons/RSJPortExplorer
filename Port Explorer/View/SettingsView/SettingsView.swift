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
                    //MARK: - SECTION 1
                    
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
                            Text("Your digital compass for our luxury destinations across the Mediterranean, Caribbean, Africa, Mexico, and Asia. Use our app as an elegant portal to discover, plan, and immerse yourself in our Royal Sea Journey's most breathtaking ports of call.")
                                .font(.footnote)
                        }
                    }
                    
                    //MARK: - BOOK
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Book your Cruise", labelImage: "globe.europe.africa")
                    ) {
                        Divider().padding(.vertical, 4)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ready to embark on an unforgettable journey? Click below to secure your spot today!")
                            
                            Button(action: {
                                linkAlert = true
                            }) {
                                Text("Book Now")
                            }
                            .buttonStyle(CapsuleButtonStyle())
                            .alert(isPresented: $linkAlert) {
                                Alert(
                                    title: Text("External Link"),
                                    message: Text("This action will open your browser to an external site."),
                                    primaryButton: .default(Text("Continue")) {
                                        if let url = URL(string: "https://junipercreative.co/") {
                                            UIApplication.shared.open(url)
                                            linkAlert = false
                                        }
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }//:VSTACK
                        .padding()
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
                .navigationBarTitle(Text("Settings"), displayMode: .automatic)
                .padding()
            }//:SCROLLVIEW
        }//:NAVIGATION
    }
}

#Preview {
    SettingsView()
}

