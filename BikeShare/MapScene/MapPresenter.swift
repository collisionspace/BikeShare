//
//  MapPresenter.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol MapPresentationLogic {
    func presentBikeShareCities(response: BikeShareCityResponse)
    func presentError(error: Error)
}
private enum Constants {
    static let errorTitle = "Error"
    static let ok = "Ok"
}
class MapPresenter: MapPresentationLogic {
    weak var viewController: MapDisplay?
    
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
