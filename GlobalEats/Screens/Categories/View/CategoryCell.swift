//
//  DessertCell.swift
//  MealDB
//
//  Created by csuftitan on 10/27/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryBackgroundView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var category: Categories.Category? {
        didSet { // Property Observer
            categoryDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        let size:CGFloat = (screenWidth) / 2.4
        widthConstraint.constant = size
        heightConstraint.constant = size
        
        categoryBackgroundView.backgroundColor = .white
        categoryBackgroundView.clipsToBounds = true
        categoryBackgroundView.layer.cornerRadius = 5
        
        categoryImageView.clipsToBounds = true
        categoryImageView.layer.cornerRadius = 5
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.dropShadow()
        
        categoryLabel.textColor = .white
        categoryLabel.numberOfLines = 2
        categoryLabel.textAlignment = .center
        categoryLabel.clipsToBounds=true
        categoryLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }

    func categoryDetailConfiguration() {
        guard let category else { return }
        categoryLabel.text = category.strCategory
        categoryImageView.setImage(with: category.strCategoryThumb)
    }
}
