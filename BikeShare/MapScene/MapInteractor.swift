//
//  MapInteractor.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol MapUseCase {
    func getBikeShareCities()
    func setViewModels(viewModels: [BikeShareCityViewModel])
}
protocol MapDataStore {
    var viewModels: [BikeShareCityViewModel]? { get }
}
private enum Constants {
    static let baseUrl = "https://api.citybik.es/v2/"
    static let bikeShareEndPoint = "networks"
}
class MapInteractor: MapUseCase, MapDataStore {
    var presenter: MapPresenter?
    var worker: MapWorker
    var viewModels: [BikeShareCityViewModel]?
    
    init() {
        worker = MapWorker(mapService: MapRequest())
    }
    
    func getBikeShareCities() {
        worker.getBikeShareCities(addressString: Constants.baseUrl + Constants.bikeShareEndPoint) { result in
            switch result {
            case .success(let bikeShareCities):
                self.presenter?.presentBikeShareCities(response: bikeShareCities)
            case .failed(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func setViewModels(viewModels: [BikeShareCityViewModel]) {
        self.viewModels = viewModels
    }
}
