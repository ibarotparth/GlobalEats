//
//  FavoriteMealCell.swift
//  GlobalEats
//
//  Created by csuftitan on 4/26/24.
//

import UIKit

class FavoriteMealCell: UITableViewCell {

    @IBOutlet weak var imgViewFavoriteMeal: UIImageView!
    @IBOutlet weak var lblFavoriteMealName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    // Add an action closure to handle button tap
    var btnFavoriteAction: (() -> Void)?
    var isFavorite: Bool = false
    
    var meal: Dessert.Meal? {
        didSet { // Property Observer
            dessertDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblFavoriteMealName.textColor = .black
        lblFavoriteMealName.numberOfLines = 2
        lblFavoriteMealName.textAlignment = .left
        lblFavoriteMealName.clipsToBounds=true
        lblFavoriteMealName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        imgViewFavoriteMeal.clipsToBounds = true
        imgViewFavoriteMeal.layer.cornerRadius = 12
        imgViewFavoriteMeal.contentMode = .scaleAspectFill
        
        btnFavorite.addTarget(self, action: #selector(btnFavoriteTapped), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    func dessertDetailConfiguration() {
        guard let meal else { return }
        lblFavoriteMealName.text = meal.strMeal
        imgViewFavoriteMeal.setImage(with: meal.strMealThumb)
    }
    
    // Action method for button tap
    @objc func btnFavoriteTapped() {
        btnFavoriteAction?()
    }
    
}
