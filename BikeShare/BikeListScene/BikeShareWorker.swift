//
//  BikeShareWorker.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Alamofire

class BikeShareWorker: BikeShareService {
    
    private let bikeShareService: BikeShareService
    
    init(bikeShareService: BikeShareService) {
        self.bikeShareService = bikeShareService
    }
    
    func getBikeShareCities(addressString: String?, completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
        bikeShareService.getBikeShareCities(addressString: addressString) { (result) in
            completion(result)
        }
    }
}
