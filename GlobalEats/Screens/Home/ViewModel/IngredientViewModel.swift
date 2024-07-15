//
//  IngredientViewModel.swift
//  GlobalEats
//
//  Created by csuftitan on 3/22/24.
//

import Foundation

final class IngredientViewModel {
    
    var ingredients: [Ingredients.Ingredient] = [] {
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
    
    @MainActor func fetchIngredients()  {
        Task {
            self.eventHandler?(.loading)
            do {
                var ingredientResponse: Ingredients = try await apiManager.request(url: EndPointItems.ingredients.url)
                
                self.ingredients = ingredientResponse.meals
//                print(self.ingredients)
            } catch {
                print(error)
            }
        }
    }
}

extension IngredientViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
