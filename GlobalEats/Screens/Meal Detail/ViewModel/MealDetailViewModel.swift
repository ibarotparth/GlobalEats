//
//  MealDetailViewModel.swift
//  MealDB
//
//  Created by csuftitan on 10/29/23.
//

import Foundation

final class MealDetailViewModel {
    
    var mealDetailObject: MealLookup?
    var eventHandler: ((_ event: Event) -> Void)?
    
    // Dependency injection: Provide an APIManager instance to the view model.
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    @MainActor func fetchMealDetail(id: String)  {
         Task {
             self.eventHandler?(.loading)
             do {
                 let mealDetailResponse: MealDetail = try await apiManager.request(url: EndPointItems.lookup(id: id).url)

                 let results = mealDetailResponse.meals
                 
                 for result in results {
                     print(result)
                     self.mealDetailObject=result.removeNullValues()
                 }
                 self.eventHandler?(.dataLoaded)
             } catch {
                 print(error)
             }
         }
     }
    
}

extension MealDetailViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
