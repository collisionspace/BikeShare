//
//  BikeShareWorker.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

private enum Constants {
    static let baseUrl = "https://api.citybik.es/v2/"
    static let bikeShareEndPoint = "networks"
}
class BikeShareWorker {
    func getBikeShareCities(completion:@escaping (Result<BikeShareCityResponse>) -> Void) {
        Alamofire.request(Constants.baseUrl + Constants.bikeShareEndPoint)
            .responseObject { (response: DataResponse<BikeShareCityResponse>) in
                completion(response.result)
        }
    }
}
