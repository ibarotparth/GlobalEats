//
//  IngredientCell.swift
//  GlobalEats
//
//  Created by csuftitan on 3/22/24.
//

import UIKit

class IngredientCell: UICollectionViewCell {

    @IBOutlet weak var imgViewIngredient: UIImageView!
    @IBOutlet weak var lblIngredientName: UILabel!
    
    var ingredient: Ingredients.Ingredient? {
        didSet { // Property Observer
            ingredientConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func ingredientConfiguration() {
        guard let ingredient else { return }
        imgViewIngredient.setImage(with: "https://www.themealdb.com/images/ingredients/\(ingredient.strIngredient)-Small.png")
        lblIngredientName.text = ingredient.strIngredient
    }
    
}
