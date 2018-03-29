//
//  MapInteractor.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

protocol MapUseCase {
    func getBikeShareCities()
}
protocol MapDataStore {
    
}
private enum Constants {
    static let baseUrl = "https://api.citybik.es/v2/"
    static let bikeShareEndPoint = "networks"
}
class MapInteractor: MapUseCase {
    var presenter: MapPresenter?
    var worker: MapWorker
    
    init() {
        worker = MapWorker(mapService: MapRequest())
    }
    
    func getBikeShareCities() {
        worker.getBikeShareCities(addressString: Constants.baseUrl + Constants.bikeShareEndPoint) { result in
            switch result {
            case .success(let bikeShareCities):
                self.presenter?.presentBikeShareCities(response: bikeShareCities)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
}
