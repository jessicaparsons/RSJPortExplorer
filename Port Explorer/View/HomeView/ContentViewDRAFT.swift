////
////  ContentView.swift
////  Royal Sea Journeys
////
////  Created by Jessica Parsons on 1/16/25.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var viewModel = CruiseViewModel()
//    private var itineraries: [Itinerary] {
//        !viewModel.itinerary.isEmpty ? viewModel.itinerary : []
//    }
//    
//    //let animals: [Animal] = Bundle.main.decode("animals.json")
//    let haptics = UIImpactFeedbackGenerator(style: .medium)
//    
//    @State private var isGridViewActive: Bool = false
//    //let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
//    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
//    @State private var gridColumns: Int = 1
//    @State private var toolbarIcon: String = "square.grid.2x2"
//    
//    func gridSwitch() {
//        gridLayout = Array(repeating: .init(.flexible()), count: gridColumns % 3 + 1)
//        gridColumns = gridLayout.count
//        
//        //TOOLBAR IMAGE
//        switch gridColumns {
//        case 1:
//            toolbarIcon = "square.grid.2x2"
//        case 2:
//            toolbarIcon = "square.grid.3x2"
//        case 3:
//            toolbarIcon = "rectangle.grid.1x2"
//        default:
//            toolbarIcon = "square.grid.2x2"
//        }
//    }
//    
//    var body: some View {
//        NavigationSplitView {
//            Group {
//                List {
//                    CoverImageView()
//                        .frame(height: 300)
//                        .listRowInsets(EdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0))
//                    
//                    ForEach(itineraries) { itinerary in
//                        NavigationLink(destination: ItineraryView(itineraries: itineraries)) {
//                            ItineraryListItemView(itinerary: itineraries)
//                            }
//                    }//:LOOP
//                }//:LIST
//                .listStyle(.plain)
//            }//:GROUP
//            .navigationBarTitle("Africa", displayMode: .large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    HStack(spacing: 16) {
//                        Button(action: {
//                            isGridViewActive = false
//                            haptics.impactOccurred()
//                        }) {
//                            Image(systemName: "square.fill.text.grid.1x2")
//                                .font(.title2)
//                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
//                                .frame(width: 24, height: 24)
//                        }
//                        Button(action: {
//                            isGridViewActive = true
//                            haptics.impactOccurred()
//                            withAnimation(.easeIn) {
//                                gridSwitch()
//                            }
//                        }) {
//                            Image(systemName: toolbarIcon)
//                                .font(.title2)
//                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
//                                .frame(width: 24, height: 24)
//                        }
//                    }//:HSTACK
//                }//:TOOLBAR ITEM
//            }//:TOOLBAR
//            .task {
//                await viewModel.fetchCruiseData()
//            }
//        } detail: {
//            VStack(spacing: 20) {
//                Image(systemName: "map")
//                    .font(.title)
//                    .foregroundColor(.accentColor)
//                Text("Select an itinerary from the side bar")
//            }
//        }//:NAVIGATION
//        .navigationSplitViewStyle(BalancedNavigationSplitViewStyle())
//    }//:BODY
//}
//
//
//#Preview {
//    ContentView()
//}
