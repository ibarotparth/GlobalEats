//
//  MealDetail.swift
//  MealDB
//
//  Created by csuftitan on 10/29/23.
//

import Foundation

struct MealDetail: Decodable {
    var meals: [MealDetailsObjectFromServer]
    
    struct MealDetailsObjectFromServer: Decodable {
        let id: String
        let name: String
        let instructions: String
        
        let ingredient1: String
        let ingredient2: String
        let ingredient3: String
        let ingredient4: String
        let ingredient5: String
        let ingredient6: String
        let ingredient7: String
        let ingredient8: String
        let ingredient9: String
        let ingredient10: String
        let ingredient11: String
        let ingredient12: String
        let ingredient13: String
        let ingredient14: String
        let ingredient15: String
        let ingredient16: String
        let ingredient17: String
        let ingredient18: String
        let ingredient19: String
        let ingredient20: String
        let measurement1: String
        let measurement2: String
        let measurement3: String
        let measurement4: String
        let measurement5: String
        let measurement6: String
        let measurement7: String
        let measurement8: String
        let measurement9: String
        let measurement10: String
        let measurement11: String
        let measurement12: String
        let measurement13: String
        let measurement14: String
        let measurement15: String
        let measurement16: String
        let measurement17: String
        let measurement18: String
        let measurement19: String
        let measurement20: String
        
        enum CodingKeys: String, CodingKey {
            case id = "idMeal"
            case name = "strMeal"
            case instructions = "strInstructions"
            
            case ingredient1 = "strIngredient1"
            case ingredient2 = "strIngredient2"
            case ingredient3 = "strIngredient3"
            case ingredient4 = "strIngredient4"
            case ingredient5 = "strIngredient5"
            case ingredient6 = "strIngredient6"
            case ingredient7 = "strIngredient7"
            case ingredient8 = "strIngredient8"
            case ingredient9 = "strIngredient9"
            case ingredient10 = "strIngredient10"
            case ingredient11 = "strIngredient11"
            case ingredient12 = "strIngredient12"
            case ingredient13 = "strIngredient13"
            case ingredient14 = "strIngredient14"
            case ingredient15 = "strIngredient15"
            case ingredient16 = "strIngredient16"
            case ingredient17 = "strIngredient17"
            case ingredient18 = "strIngredient18"
            case ingredient19 = "strIngredient19"
            case ingredient20 = "strIngredient20"
            
