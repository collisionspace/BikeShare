//
//  BikeListViewModel.swift
//  BikeShare
//
//  Created by Daniel Slone on 4/10/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

class BikeListViewModel {
    private(set) var id: String?
    private(set) var href: String?
    private(set) var bikeShareName: String?
    private(set) var location: BikeShareLocation?
    
    var cityCountry: String? {
        if let location = location, let city = location.city, let country = location.country {
            return "\(city), \(country)"
        }
        return nil
    }
    
    init(id: String?, href: String?, bikeShareName: String?, location: BikeShareLocation?) {
        self.id = id
        self.href = href
        self.bikeShareName = bikeShareName
        self.location = location
    }
}
