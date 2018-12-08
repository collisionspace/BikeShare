//
//  BikeShareMapper.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/28/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

func mapDataToViewModels(response: [BikeShareCity]) -> [BikeShareCityViewModel] {
    let viewModels = response.map {
        (bikeShareCity: BikeShareCity) -> BikeShareCityViewModel in
        BikeShareCityViewModel(id: bikeShareCity.id, href: bikeShareCity.href, bikeShareName: bikeShareCity.name, location: bikeShareCity.location)
    }
    
    return viewModels
}
