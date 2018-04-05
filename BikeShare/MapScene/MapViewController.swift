//
//  MapViewController.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 3/29/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit
import Mapbox

protocol MapDisplay: class {
    func displayBikeShareCities(viewModel: [BikeShareCityViewModel]?)
    func displayError(title: String, message: String, buttonTitle: String)
    func showActivityIndicatorView()
    func hideActivityIndicatorView()
}
class MapViewController: UIViewController, MapDisplay {

    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var tabBar: UITabBar!
    
    var interactor: MapUseCase?
    var router: (MapRouterDelegate & MapDataStorePassing)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MapConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToBikeList(segue: segue)
    }
    
    func displayBikeShareCities(viewModel: [BikeShareCityViewModel]?) {
        if let viewModel = viewModel {
            interactor?.setViewModels(viewModels: viewModel)
            for index in 0..<viewModel.count {
                createAnnotation(viewModel: viewModel[index])
            }
        }
    }
    
    func displayError(title: String, message: String, buttonTitle: String) {
        
    }
    
    func showActivityIndicatorView() {
        
    }
    
    func hideActivityIndicatorView() {
        
    }
    
    // MARK: Private Functions
    
    private func setup() {
        LocationServices.shared.delegate = self
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        self.tabBar.delegate = self
        interactor?.getBikeShareCities()
    }
    
    private func createAnnotation(viewModel: BikeShareCityViewModel) {
        let city = MGLPointAnnotation()
        city.coordinate = CLLocationCoordinate2D(latitude: (viewModel.location?.latitude)!, longitude: (viewModel.location?.longitude)!)
        city.title = viewModel.bikeShareName
        city.subtitle = viewModel.cityCountry
    
        mapView.addAnnotation(city)
    }
}

extension MapViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        router?.navigateToBikeList()
    }
}

extension MapViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

extension MapViewController: LocationChangeDelegate {
    func locationChange(location: CLLocation) {
        mapView.setCenter(location.coordinate, zoomLevel: 14, animated: false)
    }
}
