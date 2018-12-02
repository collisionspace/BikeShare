//
//  MapService.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

protocol MapService {
    typealias MapServiceResponseHandler = ApiResponse<BikeShareCityResponse, Error>
    
    func getBikeShareCities(addressString: String?, completion: @escaping  (ApiResponse<BikeShareCityResponse, Error>) -> Void)
}
class MapRequest: MapService {

    private let baseRequest = BaseRequest()

    func getBikeShareCities(addressString: String?, completion: @escaping (ApiResponse<BikeShareCityResponse, Error>) -> Void) {
        if let url = addressString {
            baseRequest.request(url: url, method: .GET, parameters: nil, headers: nil) { (response: MapServiceResponseHandler) -> () in
                completion(response)
            }
        }
    }
}
