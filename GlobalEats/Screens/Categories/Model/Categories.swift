//
//  Categories.swift
//  GlobalEats
//
//  Created by csuftitan on 1/27/24.
//

import Foundation

struct Categories: Decodable  {
    var categories: [Category]
    
    struct Category: Decodable {
        var strCategory: String
        var idCategory: String
        var strCategoryThumb: String
        var strCategoryDescription: String
    }
}
