//
//  BikeSharePresenter.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol BikeSharePresentationLogic {
    func presentBikeShareCities(response: BikeShareCityResponse)
    func presentError(error: Error)
}
private enum Constants {
    static let errorTitle = "Error"
    static let ok = "Ok"
}
class BikeSharePresenter: BikeSharePresentationLogic {
    weak var viewController: BikeShareDisplay?
    
    func presentBikeShareCities(response: BikeShareCityResponse) {
        let viewModels = mapDataToViewModels(response: response)
        
        viewController?.hideActivityIndicatorView()
        viewController?.displayBikeShareCities(viewModel: viewModels)
    }
    
    func presentError(error: Error) {
        viewController?.hideActivityIndicatorView()
        viewController?.displayError(title: Constants.errorTitle, message: error.localizedDescription, buttonTitle: Constants.ok)
    }
}
