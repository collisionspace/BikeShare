//
//  Regions.swift
//  BikeShare
//
//  Created by Daniel Slone on 12/8/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

struct Regions: Codable {
    let regions: [Region]

    enum CodingKeys: String, CodingKey {
        case regions
    }
}
struct Region: Codable {
    let name: String
    let countryAbbreviations: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case countryAbbreviations = "abbreviations"
    }
}