            case measurement1 = "strMeasure1"
            case measurement2 = "strMeasure2"
            case measurement3 = "strMeasure3"
            case measurement4 = "strMeasure4"
            case measurement5 = "strMeasure5"
            case measurement6 = "strMeasure6"
            case measurement7 = "strMeasure7"
            case measurement8 = "strMeasure8"
            case measurement9 = "strMeasure9"
            case measurement10 = "strMeasure10"
            case measurement11 = "strMeasure11"
            case measurement12 = "strMeasure12"
            case measurement13 = "strMeasure13"
            case measurement14 = "strMeasure14"
            case measurement15 = "strMeasure15"
            case measurement16 = "strMeasure16"
            case measurement17 = "strMeasure17"
            case measurement18 = "strMeasure18"
            case measurement19 = "strMeasure19"
            case measurement20 = "strMeasure20"
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<MealDetail.MealDetailsObjectFromServer.CodingKeys> = try decoder.container(keyedBy: MealDetail.MealDetailsObjectFromServer.CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.instructions = try container.decode(String.self, forKey: .instructions)
            self.ingredient1 = try container.decodeIfPresent(String.self, forKey: .ingredient1) ?? ""
            self.ingredient2 = try container.decodeIfPresent(String.self, forKey: .ingredient2) ?? ""
            self.ingredient3 = try container.decodeIfPresent(String.self, forKey: .ingredient3) ?? ""
            self.ingredient4 = try container.decodeIfPresent(String.self, forKey: .ingredient4) ?? ""
            self.ingredient5 = try container.decodeIfPresent(String.self, forKey: .ingredient5) ?? ""
            self.ingredient6 = try container.decodeIfPresent(String.self, forKey: .ingredient6) ?? ""
            self.ingredient7 = try container.decodeIfPresent(String.self, forKey: .ingredient7) ?? ""
            self.ingredient8 = try container.decodeIfPresent(String.self, forKey: .ingredient8) ?? ""
            self.ingredient9 = try container.decodeIfPresent(String.self, forKey: .ingredient9) ?? ""
            self.ingredient10 = try container.decodeIfPresent(String.self, forKey: .ingredient10) ?? ""
            self.ingredient11 = try container.decodeIfPresent(String.self, forKey: .ingredient11) ?? ""
            self.ingredient12 = try container.decodeIfPresent(String.self, forKey: .ingredient12) ?? ""
            self.ingredient13 = try container.decodeIfPresent(String.self, forKey: .ingredient13) ?? ""
            self.ingredient14 = try container.decodeIfPresent(String.self, forKey: .ingredient14) ?? ""
            self.ingredient15 = try container.decodeIfPresent(String.self, forKey: .ingredient15) ?? ""
            self.ingredient16 = try container.decodeIfPresent(String.self, forKey: .ingredient16) ?? ""
            self.ingredient17 = try container.decodeIfPresent(String.self, forKey: .ingredient17) ?? ""
            self.ingredient18 = try container.decodeIfPresent(String.self, forKey: .ingredient18) ?? ""
            self.ingredient19 = try container.decodeIfPresent(String.self, forKey: .ingredient19) ?? ""
            self.ingredient20 = try container.decodeIfPresent(String.self, forKey: .ingredient20) ?? ""
            self.measurement1 = try container.decodeIfPresent(String.self, forKey: .measurement1) ?? ""
            self.measurement2 = try container.decodeIfPresent(String.self, forKey: .measurement2) ?? ""
            self.measurement3 = try container.decodeIfPresent(String.self, forKey: .measurement3) ?? ""
            self.measurement4 = try container.decodeIfPresent(String.self, forKey: .measurement4) ?? ""
            self.measurement5 = try container.decodeIfPresent(String.self, forKey: .measurement5) ?? ""
            self.measurement6 = try container.decodeIfPresent(String.self, forKey: .measurement6) ?? ""
            self.measurement7 = try container.decodeIfPresent(String.self, forKey: .measurement7) ?? ""
            self.measurement8 = try container.decodeIfPresent(String.self, forKey: .measurement8) ?? ""
            self.measurement9 = try container.decodeIfPresent(String.self, forKey: .measurement9) ?? ""
            self.measurement10 = try container.decodeIfPresent(String.self, forKey: .measurement10) ?? ""
            self.measurement11 = try container.decodeIfPresent(String.self, forKey: .measurement11) ?? ""
            self.measurement12 = try container.decodeIfPresent(String.self, forKey: .measurement12) ?? ""
            self.measurement13 = try container.decodeIfPresent(String.self, forKey: .measurement13) ?? ""
            self.measurement14 = try container.decodeIfPresent(String.self, forKey: .measurement14) ?? ""
            self.measurement15 = try container.decodeIfPresent(String.self, forKey: .measurement15) ?? ""
            self.measurement16 = try container.decodeIfPresent(String.self, forKey: .measurement16) ?? ""
            self.measurement17 = try container.decodeIfPresent(String.self, forKey: .measurement17) ?? ""
            self.measurement18 = try container.decodeIfPresent(String.self, forKey: .measurement18) ?? ""
            self.measurement19 = try container.decodeIfPresent(String.self, forKey: .measurement19) ?? ""
            self.measurement20 = try container.decodeIfPresent(String.self, forKey: .measurement20) ?? ""
        }
        
