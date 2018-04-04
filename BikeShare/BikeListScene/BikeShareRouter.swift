//
//  BikeShareRouter.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

protocol BikeShareRouterDelegate {

}
class BikeShareRouter: BikeShareRouterDelegate {
    weak var viewController: BikeShareViewController?
    var dataStore: BikeShareDataStore?
}
