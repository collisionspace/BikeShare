//
//  MapService.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

protocol MapService {
    typealias MapServiceCompletionHandler = (Result<BikeShareCityResponse>) -> Void
    
    func getBikeShareCities(addressString: String?, completion: @escaping MapServiceCompletionHandler)
}
class MapRequest: MapService {
    
    func getBikeShareCities(addressString: String?, completion: @escaping MapService.MapServiceCompletionHandler) {
        if let url = addressString {
            Alamofire.request(url)
                .responseObject { (response: DataResponse<BikeShareCityResponse>) in
                    completion(response.result)
            }
        }
    }
}
