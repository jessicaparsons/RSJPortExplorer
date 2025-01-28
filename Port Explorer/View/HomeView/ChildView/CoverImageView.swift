//
//  CoverImageView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI

struct CoverImageView: View {
    //MARK: - PROPERTIES
    
    @State private var currentPage = 0
    let coverImages = [
        "banner_1",
        "banner_2",
        "banner_3",
        "banner_4"
    ]
    
    //Timer for auto scrolling carousel
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    //MARK: - BODY
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(coverImages.indices, id: \.self) { index in
                    Image(coverImages[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }//:LOOP
            }//:TAB
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onReceive(timer) { _ in
                withAnimation {
                    currentPage = (currentPage + 1) % coverImages.count
                }
                
            }
            
            //SCROLLING DOTS
            HStack(spacing: 8) {
                ForEach(coverImages.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? .white : Color.gray)
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut, value: currentPage)
                }
            }
            .padding(.top, 8)
        }//:VSTACK
    }
}



//MARK: - PREVIEW
#Preview(traits: PreviewTrait.fixedLayout(width: 400, height: 300)) {
    CoverImageView()
}
