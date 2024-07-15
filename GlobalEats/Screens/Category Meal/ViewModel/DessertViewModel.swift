//
//  DessertViewModel.swift
//  MealDB
//
//  Created by csuftitan on 10/27/23.
//

import Foundation

final class DessertViewModel {
    
    var meals: [Dessert.Meal] = [] {
        didSet {
            self.eventHandler?(.dataLoaded)
        }
    }
    var eventHandler: ((_ event: Event) -> Void)?   //Data Binding Closure
    
    // Dependency injection: Provide an APIManager instance to the view model.
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    @MainActor func fetchDesserts(categoryName: String)  {
        Task {
            self.eventHandler?(.loading)
            do {
                var dessertResponse: Dessert = try await apiManager.request(url: EndPointItems.mealList(categoryName: categoryName).url)
                
                dessertResponse.meals = dessertResponse.meals.sorted(by: { meal1, meal2 in
                    meal1.strMeal < meal2.strMeal
                })
                
                self.meals = dessertResponse.meals
            } catch {
                print(error)
            }
        }
    }
}

extension DessertViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
