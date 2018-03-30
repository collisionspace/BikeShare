//
//  BikeSharePresenter.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol BikeSharePresentationLogic {
    func presentBikeShareCities(viewModel: [BikeShareCityViewModel])
    func presentError()
}
private enum Constants {
    static let errorTitle = "Error"
    static let ok = "Ok"
    static let message = "No data was found for the bike cities"
}
class BikeSharePresenter: BikeSharePresentationLogic {
    weak var viewController: BikeShareDisplay?
    
    func presentBikeShareCities(viewModel: [BikeShareCityViewModel]) {        
        viewController?.hideActivityIndicatorView()
        viewController?.displayBikeShareCities(viewModel: viewModel)
    }
    
    func presentError() {
        viewController?.hideActivityIndicatorView()
        viewController?.displayError(title: Constants.errorTitle, message: Constants.message, buttonTitle: Constants.ok)
    }
}
