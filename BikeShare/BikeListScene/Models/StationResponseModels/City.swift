//
//  City.swift
//  BikeShare
//
//  Created by Daniel on 4/11/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import ObjectMapper

class City: Mappable {
    var href: String?
    var id: String?
    var location: CityLocation?
    var name: String?
    var stations: [Station]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        href <- map["href"]
        id <- map["id"]
        location <- map["location"]
        name <- map["name"]
        stations <- map["stations"]
    }
}
