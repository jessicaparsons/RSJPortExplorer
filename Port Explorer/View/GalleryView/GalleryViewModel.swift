//
//  GalleryViewModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/24/25.
//

import Foundation
import SwiftUI

class GalleryViewModel: ObservableObject {
    
    @Published var isGridViewActive: Bool = false
    @Published var gridLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: Constants.photoGridSpacing), count: 2)
    @Published var gridColumn: Int = 3
    @Published var toolbarIcon: String = "square.grid.2x2"
    
    let horizontalSizeClass: UserInterfaceSizeClass?
    
    init(horizontalSizeClass: UserInterfaceSizeClass?) {
        self.horizontalSizeClass = horizontalSizeClass
    }
    
    //Grid Layout Options
    func gridSwitch() {
        withAnimation(.easeIn) {
            
            if horizontalSizeClass == .compact {
                // Cycle between 1, 2, 3 columns for compact size class
                let columnCount = (gridLayout.count % 3) + 1
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.photoGridSpacing), count: columnCount)
                gridColumn = gridLayout.count
            } else {
                // Cycle between 2, 3, 4 columns for regular size class
                let columnCount = gridLayout.count % 3 + 2 // Increment and reset (2 -> 3 -> 4 -> 2)
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.photoGridSpacing), count: columnCount)
                gridColumn = gridLayout.count
            }
        }
        
        
        // TOOLBAR IMAGE
        switch gridColumn {
        case 1:
            toolbarIcon = "square.grid.2x2" // 1 column
        case 2:
            toolbarIcon = "square.grid.3x2" // 2 columns
        case 3:
            toolbarIcon = "rectangle.grid.1x2" // 3 columns
        default:
            toolbarIcon = "square.grid.2x2"
        }
    }
    
    func toggleGridView(isActive: Bool) {
        isGridViewActive = isActive
        if isActive {
            
                gridSwitch()
            
        }
    }
    
    
}
