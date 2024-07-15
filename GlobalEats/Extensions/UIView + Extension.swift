//
//  UIView + Extension.swift
//  MealDB
//
//  Created by csuftitan on 10/27/23.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
}

extension String {
    func isNull() -> String? {
        if self == "" || self == " " {
            return nil
        }
        return self
    }
}

func retriveDataFromUserDefault() -> [Dessert.Meal]? {
    // Retrieve the encoded data from UserDefaults
    if let encodedData = UserDefaults.standard.data(forKey: "favoriteMeals") {
        // Decode the data into an array of Meal objects
        if let decodedMeals = try? JSONDecoder().decode([Dessert.Meal].self, from: encodedData) {
            // Use the decoded array of Meal objects
            print(decodedMeals.count)
            return decodedMeals
        }
    }
    return nil
}
