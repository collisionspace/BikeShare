//
//  BikeShareCity.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import ObjectMapper

class BikeShareCity: Mappable {
    var href: String?
    var id: String?
    var location: CityLocation?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        href <- map["href"]
        id <- map["id"]
        location <- map["location"]
        name <- map["name"]
    }
}
