//
//  BikeShareWorkerTests.swift
//  BikeShareTests
//
//  Created by Daniel Slone on 3/28/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import XCTest
import Alamofire
import ObjectMapper

@testable import BikeShare

class BikeShareWorkerTests: XCTestCase {
    private class MockBikeShareService: BikeShareService {
        func getBikeShareCities(completion: @escaping BikeShareService.BikeShareServiceCompletionHandler) {
            let path = Bundle(for: type(of: self)).path(forResource: "BikeShareCitySuccess", ofType: "json")!
            let data = NSData(contentsOfFile: path)! as Data

            let dic = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
            

            let bikeShareCityResponse = Mapper<BikeShareCityResponse>().map(JSON: dic)
            
            
            completion(Result.success(bikeShareCityResponse!))
        }
    }
    
    private var mockBikeShareService: MockBikeShareService!
    
    override func setUp() {
        super.setUp()
       
       mockBikeShareService = MockBikeShareService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetBikeShareCities() {
        mockBikeShareService.getBikeShareCities { result in
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
