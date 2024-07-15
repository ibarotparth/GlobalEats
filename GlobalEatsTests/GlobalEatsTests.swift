//
//  GlobalEatsTests.swift
//  GlobalEatsTests
//
//  Created by csuftitan on 1/27/24.
//
import Foundation
import XCTest
@testable import GlobalEats

final class GlobalEatsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class DessertViewModelTests: XCTestCase {
    
    func testFetchingDesserts() async {
        let mockAPIManager = MockAPIManager()
        mockAPIManager.mockDessert = Dessert(meals: [Dessert.Meal(strMeal: "Apam balik", idMeal: "53049", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")])

        let viewModel = DessertViewModel(apiManager: mockAPIManager)

        let expectation = XCTestExpectation(description: "Data loaded")

        Task {
            do {
                print("Fetching data...")
                await viewModel.fetchDesserts(categoryName: "Dessert")
                print("Data fetched!")
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 10.0)

        print("ViewModel meals count: \(viewModel.meals.count)")

        XCTAssertEqual(viewModel.meals.count, 1)
        XCTAssertEqual(viewModel.meals[0].strMeal, "Apam balik")
    }


    func testSortingMeals() async {
        // Create a mock APIManager that returns a Dessert object with unsorted meals
        let mockAPIManager = MockAPIManager()
        mockAPIManager.mockDessert = Dessert(meals: [
            Dessert.Meal(strMeal: "BeaverTails", idMeal: "52928", strMealThumb: "https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg"),
            Dessert.Meal(strMeal: "Classic Christmas pudding", idMeal: "52988", strMealThumb: "https://www.themealdb.com/images/media/meals/1d85821576790598.jpg"),
            Dessert.Meal(strMeal: "Apam balik", idMeal: "52768", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        ])

        let viewModel = DessertViewModel(apiManager: mockAPIManager)
        
        let expectation = XCTestExpectation(description: "Data loaded")

        Task {
            do {
                print("Fetching data...")
                await viewModel.fetchDesserts(categoryName: "")
                print("Data fetched!")
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)

        print("ViewModel meals count: \(viewModel.meals.count)")
        
        // Assert that meals are sorted alphabetically
        XCTAssertEqual(viewModel.meals.count, 3)
        XCTAssertEqual(viewModel.meals[0].strMeal, "Apam balik")
        XCTAssertEqual(viewModel.meals[1].strMeal, "BeaverTails")
        XCTAssertEqual(viewModel.meals[2].strMeal, "Classic Christmas pudding")
    }

}

class MockAPIManager: APIManagerProtocol {
    
    var mockDessert: Dessert?

    func request<T>(url: String) async throws -> T where T : Decodable {
        guard let dessert = mockDessert as? T else {
            throw MockAPIError.mockError
        }
        return dessert
    }
}

enum MockAPIError: Error {
    case mockError
}
