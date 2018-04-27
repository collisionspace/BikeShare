//
//  Extra.swift
//  BikeShare
//
//  Created by Daniel on 4/11/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import ObjectMapper

class Extra: Mappable {
    var uid: Int?
    var status: String?
    var slots: Int?
    var lastUpdate: Int32?
    var bonus: Bool?
    var banking: Bool?
    var address: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        uid <- map["uid"]
        status <- map["status"]
        slots <- map["slots"]
        lastUpdate <- map["last_update"]
        bonus <- map["bonus"]
        banking <- map["banking"]
        address <- map["address"]
    }
}
