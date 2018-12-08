//
//  MapInteractor.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

protocol MapUseCase {
    func getBikeShareCities()
    func setViewModels(viewModels: [BikeShareCityViewModel])
    func getRegions()
    func filterBy(region: String)
}
protocol MapDataStore {
    var viewModels: [BikeShareCityViewModel]? { get }
}
private enum Constants {
    static let baseUrl = "https://api.citybik.es/v2/"
    static let bikeShareEndPoint = "networks"
}
class MapInteractor: MapUseCase, MapDataStore {
    var presenter: MapPresenter?
    var worker: MapWorker
    var viewModels: [BikeShareCityViewModel]? {
        didSet {
            filterByRegionCache()
        }
    }

    private var regions: Regions?
    private var filteredRegion = [String: [BikeShareCityViewModel]]()

    init() {
        worker = MapWorker(mapService: MapRequest())
    }
    
    func getBikeShareCities() {
        worker.getBikeShareCities(addressString: Constants.baseUrl + Constants.bikeShareEndPoint) { result in
            switch result {
            case .success(let bikeShareCities):
                guard let networks = bikeShareCities.networks else { return }
                let viewModels = mapDataToViewModels(response: networks)
                self.viewModels = viewModels
                self.presenter?.presentBikeShareCities(response: viewModels)
            case .failed(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func setViewModels(viewModels: [BikeShareCityViewModel]) {
        self.viewModels = viewModels
    }

    func regionNames() -> [String] {
        guard let regions = self.regions else { return [] }
        return regions.regions.reduce(["All"]) { (regionNames, value) in
            var copy = regionNames
            copy.append(value.name)
            return copy
        }
    }

    func getRegions() {
        let regionService = RegionRequest()
        regionService.getRegions { result in
            switch result {
            case .success(let response):
                self.regions = response
                self.presenter?.present(regions: self.regionNames())
            case .failed(let error):
                print("region \(error.localizedDescription)")
            }
        }
    }

    func filterBy(region: String) {
        guard let regionBikes = self.filteredRegion[region] else { return }
        self.presenter?.presentBikeShareCities(response: regionBikes)
    }

    private func filterByRegionCache() {
        guard let regions = self.regions, let bikeShareCities = self.viewModels else { return }
        DispatchQueue.main.async {
            for region in regions.regions {
                let filtered = bikeShareCities.filter { city in
                    guard let lowercased = city.location?.country?.lowercased() else { return false }
                    return region.countryAbbreviations.contains(lowercased)
                }
                self.filteredRegion.updateValue(filtered, forKey: region.name)
            }
            self.filteredRegion.updateValue(bikeShareCities, forKey: "All")
        }
    }
}
