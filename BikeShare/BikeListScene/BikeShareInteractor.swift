//
//  BikeShareInteractor.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol BikeShareUseCase {
    func getBikeShareCities()
}
protocol BikeShareDataStore {
    var viewModels: [BikeShareCityViewModel]? { get set }
}
class BikeShareInteractor: BikeShareUseCase, BikeShareDataStore {
    var presenter: BikeSharePresenter?
    var viewModels: [BikeShareCityViewModel]?

    func getBikeShareCities() {
        if let viewModels = viewModels {
            presenter?.presentBikeShareCities(viewModel: viewModels)
        } else {
            presenter?.presentError()
        }
    }
}
