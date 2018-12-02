//
//  BikeShareCityResponse.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

class BikeShareCityResponse: Codable {
    var networks: [BikeShareCity]?

    enum CodingKeys: String, CodingKey {
        case networks
    }
}
