//
//  BikeShareViewController.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

protocol BikeShareDisplay: class {
    func displayBikeShareCities(viewModel: [BikeShareCityViewModel]?)
}
private enum Constants {
    static let cellReuseIdentifier = "BikeShareCity"
    static let cellNibName = "BikeShareCityTableViewCell"
    static let defaultRowHeight = 100.0
}
class BikeShareViewController: UIViewController, BikeShareDisplay {

    @IBOutlet weak var bikeShareTableView: UITableView!
    
    var interactor: BikeShareUseCase?
    var bikeShareCities = [BikeShareCityViewModel]()
    
    // MARK: Oject lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = BikeShareInteractor()
        let presenter = BikeSharePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: Constants.cellNibName, bundle: nil)
        self.bikeShareTableView.register(nib, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        getData()
    }
    
    func getData() {
        interactor?.getBikeShareCities()
    }
    
    func displayBikeShareCities(viewModel: [BikeShareCityViewModel]?) {
        if let viewModel = viewModel {
            bikeShareCities = viewModel
            bikeShareTableView.reloadData()
        }
    }
}

extension BikeShareViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikeShareCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! BikeShareCityTableViewCell
        let row = indexPath.row
        let viewModel = bikeShareCities[row]
        
        cell.bikeShareName.text = viewModel.bikeShareName
        cell.bikeShareLocation.text = viewModel.cityCountry
        if let latitude = viewModel.location?.latitude?.description, let longitude = viewModel.location?.longitude?.description {
            cell.bikeShareLatitude.text = latitude
            cell.bikeShareLongitude.text = longitude
        }
        return cell
    }
}

extension BikeShareViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.defaultRowHeight)
    }
}
