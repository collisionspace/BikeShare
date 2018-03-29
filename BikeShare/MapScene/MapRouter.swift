//
//  MapRouter.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit
protocol MapRouterDelegate {
    func navigateToBikeList()
}
class MapRouter: MapRouterDelegate {
    weak var viewController: MapViewController?

    func navigateToBikeList() {
        viewController?.performSegue(withIdentifier: "GoToBikeList", sender: nil)
    }
}
