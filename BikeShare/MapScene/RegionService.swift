//
//  RegionService.swift
//  BikeShare
//
//  Created by Daniel Slone on 12/8/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

protocol RegionService {
    typealias RegionServiceResponseHandler = (ApiResponse<Regions, Error>) -> Void
    
    func getRegions(completion: @escaping  (ApiResponse<Regions, Error>) -> Void)
}
class RegionRequest: RegionService {

    func getRegions(completion: @escaping  (ApiResponse<Regions, Error>) -> Void) {
        let url = Bundle.main.url(forResource: "region_abbreviations", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let json = try Regions.init(jsonData: jsonData)
            completion(.success(result: json))
        } catch {
            print(error)
        }
    }
}
