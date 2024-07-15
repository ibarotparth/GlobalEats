//
//  Country.swift
//  GlobalEats
//
//  Created by csuftitan on 4/12/24.
//

import Foundation

struct Countries: Decodable  {
    var meals: [Country]
    
    struct Country: Decodable {
        var strArea: String
    }
}
