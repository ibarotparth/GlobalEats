//
//  CountryViewController.swift
//  GlobalEats
//
//  Created by csuftitan on 4/12/24.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var countryTableView: UITableView!
    
    private var viewModel = CountryViewModel(apiManager: APIManager.shared)
    
    weak var delegate: CountrySelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UILabel for the title
        let titleLabel = UILabel()
        titleLabel.text = "Select Country"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()

        // Set the label as the title view
        navigationItem.titleView = titleLabel
        
        countryTableView.delegate=self
        countryTableView.dataSource=self
        
        configuration()
        // Do any additional setup after loading the view.
    }
    
}

extension CountryViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchCountries()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// indicator show
                print("Countries Loading...")
            case .stopLoading:
                // indicator hide
                print("Stop Loading...")
            case .dataLoaded:
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.countryTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}


extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var  content = cell.defaultContentConfiguration()
        let country = viewModel.countries[indexPath.row]
        content.text = country.strArea
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.countries[indexPath.row]
        delegate?.didSelectCountry(country.strArea)
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
