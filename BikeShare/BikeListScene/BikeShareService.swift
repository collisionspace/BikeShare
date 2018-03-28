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
    
    func getBikeShareCities(completion: @escaping BikeShareServiceCompletionHandler)
}
private enum Constants {
    static let baseUrl = "https://api.citybik.es/v2/"
    static let bikeShareEndPoint = "networks"
}
class BikeShareRequest: BikeShareService {
    
    func getBikeShareCities(completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
        Alamofire.request(Constants.baseUrl + Constants.bikeShareEndPoint)
            .responseObject { (response: DataResponse<BikeShareCityResponse>) in
                completion(response.result)
        }
    }
}
