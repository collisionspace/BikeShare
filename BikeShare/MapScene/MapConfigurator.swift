//
//  MapConfigurator.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

class MapConfigurator {
    
    static let sharedInstance = MapConfigurator()
    
    private init() {}
    
    func configure(viewController: MapViewController) {
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
}

