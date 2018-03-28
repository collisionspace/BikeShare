//
//  BikeShareMapper.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/28/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

func mapDataToViewModels(response: BikeShareCityResponse) -> [BikeShareCityViewModel]? {
    let viewModels = response.networks?.map {
        (bikeShareCity: BikeShareCity) -> BikeShareCityViewModel in
        BikeShareCityViewModel(href: bikeShareCity.href, bikeShareName: bikeShareCity.name, location: bikeShareCity.location)
    }
    
    return viewModels
}
