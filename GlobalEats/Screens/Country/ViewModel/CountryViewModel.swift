//
//  CountryViewModel.swift
//  GlobalEats
//
//  Created by csuftitan on 4/12/24.
//

import Foundation

final class CountryViewModel {
    
    var countries: [Countries.Country] = [] {
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
    
    @MainActor func fetchCountries()  {
        Task {
            self.eventHandler?(.loading)
            do {
                var countryResponse: Countries = try await apiManager.request(url: EndPointItems.countries.url)
                
                self.countries = countryResponse.meals
//                print(self.countries)
            } catch {
                print(error)
            }
        }
    }
}

extension CountryViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
