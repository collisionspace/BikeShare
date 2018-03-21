//
//  BikeSharePresenter.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

protocol BikeSharePresentationLogic {
    func presentBikeShareCities(response: BikeShareCityResponse)
}
class BikeSharePresenter: BikeSharePresentationLogic {
    weak var viewController: BikeShareDisplay?
    
    func presentBikeShareCities(response: BikeShareCityResponse) {
        let viewModels = response.networks?.map {
            (bikeShareCity: BikeShareCity) -> BikeShareCityViewModel in
            BikeShareCityViewModel(href: bikeShareCity.href, bikeShareName: bikeShareCity.name, location: bikeShareCity.location)
        }
        
        viewController?.hideActivityIndicatorView()
        viewController?.displayBikeShareCities(viewModel: viewModels)
    }
}
