//
//  MealDetailViewController.swift
//  MealDB
//
//  Created by csuftitan on 10/29/23.
//

import UIKit

class MealDetailViewController: UIViewController {

    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var tblIngredients: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel = MealDetailViewModel(apiManager: APIManager.shared)
    var mealId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblIngredients.delegate=self
        tblIngredients.dataSource=self
        tblIngredients.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblIngredients.isScrollEnabled = false
        
        configuration()
        // Do any additional setup after loading the view.
    }
    

}

extension MealDetailViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchMealDetail(id: mealId ?? "53049")
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// indicator show
                activityIndicator.isHidden=false
                activityIndicator.startAnimating()
                print("Desserts Loading...")
            case .stopLoading:
                // indicator hide
                print("Stop Loading...")
            case .dataLoaded:
                activityIndicator.isHidden=true
                activityIndicator.stopAnimating()
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.displayData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
    
    private func displayData() {
        lblName.text = viewModel.mealDetailObject?.name
        lblInstructions.text = viewModel.mealDetailObject?.instructions
        
        tblIngredients.reloadData()
    }
    
}

// MARK: - TableView Delegates

extension MealDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealDetailObject?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.mealDetailObject?.ingredients[indexPath.row].displayName
        return cell
    }

}
