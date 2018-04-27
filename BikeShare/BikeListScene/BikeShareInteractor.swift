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
    func getStations(index: Int)
}
protocol BikeShareDataStore: class {
    var viewModels: [BikeListViewModel]? { get set }
    var filterViewModels: [BikeListViewModel]? { get set }
    var isSearchBarActive: Bool? { get set }
}
private enum Constants {
    static let baseUrl = "https://api.citybik.es"
}
class BikeShareInteractor: BikeShareUseCase, BikeShareDataStore {
    var presenter: BikeSharePresenter?
    var viewModels: [BikeListViewModel]?
    var filterViewModels: [BikeListViewModel]?
    var isSearchBarActive: Bool?
    private var worker: BikeShareWorker
    
    init() {
        worker = BikeShareWorker(bikeShareService: BikeRequest())
    }
    
    func getBikeShareCities() {
        if viewModels != nil {
            presenter?.presentBikeShareCities()
        } else {
            presenter?.presentError()
        }
    }
    
    func filterBikeShareCities(searchText: String) {
        if let isActive = isSearchBarActive, isActive, let viewModels = viewModels {
            filterViewModels = viewModels.filter {
                $0.bikeShareName?.range(of: searchText, options: .caseInsensitive) != nil ||
                $0.cityCountry?.range(of: searchText, options: .caseInsensitive) != nil
            }
            
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
    
    func getStations(index: Int) {
        worker.getStations(addressString: Constants.baseUrl + getEndpoint(index: index)) { result in
            switch result {
            case .success(let stations):
                self.presenter?.presentBikeShareCities()
            case .failure(let error):
                self.presenter?.presentBikeShareCities()
            }
        }
    }
    
    private func getEndpoint(index: Int) -> String {
        var endpoint = ""
        
        if let isActive = isSearchBarActive, isActive, let filterViewModels = filterViewModels, let href = filterViewModels[index].href {
            endpoint = href
        } else if let href = viewModels?[index].href {
            endpoint = href
        }
        return endpoint
    }
}
