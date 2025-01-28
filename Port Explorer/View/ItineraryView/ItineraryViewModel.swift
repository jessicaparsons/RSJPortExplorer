//
//  ItineraryViewModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/24/25.
//

import SwiftUI

class ItineraryViewModel: ObservableObject {
    
    @Published var isGridViewActive: Bool = false
    @Published var gridLayout: [GridItem] = [GridItem(.flexible())]
    @Published var gridColumn: Int = 1
    @Published var toolbarIcon: String = "square.grid.2x2"
    
    let itinerary: Itinerary?
    let horizontalSizeClass: UserInterfaceSizeClass?
    
    init(itinerary: Itinerary?, horizontalSizeClass: UserInterfaceSizeClass?) {
        self.itinerary = itinerary
        self.horizontalSizeClass = horizontalSizeClass
    }
    
    //Grid Layout Options
    func gridSwitch() {
        withAnimation(.easeIn) {
            if horizontalSizeClass == .compact {
                // Cycle between 1 and 2 columns for regular size class
                let columnCount = (gridLayout.count == 1) ? 2 : 1
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.verticalSpacing), count: columnCount)
                gridColumn = gridLayout.count
            } else {
                // Cycle between 2 and 3 columns for regular size class
                let columnCount = (gridLayout.count == 2) ? 3 : 2
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.verticalSpacing), count: columnCount)
                gridColumn = gridLayout.count
            }
        }
        
        // TOOLBAR IMAGE
        switch gridColumn {
        case 1:
            toolbarIcon = "square.grid.2x2"
        case 2:
            toolbarIcon = "rectangle.grid.1x2"
        case 3:
            toolbarIcon = "rectangle.grid.1x2"
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

