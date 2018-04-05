//
//  BikeShareConfigurator.swift
//  BikeShare
//
//  Created by Daniel Slone on 3/28/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

class BikeShareConfigurator {
    
    static let sharedInstance = BikeShareConfigurator()
    
    private init() {}
    
    func configure(viewController: BikeShareViewController) {
        let interactor = BikeShareInteractor()
        let presenter = BikeSharePresenter()
        let router = BikeShareRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
}
