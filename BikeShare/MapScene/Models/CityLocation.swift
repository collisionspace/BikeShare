//
//  CityLocation.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

struct CityLocation: Codable, Equatable {
    var city: String?
    var country: String?
    var latitude: Double?
    var longitude: Double?

    enum CodingKeys: String, CodingKey {
        case city
        case country
        case latitude
        case longitude
    }

    static func ==(lhs: CityLocation, rhs: CityLocation) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
