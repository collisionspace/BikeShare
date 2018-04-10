//
//  BikeShareCityResponse.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import ObjectMapper

class BikeShareCityResponse: Mappable {
    var networks: [BikeShareCity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        networks <- map["networks"]
    }
}
