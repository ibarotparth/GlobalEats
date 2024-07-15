//
//  CategoryDetailViewController.swift
//  GlobalEats
//
//  Created by csuftitan on 3/9/24.
//

import UIKit

class CategoryDetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    var categoryDetail: Categories.Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.setImage(with: categoryDetail!.strCategoryThumb)
        lblDescription.text = categoryDetail?.strCategoryDescription
        // Do any additional setup after loading the view.
    }
    



}
