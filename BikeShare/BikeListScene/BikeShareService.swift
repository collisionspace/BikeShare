//
//  BikeShareService.swift
//  BikeShare
//
//  Created by Daniel on 4/11/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

protocol BikeShareService {
    typealias BikeShareServiceCompletionHandler = (Result<BikeStationResponse>) -> Void
    
    func getStations(addressString: String?, completion: @escaping BikeShareServiceCompletionHandler)
}
class BikeRequest: BikeShareService {
    
    func getStations(addressString: String?, completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
        if let url = addressString {
            Alamofire.request(url)
                .responseObject { (response: DataResponse<BikeStationResponse>) in
                    completion(response.result)
            }
        }
    }
}
