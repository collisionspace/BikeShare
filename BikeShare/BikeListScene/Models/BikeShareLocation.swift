//
//  BikeShareLocation.swift
//  BikeShare
//
//  Created by Daniel Slone on 4/10/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//


class BikeShareLocation {
    private(set) var city: String?
    private(set) var country: String?
    private(set) var latitude: Double?
    private(set) var longitude: Double?
    
    init(city: String?, country: String?, latitude: Double?, longitude: Double?) {
        self.city = city
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }

}
