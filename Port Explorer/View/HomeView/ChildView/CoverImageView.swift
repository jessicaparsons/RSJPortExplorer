//
//  CoverImageView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI

struct CoverImageView: View {
    //MARK: - PROPERTIES
    
    let coverImages: [CoverImage] = [
        CoverImage(id: 0, name: "banner_1"),
        CoverImage(id: 1, name: "banner_2"),
        CoverImage(id: 2, name: "banner_3"),
        CoverImage(id: 3, name: "banner_4")
    ]
    
    //MARK: - BODY
    var body: some View {
        TabView {
            ForEach(coverImages) { item in
                Image(item.name)
                    .resizable()
                    .scaledToFill()
            }//:LOOP
        }//:TAB
        .tabViewStyle(PageTabViewStyle())
    }
}



//MARK: - PREVIEW
#Preview(traits: PreviewTrait.fixedLayout(width: 400, height: 300)) {
    CoverImageView()
}
