//
//  BikeShareInteractor.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol BikeShareUseCase {
    func getBikeShareCities()
    func filterBikeShareCities(searchText: String)
}
protocol BikeShareDataStore: class {
    var viewModels: [BikeShareCityViewModel]? { get set }
    var filterViewModels: [BikeShareCityViewModel]? { get set }
    var isSearchBarActive: Bool? { get set }
}
class BikeShareInteractor: BikeShareUseCase, BikeShareDataStore {
    var presenter: BikeSharePresenter?
    var viewModels: [BikeShareCityViewModel]?
    var filterViewModels: [BikeShareCityViewModel]?
    var isSearchBarActive: Bool?
    
    func getBikeShareCities() {
        if viewModels != nil {
            presenter?.presentBikeShareCities()
        } else {
            presenter?.presentError()
        }
    }
    
    func filterBikeShareCities(searchText: String) {
        if let isActive = isSearchBarActive, isActive, let viewModels = viewModels {
            filterViewModels = viewModels.filter { $0.bikeShareName?.range(of: searchText, options: .caseInsensitive) != nil }
            
            //presents filtered array if count is bigger than 0
            //or search text isn't empty
            if let filteredCount = filterViewModels?.count, filteredCount > 0 || !searchText.isEmpty {
                presenter?.presentBikeShareCities()
            } else {
                filterViewModels = viewModels
                presenter?.presentBikeShareCities()
            }
        }
    }
}
