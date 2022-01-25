//
//  ViewController.swift
//  vadmitrievaPW7
//
//  Created by Varvara on 25.01.2022.
//

import UIKit
import MapKit
import CoreLocation

final class StartViewController: UIViewController {
    
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        mapView.center=view.center
        self.view.addSubview(mapView)
        configureUI()
    }
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.clipsToBounds = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        return mapView
    }()

    private func configureUI() {
        
    }
}

