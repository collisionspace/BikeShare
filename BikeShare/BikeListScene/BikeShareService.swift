//
//  BikeShareCityService.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/28/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

protocol BikeShareService {
    typealias BikeShareServiceCompletionHandler = (Result<BikeShareCityResponse>) -> Void
    
    func getBikeShareCities(addressString: String?, completion: @escaping BikeShareServiceCompletionHandler)
}
class BikeShareRequest: BikeShareService {
    
    func getBikeShareCities(addressString: String?, completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
        if let url = addressString {
            Alamofire.request(url)
                .responseObject { (response: DataResponse<BikeShareCityResponse>) in
                    completion(response.result)
            }
        }
    }
}
