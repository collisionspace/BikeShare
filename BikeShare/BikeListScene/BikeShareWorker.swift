//
//  BikeShareWorker.swift
//  BikeShare
//
//  Created by Daniel on 4/11/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Alamofire

class BikeShareWorker: BikeShareService {
    
    private let bikeShareService: BikeShareService
    
    init(bikeShareService: BikeShareService) {
        self.bikeShareService = bikeShareService
    }
    
    func getStations(addressString: String?, completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
        bikeShareService.getStations(addressString: addressString) { (result) in
            completion(result)
        }
    }
}
