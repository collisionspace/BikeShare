//
//  BikeShareCityViewModel.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/21/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

class BikeShareCityViewModel {
    private(set) var href: String?
    private(set) var bikeShareName: String?
    private(set) var location: CityLocation?
    
    var cityCountry: String? {
        if let location = location, let city = location.city, let country = location.country {
            return "\(city), \(country)"
        }
        return nil
    }
    
    init(href: String?, bikeShareName: String?, location: CityLocation?) {
        self.href = href
        self.bikeShareName = bikeShareName
        self.location = location
    }
}
