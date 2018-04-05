//
//  BikeShareViewController.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

protocol BikeShareDisplay: class {
    func displayBikeShareCities()
    func displayError(title: String, message: String, buttonTitle: String)
    func showActivityIndicatorView()
    func hideActivityIndicatorView()
}
private enum Constants {
    static let cellReuseIdentifier = "BikeShareCity"
    static let cellNibName = "BikeShareCityTableViewCell"
    static let defaultRowHeight = 100.0
}
class BikeShareViewController: UIViewController, BikeShareDisplay {

    @IBOutlet weak var bikeShareTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var interactor: (BikeShareUseCase & BikeShareDataStore)?
    var router: BikeShareRouter?
    
    // MARK: Oject lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BikeShareConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let nib = UINib.init(nibName: Constants.cellNibName, bundle: nil)
        self.bikeShareTableView.register(nib, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        interactor?.getBikeShareCities()
        
        let searchBar = UISearchBar()
        let searchBarContainer = SearchBarView(customSearchBar: searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarContainer
        searchBarContainer.searchBarDelegate = self
    }
    
    func displayBikeShareCities() {
        bikeShareTableView.reloadData()
    }
    
    func displayError(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicatorView() {
        activityIndicatorView.isHidden = false
    }
    
    func hideActivityIndicatorView() {
        activityIndicatorView.isHidden = true
    }
}

extension BikeShareViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let isActive = interactor?.isSearchBarActive, isActive, let filtered = interactor?.filterViewModels {
            return filtered.count
        }
        guard let list = interactor?.viewModels else { return 0 }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! BikeShareCityTableViewCell
        let row = indexPath.row
        
        if let isActive = interactor?.isSearchBarActive, isActive, let filtered = interactor?.filterViewModels?[row] {
            setCell(cell: cell, viewModel: filtered)
        } else if let viewModel = interactor?.viewModels?[row] {
            setCell(cell: cell, viewModel: viewModel)
        }
        
        return cell
    }
    
    private func setCell(cell: BikeShareCityTableViewCell, viewModel: BikeShareCityViewModel) {
        cell.bikeShareName.text = viewModel.bikeShareName
        cell.bikeShareLocation.text = viewModel.cityCountry
        if let latitude = viewModel.location?.latitude?.description, let longitude = viewModel.location?.longitude?.description {
            cell.bikeShareLatitude.text = latitude
            cell.bikeShareLongitude.text = longitude
        }
    }
}

extension BikeShareViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.defaultRowHeight)
    }
}

extension BikeShareViewController: SearchBarDelegate {

    func textDidChange(searchText: String) {
        interactor?.filterBikeShareCities(searchText: searchText)
    }
    
    func isSearchBar(active: Bool) {
        interactor?.isSearchBarActive = active
    }
}
