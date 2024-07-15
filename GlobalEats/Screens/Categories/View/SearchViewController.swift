//
//  SearchViewController.swift
//  GlobalEats
//
//  Created by csuftitan on 2/8/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    private var categoryViewModel = CategoryViewModel(apiManager: APIManager.shared)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        configuration()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapButton() {
        
        let vc=UIViewController()
        vc.view.backgroundColor = .red
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        categoryViewModel.fetchAllCategories()
    }
    
    func observeEvent() {
        categoryViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// indicator show
                print("Category Loading...")
            case .stopLoading:
                // indicator hide
                print("Stop Loading...")
            case .dataLoaded:
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.categoryCollectionView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}

// MARK: - CollectionView Delegates

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CategoryCell",
            for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let category = categoryViewModel.categories[indexPath.row]
        cell.category = category
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryViewModel.categories[indexPath.row]
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let categoryDetailViewController = storyboard.instantiateViewController(withIdentifier: "CategoryDetailViewController") as! CategoryDetailViewController
//        categoryDetailViewController.categoryDetail = category
//        
//        self.navigationController?.pushViewController(categoryDetailViewController, animated: true)
//        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dessertListViewController = storyboard.instantiateViewController(withIdentifier: "DessertListViewController") as! DessertListViewController
        dessertListViewController.selectedMeal = category.strCategory
        
        self.navigationController?.pushViewController(dessertListViewController, animated: true)
    }
    
}
