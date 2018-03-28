//
//  BikeShareWorker.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Alamofire

private enum Constants {
    static let baseUrl = "https://api.citybik.es/v2/"
    static let bikeShareEndPoint = "networks"
}
class BikeShareWorker: BikeShareService {
    
    private let bikeShareService: BikeShareService
    
    init(bikeShareService: BikeShareService) {
        self.bikeShareService = bikeShareService
    }
    
    func getBikeShareCities(completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
        bikeShareService.getBikeShareCities { (result) in
            completion(result)
        }
    }
}
