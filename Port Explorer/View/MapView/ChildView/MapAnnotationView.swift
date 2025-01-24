//
//  MapAnnotationView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI

struct MapAnnotationView: View {
    @State private var animation: Double = 0.0
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 48, height: 48, alignment: .center)
            
            Circle()
                .stroke(Color.accentColor, lineWidth: 2)
                .frame(width: 46, height: 46, alignment: .center)
                .scaleEffect(1 + CGFloat(animation))
                .opacity(1 - animation)
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 42, alignment: .center)
                .clipShape(Circle())
        }//:ZSTACK
        .onAppear {
            withAnimation(Animation.easeOut(duration: 2)
                .repeatForever(autoreverses: false)
            ) {
                animation = 1
            }
        }
    }
}

#Preview {
    MapAnnotationView()
}
