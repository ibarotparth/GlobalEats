//
//  GlobalEatsViewModelTests.swift
//  GlobalEatsTests
//
//  Created by csuftitan on 1/27/24.
//

import Foundation
@testable import GlobalEats
import XCTest

class GlobalEatsViewModelTests: XCTestCase {
    
    
    func testEmptyAPIResponse() {
        // Create a mock APIManager that returns an empty MealDetail
        let mockAPIManager = MockAPIManagerMealDetail()
        mockAPIManager.mockMealDetail = MealDetail(meals: [])

        let viewModel = MealDetailViewModel(apiManager: mockAPIManager)

        // Create an expectation for the event handler
        let expectation = self.expectation(description: "Empty response event should be called")

        Task {
            do {
                print("Fetching data...")
                await  viewModel.fetchMealDetail(id: "53049")
                print("Data fetched!")
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}

class MockAPIManagerMealDetail: APIManagerProtocol {
    var mockMealDetail: MealDetail?
    
    func request<T: Decodable>(url: String) async throws -> T {
        if let mockMealDetail = mockMealDetail as? T {
            return mockMealDetail
        }
        throw MockAPIError.mockError
    }
}

enum MockAPIErrorMealDetail: Error {
    case mockError
}
