//
//  MapWorkerTests.swift
//  BikeShareTests
//
//  Created by Daniel Slone on 12/8/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import XCTest

class MapWorkerTests: XCTestCase {

    class MockMapService: MapService {
        func getBikeShareCities(addressString: String?, completion: @escaping (ApiResponse<BikeShareCityResponse, Error>) -> Void) {
            if addressString != "", let url = Bundle.main.url(forResource: "BikeShareCitySuccess", withExtension: "json") {
                do {
                    let jsonData = try Data(contentsOf: url)
                    let json: BikeShareCityResponse = try BikeShareCityResponse(jsonData: jsonData)
                    completion(.success(result: json))
                } catch {
                    let error = NSError(domain: "", code: 404, userInfo: nil)
                    completion(.failed(error: error))
                }
            } else {
                let error = NSError(domain: "", code: 404, userInfo: nil)
                completion(.failed(error: error))
            }
        }
    }

    var mapWorker: MapWorker!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let service = MockMapService()
        
        mapWorker = MapWorker(mapService: service)
    }

    func testGetBikeShareCities() {
        mapWorker.getBikeShareCities(addressString: "https://api.citybik.es/v2/networks") { (result) in
            switch result {
            case .success(let bikeShareCities):
                let bikeShareCity = bikeShareCities.networks!.first!
                let location = bikeShareCity.location!
                assert(bikeShareCity.href == "/v2/networks/bbbike")
                assert(bikeShareCity.id == "bbbike")
                assert(bikeShareCity.name == "BBBike")
                assert(location.city == "Bielsko-Biała")
                assert(location.country == "PL")
                assert(location.latitude == 49.8225)
                assert(location.longitude == 19.044444)
            case .failed(_): break
            }
        }

        mapWorker.getBikeShareCities(addressString: "") { result in
            switch result {
            case .success(_): break
            case .failed(let error):
                assert(error.localizedDescription == "The operation couldn’t be completed. ( error 404.)")
            }
        }
    }
}
