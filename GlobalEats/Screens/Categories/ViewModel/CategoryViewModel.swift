//
//  CategoryViewModel.swift
//  GlobalEats
//
//  Created by csuftitan on 1/27/24.
//

import Foundation

final class CategoryViewModel {
    
    var categories: [Categories.Category] = [] {
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
    
   @MainActor func fetchAllCategories()  {
        Task {
            self.eventHandler?(.loading)
            do {
                var categoryResponse: Categories = try await apiManager.request(url: EndPointItems.categories.url)
                
                categoryResponse.categories = categoryResponse.categories.sorted(by: { meal1, meal2 in
                    meal1.strCategory < meal2.strCategory
                })
                
                self.categories = categoryResponse.categories
                print("---------------------------------------------")
//                print(self.categories)
                print("---------------------------------------------")
            } catch {
                print(error)
            }
        }
    }
}

extension CategoryViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
