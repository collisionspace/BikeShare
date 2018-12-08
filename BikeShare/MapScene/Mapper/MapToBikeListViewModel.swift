//
//  BikeListMapper.swift
//  BikeShare
//
//  Created by Daniel Slone on 4/10/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

func mapToBikeListViewModel(bikeShareViewModels: [BikeShareCityViewModel]) -> [BikeListViewModel]  {
    let viewModels = bikeShareViewModels.map {
        (bikeShareCityViewModel: BikeShareCityViewModel) -> BikeListViewModel in
        BikeListViewModel(id: bikeShareCityViewModel.id,
                          href: bikeShareCityViewModel.href,
                          bikeShareName: bikeShareCityViewModel.bikeShareName,
                          location: BikeShareLocation(city: bikeShareCityViewModel.location?.city,
                                                      country: bikeShareCityViewModel.location?.country,
                                                      latitude: bikeShareCityViewModel.location?.latitude,
                                                      longitude: bikeShareCityViewModel.location?.longitude))
    }
    
    return viewModels
}
