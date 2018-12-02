//
//  BikeShareCity.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

struct BikeShareCity: Codable {
    var href: String?
    var id: String?
    var location: CityLocation?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case href
        case id
        case location
        case name
    }
}
