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
    func display(regions: [String])
}
class MapViewController: UIViewController, MapDisplay {

    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var tabBar: UITabBar!
    
    var interactor: MapUseCase?
    var router: (MapRouterDelegate & MapDataStorePassing)?
    private var regions = [String]()
    private var annotations = [MGLPointAnnotation]()
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
        mapView.removeAnnotations(annotations)
        if let viewModel = viewModel {
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

    
    func display(regions: [String]) {
        self.regions = regions
        collectionViewSetup()
    }
    
    // MARK: Private Functions
    
    private func setup() {
        LocationServices.shared.delegate = self
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        self.tabBar.delegate = self
        interactor?.getBikeShareCities()
        interactor?.getRegions()
    }
    
    private func createAnnotation(viewModel: BikeShareCityViewModel) {
        guard let location = viewModel.location,
              let latitude = location.latitude,
              let longitude = location.longitude else { return }
        let city = MGLPointAnnotation()
        city.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        city.title = viewModel.bikeShareName
        city.subtitle = viewModel.cityCountry
    
        mapView.addAnnotation(city)
        annotations.append(city)
    }

    private func collectionViewSetup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 30)

        let regionCollectionView = RegionCollectionView(regions: self.regions, frame: .zero, collectionViewLayout: layout)
        regionCollectionView.regionCollectionDelegate = self
        self.view.addSubview(regionCollectionView)
        regionCollectionView.setupConstraints(view: self.view)
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
        mapView.setCenter(location.coordinate, zoomLevel: 8, animated: false)
    }
}

extension MapViewController: RegionCollectionDelegate {
    func  didSelect(region: String) {
        interactor?.filterBy(region: region)
    }
}
