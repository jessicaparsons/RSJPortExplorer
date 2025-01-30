////
////  CruiseViewModelTests.swift
////  PortExplorerTests
////
////  Created by Jessica Parsons on 1/28/25.
////
//
//
//import XCTest
//@testable import Royal_Sea_Journeys
//
//@MainActor
//class CruiseViewModelTests: XCTestCase {
//    var viewModel: CruiseViewModel!
//    var mockAPIService: MockAPIService!
//
//    override func setUp() async throws {
//        try await super.setUp()
//        // Set up your mock service and view model
//        mockAPIService = MockAPIService()
//        viewModel = CruiseViewModel()
//    }
//
//    override func tearDown() async throws {
//        viewModel = nil
//        mockAPIService = nil
//        try await super.tearDown()
//    }
//}
//
//class MockAPIService: APIServiceProtocol {
//    var shouldSucceed: Bool = true
//    var delay: TimeInterval = 0
//
//    func fetchCruiseData(completion: @escaping (Result<Cruise, Error>) -> Void) {
//        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
//            if self.shouldSucceed {
//                let mockCruise = Cruise(cruiseLine: CruiseLine(id: "01", name: "Mock Line", itineraries: []))
//                completion(.success(mockCruise))
//            } else {
//                let error = NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Mock failure"])
//                completion(.failure(error))
//            }
//        }
//    }
//}
