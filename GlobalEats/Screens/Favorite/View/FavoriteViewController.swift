//
//  FavoriteViewController.swift
//  GlobalEats
//
//  Created by csuftitan on 4/25/24.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteMealTableView: UITableView!
    
    @IBOutlet weak var lblNoFavorite: UILabel!
    
    var favoriteSelectedMeals = [Dessert.Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteSelectedMeals = retriveDataFromUserDefault() ?? []
        
        favoriteMealTableView.delegate = self
        favoriteMealTableView.dataSource = self
        
        let nib = UINib(nibName: "FavoriteMealCell", bundle: nil)
        favoriteMealTableView.register(nib, forCellReuseIdentifier: "FavoriteMealCell")
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteSelectedMeals = retriveDataFromUserDefault() ?? []
        if favoriteSelectedMeals.count > 0 {
            favoriteMealTableView.isHidden=false
            lblNoFavorite.isHidden = true
        } else {
            favoriteMealTableView.isHidden=true
            lblNoFavorite.isHidden = false
        }
        
        
        DispatchQueue.main.async {
            self.favoriteMealTableView.reloadData()
        }
    }
}

// MARK: - TableView Delegates

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteSelectedMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMealCell", for: indexPath) as! FavoriteMealCell

        let meal = favoriteSelectedMeals[indexPath.row]
        cell.meal = meal
        cell.isFavorite = favoriteSelectedMeals.contains { favoriteMeal in
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
        let meal = favoriteSelectedMeals[indexPath.row]
    
        if let detailViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MealDetailViewController") as? MealDetailViewController  {
            detailViewController.mealId = meal.idMeal
            self.navigationController?.pushViewController(detailViewController,animated:true)
        }
    }
    
    func setFavoriteImage(_ cell: FavoriteMealCell) {
        if cell.isFavorite == true {
            cell.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.btnFavorite.tintColor = .red
        } else {
            cell.btnFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.btnFavorite.tintColor = .white
        }
    }
    
    func addFavoriteMeal(_ meal: Dessert.Meal,_ indexPath: IndexPath,_ cell: FavoriteMealCell) {
        
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
        
        favoriteSelectedMeals = retriveDataFromUserDefault() ?? []
        
        if favoriteSelectedMeals.count > 0 {
            favoriteMealTableView.isHidden=false
            lblNoFavorite.isHidden = true
        } else {
            favoriteMealTableView.isHidden=true
            lblNoFavorite.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.favoriteMealTableView.reloadData()
        }
        
        
    }
    
}
