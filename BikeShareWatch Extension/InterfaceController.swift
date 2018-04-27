//
//  InterfaceController.swift
//  BikeShareWatch Extension
//
//  Created by Daniel on 4/16/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        LocationServices.shared.delegate = self
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: LocationServicesEnabledDelegate {
    func isLocationServicesEnabled(result: LocationServicesResult) {
        
    }
}

extension InterfaceController: LocationChangeDelegate {
    func locationChange(location: CLLocation) {
        print(location)
    }
}
