//
//  MapWorkerTests.swift
//  BikeShareTests
//
//  Created by Daniel Slone on 3/30/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import XCTest

@testable import BikeShare

class MapWorkerTests: XCTestCase {
    private class MockMapService: MapService {
        func getBikeShareCities(addressString: String?, completion: @escaping (MapServiceResponseHandler) -> ()) {
//            if let url = addressString, !url.isEmpty {
//                let path = Bundle(for: type(of: self)).path(forResource: "BikeShareCitySuccess", ofType: "json")!
//                let data = NSData(contentsOfFile: path)! as Data
//
//                //completion(Result<BikeShareCityResponse>.success(bikeShareCityResponse!))
//            } else {
//                let error = NSError(domain: "", code: 404, userInfo: nil)
//                completion(Result.failure(error))
//            }
        }
    }
    
     var mapWorker: MapWorker!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let service = MockMapService()

        mapWorker = MapWorker(mapService: service)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetBikeShareCities() {
        mapWorker.getBikeShareCities(addressString: "https://api.citybik.es/v2/networks") { result in
//            switch result {
//            case .success(let bikeShareCities):
//                let bikeShareCity = bikeShareCities.networks!.first!
//                let location = bikeShareCity.location!
//                assert(bikeShareCity.href == "/v2/networks/bbbike")
//                assert(bikeShareCity.id == "bbbike")
//                assert(bikeShareCity.name == "BBBike")
//                assert(location.city == "Bielsko-Biała")
//                assert(location.country == "PL")
//                assert(location.latitude == 49.8225)
//                assert(location.longitude == 19.044444)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
        }
        
        mapWorker.getBikeShareCities(addressString: "") { result in
//            switch result {
//            case .success(_): break
//            case .failure(let error):
//                assert(error.localizedDescription == "The operation couldn’t be completed. ( error 404.)")
//            }
        }
    }
}