        func removeNullValues () -> MealLookup {
            var result = [Ingredient]()
            
            print(self.ingredient10)
            
            if let ingredient1 = self.ingredient1.isNull(),  let measurement1 = self.measurement1.isNull() {
                result.append(Ingredient(name: ingredient1, quantity: measurement1))
            }
            if let ingredient2 = self.ingredient2.isNull(), let measurement2 = self.measurement2.isNull() {
                result.append(Ingredient(name: ingredient2, quantity: measurement2))
            }
            if let ingredient3 = self.ingredient3.isNull(),  let measurement3 = self.measurement3.isNull() {
                result.append(Ingredient(name: ingredient3, quantity: measurement3))
            }
            if let ingredient4 = self.ingredient4.isNull(),  let measurement4 = self.measurement4.isNull() {
                result.append(Ingredient(name: ingredient4, quantity: measurement4))
            }
            if let ingredient5 = self.ingredient5.isNull(),  let measurement5 = self.measurement5.isNull() {
                result.append(Ingredient(name: ingredient5, quantity: measurement5))
            }
            if let ingredient6 = self.ingredient6.isNull(),  let measurement6 = self.measurement6.isNull() {
                result.append(Ingredient(name: ingredient6, quantity: measurement6))
            }
            if let ingredient7 = self.ingredient7.isNull(),  let measurement7 = self.measurement7.isNull() {
                result.append(Ingredient(name: ingredient7, quantity: measurement7))
            }
            if let ingredient8 = self.ingredient8.isNull(),  let measurement8 = self.measurement8.isNull() {
                result.append(Ingredient(name: ingredient8, quantity: measurement8))
            }
            if let ingredient9 = self.ingredient9.isNull(),  let measurement9 = self.measurement9.isNull() {
                result.append(Ingredient(name: ingredient9, quantity: measurement9))
            }
            if let ingredient10 = self.ingredient10.isNull(),  let measurement10 = self.ingredient10.isNull() {
                result.append(Ingredient(name: ingredient10, quantity: measurement10))
            }
            if let ingredient11 = self.ingredient11.isNull(),  let measurement11 = self.measurement11.isNull() {
                result.append(Ingredient(name: ingredient11, quantity: measurement11))
            }
            if let ingredient12 = self.ingredient12.isNull(),  let measurement12 = self.measurement12.isNull() {
                result.append(Ingredient(name: ingredient12, quantity: measurement12))
            }
            if let ingredient13 = self.ingredient13.isNull(),  let measurement13 = self.measurement13.isNull() {
                result.append(Ingredient(name: ingredient13, quantity: measurement13))
            }
            if let ingredient14 = self.ingredient14.isNull(),  let measurement14 = self.measurement14.isNull() {
                result.append(Ingredient(name: ingredient14, quantity: measurement14))
            }
            if let ingredient15 = self.ingredient15.isNull(),  let measurement15 = self.measurement15.isNull() {
                result.append(Ingredient(name: ingredient15, quantity: measurement15))
            }
            if let ingredient16 = self.ingredient16.isNull(),  let measurement16 = self.measurement16.isNull() {
                result.append(Ingredient(name: ingredient16, quantity: measurement16))
            }
            if let ingredient17 = self.ingredient17.isNull(),  let measurement17 = self.measurement17.isNull() {
                result.append(Ingredient(name: ingredient17, quantity: measurement17))
            }
            if let ingredient18 = self.ingredient18.isNull(),  let measurement18 = self.measurement18.isNull() {
                result.append(Ingredient(name: ingredient18, quantity: measurement18))
            }
            if let ingredient19 = self.ingredient19.isNull(),  let measurement19 = self.measurement19.isNull() {
                result.append(Ingredient(name: ingredient19, quantity: measurement19))
            }
            if let ingredient20 = self.ingredient20.isNull(),  let measurement20 = self.measurement20.isNull() {
                result.append(Ingredient(name: ingredient20, quantity: measurement20))
            }
            
            let detail = MealLookup(name: self.name, instructions: self.instructions, ingredients: result)
            
            return detail
        }
        
    }
}

struct Ingredient: Decodable {
    let name: String
    let quantity: String
    let displayName: String

    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
        self.displayName = name + " : " + quantity
    }
}

struct MealLookup : Decodable {
    var name: String
    var instructions: String
    var ingredients: [Ingredient]
}
