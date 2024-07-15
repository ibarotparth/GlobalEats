//
//  HomeViewController.swift
//  GlobalEats
//
//  Created by csuftitan on 3/22/24.
//

import UIKit

// Define a protocol to pass data backward
protocol CountrySelectDelegate: AnyObject {
    func didSelectCountry(_ name: String)
}

var favoriteMeals = [Dessert.Meal]()

class HomeViewController: UIViewController, CountrySelectDelegate {

    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    
    @IBOutlet weak var areaMealTableView: UITableView!
    
    private var viewModel = IngredientViewModel(apiManager: APIManager.shared)
    private var areaMealviewModel = AreaMealViewModel(apiManager: APIManager.shared)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientCollectionView.delegate = self
        ingredientCollectionView.dataSource = self
        ingredientCollectionView.register(UINib(nibName: "IngredientCell", bundle: nil), forCellWithReuseIdentifier: "IngredientCell")
        
        areaMealTableView.delegate = self
        areaMealTableView.dataSource = self
        
        let nib = UINib(nibName: "AreaMealCell", bundle: nil)
        areaMealTableView.register(nib, forCellReuseIdentifier: "AreaMealCell")
        
        let rightButtonItem = UIBarButtonItem.init(
              title: "Country",
              style: .done,
              target: self,
              action: #selector(rightButtonAction(_:))
        )

        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        
        configuration()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteMeals = retriveDataFromUserDefault() ?? []
        
        DispatchQueue.main.async {
            self.areaMealTableView.reloadData()
        }
    }

    
    @objc func rightButtonAction(_ sender: UIBarButtonItem) {
        // Your code to handle the action goes here
        print("Country button tapped")
        
        // Instantiate the view controller from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countryViewController = storyboard.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        countryViewController.delegate = self
        countryViewController.modalPresentationStyle = .fullScreen
        countryViewController.title = "Select Country"

        // Embed the presented view controller in a navigation controller
        let navigationController = UINavigationController(rootViewController: countryViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        // Present the view controller
        present(navigationController, animated: true, completion: nil)

        
    }
    
    func didSelectCountry(_ name: String) {
        // Handle the selected item here
        print("Selected country: \(name)")
        areaMealviewModel.fetchDesserts(areaName: name)
    }
    
}

extension HomeViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchIngredients()
        areaMealviewModel.fetchDesserts(areaName: "Indian")
        
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// indicator show
                print("Ingredients Loading...")
            case .stopLoading:
                // indicator hide
                print("Stop Loading...")
            case .dataLoaded:
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.ingredientCollectionView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
        
        areaMealviewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// indicator show
                print("Area Meal Loading...")
            case .stopLoading:
                // indicator hide
                print("Stop Loading...")
            case .dataLoaded:
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.areaMealTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
        
    }
}

// MARK: - CollectionView Delegates

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "IngredientCell",
            for: indexPath) as? IngredientCell else {
            return UICollectionViewCell()
        }
        let ingredient = viewModel.ingredients[indexPath.row]
        cell.ingredient = ingredient
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ingredient = viewModel.ingredients[indexPath.row]
        print(ingredient.strIngredient)
    }
}

// MARK: - TableView Delegates

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaMealviewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaMealCell", for: indexPath) as! AreaMealCell

        let meal = areaMealviewModel.meals[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = areaMealviewModel.meals[indexPath.row]
    
        if let detailViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MealDetailViewController") as? MealDetailViewController  {
            detailViewController.mealId = meal.idMeal
            self.navigationController?.pushViewController(detailViewController,animated:true)
        }
    }
    
    func setFavoriteImage(_ cell: AreaMealCell) {
        if cell.isFavorite == true {
            cell.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.btnFavorite.tintColor = .red
        } else {
            cell.btnFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.btnFavorite.tintColor = .white
        }
    }
    
    func addFavoriteMeal(_ meal: Dessert.Meal,_ indexPath: IndexPath,_ cell: AreaMealCell) {
        
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
