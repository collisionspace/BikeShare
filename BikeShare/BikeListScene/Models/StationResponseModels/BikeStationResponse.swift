//
//  BikeStationResponse.swift
//  BikeShare
//
//  Created by Daniel on 4/11/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import ObjectMapper

class BikeStationResponse: Mappable {
    var network: City?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        network <- map["network"]
    }
}
