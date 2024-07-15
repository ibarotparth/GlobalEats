//
//  DessertListViewController.swift
//  MealDB
//
//  Created by csuftitan on 10/26/23.
//

import UIKit

class DessertListViewController: UIViewController {

    @IBOutlet weak var dessertCollectionView: UICollectionView!
    private var viewModel = DessertViewModel(apiManager: APIManager.shared)
    var selectedMeal: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dessertCollectionView.delegate = self
        dessertCollectionView.dataSource = self
        dessertCollectionView.register(UINib(nibName: "DessertCell", bundle: nil), forCellWithReuseIdentifier: "DessertCell")
        configuration()
        // Do any additional setup after loading the view.
    }
    
}

extension DessertListViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchDesserts(categoryName: selectedMeal ?? "Chicken")
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// indicator show
                print("Desserts Loading...")
            case .stopLoading:
                // indicator hide
                print("Stop Loading...")
            case .dataLoaded:
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.dessertCollectionView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}

// MARK: - CollectionView Delegates

extension DessertListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DessertCell",
            for: indexPath) as? DessertCell else {
            return UICollectionViewCell()
        }
        let meal = viewModel.meals[indexPath.row]
        cell.meal = meal
        
        cell.isFavorite = favoriteMeals.contains { favoriteMeal in
            favoriteMeal.idMeal == meal.idMeal
        }
        setFavoriteImage(cell)
    
        cell.btnFavoriteAction = {
            cell.isFavorite = !cell.isFavorite
            self.setFavoriteImage(cell)
            print("BUTTON TAG:\(cell.btnFavorite.tag)")
            self.addFavoriteMeal(meal, indexPath, cell)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row >= 0 && indexPath.row < viewModel.meals.count else {
            return
        }
        
        let meal = viewModel.meals[indexPath.row]
    
        if let detailViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MealDetailViewController") as? MealDetailViewController  {
            detailViewController.mealId = meal.idMeal
            self.navigationController?.pushViewController(detailViewController,animated:true)
        }
    }
    
    func setFavoriteImage(_ cell: DessertCell) {
        if cell.isFavorite == true {
            cell.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.btnFavorite.tintColor = .red
        } else {
            cell.btnFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.btnFavorite.tintColor = .white
        }
    }
    
    func addFavoriteMeal(_ meal: Dessert.Meal,_ indexPath: IndexPath,_ cell: DessertCell) {
        
        if cell.isFavorite {
        
            favoriteMeals.append(meal)
            
            
            // Encode the array of Meal objects into data
            if let encodedData = try? JSONEncoder().encode(favoriteMeals) {
                // Store the encoded data in UserDefaults
                UserDefaults.standard.set(encodedData, forKey: "favoriteMeals")
            }

            UserDefaults.standard.synchronize()
            print("FAVORITE MEAL AFTER ADD\(favoriteMeals.count)")
        } else {
            // Find the index of the dictionary where "id" matches idToRemove
            if let indexToRemove = favoriteMeals.firstIndex(where: { $0.idMeal == meal.idMeal }) {
                // Remove the dictionary at the found index
                favoriteMeals.remove(at: indexToRemove)
                
                // Encode the array of Meal objects into data
                if let encodedData = try? JSONEncoder().encode(favoriteMeals) {
                    // Store the encoded data in UserDefaults
                    UserDefaults.standard.set(encodedData, forKey: "favoriteMeals")
                }

                UserDefaults.standard.synchronize()
                print("FAVORITE MEAL AFTER REMOVE\(favoriteMeals.count)")
            }
        }
    }
}
