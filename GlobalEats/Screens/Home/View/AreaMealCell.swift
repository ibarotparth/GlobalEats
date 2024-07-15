//
//  AreaMealCell.swift
//  GlobalEats
//
//  Created by csuftitan on 4/8/24.
//

import UIKit

class AreaMealCell: UITableViewCell {
    
    @IBOutlet weak var imgViewMeal: UIImageView!
    @IBOutlet weak var lblMealName: UILabel!
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
        lblMealName.textColor = .black
        lblMealName.numberOfLines = 2
        lblMealName.textAlignment = .left
        lblMealName.clipsToBounds=true
        lblMealName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        imgViewMeal.clipsToBounds = true
        imgViewMeal.layer.cornerRadius = 12
        imgViewMeal.contentMode = .scaleAspectFill
        
        btnFavorite.addTarget(self, action: #selector(btnFavoriteTapped), for: .touchUpInside)
//        imgViewMeal.dropShadow()
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
        lblMealName.text = meal.strMeal
        imgViewMeal.setImage(with: meal.strMealThumb)
    }
    
    // Action method for button tap
    @objc func btnFavoriteTapped() {
        btnFavoriteAction?()
    }
    
    
}
