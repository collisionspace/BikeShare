//
//  MapWorker.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

class MapWorker: MapService {
    
    private let mapService: MapService
    
    init(mapService: MapService) {
        self.mapService = mapService
    }
    
    func getBikeShareCities(addressString: String?, completion: @escaping (MapServiceResponseHandler) -> ()) {
        mapService.getBikeShareCities(addressString: addressString) { (result) in
            completion(result)
        }
    }
}
