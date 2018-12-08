//
//  MapPresenter.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol MapPresentationLogic {
    func presentBikeShareCities(response: [BikeShareCityViewModel])
    func presentError(error: Error)
    func present(regions: [String])
}
private enum Constants {
    static let errorTitle = "Error"
    static let ok = "Ok"
}
class MapPresenter: MapPresentationLogic {
    weak var viewController: MapDisplay?
    
    func presentBikeShareCities(response: [BikeShareCityViewModel]) {
        viewController?.hideActivityIndicatorView()
        viewController?.displayBikeShareCities(viewModel: response)
    }
    
    func presentError(error: Error) {
        viewController?.hideActivityIndicatorView()
        viewController?.displayError(title: Constants.errorTitle, message: error.localizedDescription, buttonTitle: Constants.ok)
    }

    func present(regions: [String]) {
        viewController?.display(regions: regions)
    }
}
