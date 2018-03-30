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
    func passDataToBikeList(segue: UIStoryboardSegue)
}
protocol MapDataStorePassing {
    var dataStore: MapDataStore? { get }
}
class MapRouter: MapRouterDelegate, MapDataStorePassing {
    weak var viewController: MapViewController?
    var dataStore: MapDataStore?
    
    func navigateToBikeList() {
        viewController?.performSegue(withIdentifier: "GoToBikeList", sender: nil)
    }
    
    func passDataToBikeList(segue: UIStoryboardSegue) {
        let destinationVC =  segue.destination as! BikeShareViewController
        var destinationDS = destinationVC.router?.dataStore
        destinationDS?.viewModels = dataStore?.viewModels
    }
}
