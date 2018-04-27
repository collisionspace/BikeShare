//
//  Station.swift
//  BikeShare
//
//  Created by Daniel on 4/11/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import ObjectMapper

class Station: Mappable {
    var id: String?
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var timestamp: String?
    var emptySlots: Int?
    var extra: Extra?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        name <- map["name"]
        timestamp <- map["timestamp"]
        emptySlots <- map["empty_slots"]
        extra <- map["extra"]
    }
}
