//
//  BikeShareInteractor.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

protocol BikeShareUseCase {
    func getBikeShareCities()
}
class BikeShareInteractor: BikeShareUseCase {
    var presenter: BikeSharePresenter?
    var worker: BikeShareWorker = BikeShareWorker()
  
    func getBikeShareCities() {
        worker.getBikeShareCities { result in
            switch result {
            case .success(let bikeShareCities):
                self.presenter?.presentBikeShareCities(response: bikeShareCities)
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
}
