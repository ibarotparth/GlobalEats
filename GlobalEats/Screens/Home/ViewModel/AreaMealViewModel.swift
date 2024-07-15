//
//  AreaMealViewModel.swift
//  GlobalEats
//
//  Created by csuftitan on 4/8/24.
//

import Foundation

final class AreaMealViewModel {
    
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
    
    @MainActor func fetchDesserts(areaName: String)  {
        Task {
            self.eventHandler?(.loading)
            do {
                var dessertResponse: Dessert = try await apiManager.request(url: EndPointItems.areaMealList(areaName: areaName).url)
                
                dessertResponse.meals = dessertResponse.meals.sorted(by: { meal1, meal2 in
                    meal1.strMeal < meal2.strMeal
                })
                
                self.meals = dessertResponse.meals
                print("AREA MEALS:\(self.meals)")
            } catch {
                print(error)
            }
        }
    }
}

extension AreaMealViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
