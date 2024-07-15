//
//  Ingredients.swift
//  GlobalEats
//
//  Created by csuftitan on 3/22/24.
//

import Foundation

struct Ingredients: Decodable  {
    var meals: [Ingredient]
    
    struct Ingredient: Decodable {
        var idIngredient: String
        var strIngredient: String
    }
}
