//
//  EndPointType.swift
//  MealDB
//
//  Created by csuftitan on 10/28/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: String { get }
    var method: HTTPMethods { get }
}

enum EndPointItems {
    case mealList(categoryName: String)
    case lookup(id: String)
    case categories
    case ingredients
    case countries
    case areaMealList(areaName: String)
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .mealList(categoryName: let categoryName):
            return "api/json/v1/1/filter.php?c=\(categoryName)"
        case .lookup(id: let id):
            return "api/json/v1/1/lookup.php?i=\(id)"
        case .categories:
            return "api/json/v1/1/categories.php"
        case .ingredients:
            return "api/json/v1/1/list.php?i=list"
        case .countries:
            return "api/json/v1/1/list.php?a=list"
        case .areaMealList(areaName: let areaName):
            return "api/json/v1/1/filter.php?a=\(areaName)"
        }
    }
    
    var baseURL: String {
        return "https://themealdb.com/"
    }
    
    var url: String {
        return "\(baseURL)\(path)"
    }
    
    var method: HTTPMethods {
        switch self {
        case .mealList:
            return .get
        case .lookup:
            return .get
        case .categories:
            return .get
        case .ingredients:
            return .get
        case .countries:
            return .get
        case .areaMealList:
            return .get
        }
    }
    
}
