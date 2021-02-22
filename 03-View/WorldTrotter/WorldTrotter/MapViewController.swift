//
//  MapViewController.swift
//  WorldTrotter
//
//  This view is contructed programmatically
//
//  Created by sainho on 27.01.21.
//  Copyright © 2021 Big Nerd Ranch. All rights reserved.
//


import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!

    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
        // Set it as *the* view of this view controller
        self.view = mapView
    
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")

        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(segmentedControl)
        
        let safeArea = self.view.safeAreaLayoutGuide
        let margins = self.view.layoutMarginsGuide
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // label
        let label = UILabel()
        label.text = "Points of Interest"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        let labelTopConstraint = label.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10)
        let labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)
        
        labelTopConstraint.isActive = true
        labelLeadingConstraint.isActive = true
        
        // switch
        let pointSwitch = UISwitch()
        pointSwitch.isOn = true // set default as true
        
        pointSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pointSwitch)
        
        let switchCenterYConstraint = pointSwitch.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        let switchLeadingConstraint = pointSwitch.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10)
        
        switchCenterYConstraint.isActive = true
        switchLeadingConstraint.isActive = true
        
        pointSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
    }
    
    override func viewDidLoad() {
        print("MapViewController has loaded its view.")
    }
        
    func checkLocationServices() {
        guard LocationManager.sharedInstance.systemLocationServicesEnabled() else {
            let alert = UIAlertController(title: "WorldTrotter works best with Location Services truned on", message: "You'll get your location when you turn on Location Services.", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: NSLocalizedString("Turn on in Setting", comment: "Default action"),
                              style: .default,
                              handler: {_ in
                                NSLog("The \"Turn on in Setting\" alert occured.")
                            }))
            alert.addAction(
                UIAlertAction(title: NSLocalizedString("Keep Location Services Off", comment: ""),
                              style: .default,
                              handler: {_ in
                                NSLog("The \"Keep Location Services Off\" alert occured.")
                              }))
            self.present(alert, animated: true, completion: nil)
            // TODO: 实现从弹窗跳转到系统设置的逻辑
            return
        }
        
        LocationManager.sharedInstance.checkLocationAuthorization()
        
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .hybrid
            case 2:
                mapView.mapType = .satellite
            default:
                break
            }
    }
    
    @objc func switchValueChanged(_ pointSwitch: UISwitch){
        let categories:[MKPointOfInterestCategory] = []
        let filters = MKPointOfInterestFilter(including: categories)
        
        switch pointSwitch.isOn {
            case true:
                mapView.pointOfInterestFilter = nil
                
            case false:
                mapView.pointOfInterestFilter = .some(filters)
                
        }
    }
    
    // MARK: Funcs in the MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        self.checkLocationServices()
        
        let userCoordinate = mapView.userLocation.coordinate
        let radius: CLLocationDistance = 10
        let region = MKCoordinateRegion(center: userCoordinate,
                                        latitudinalMeters: radius,
                                        longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)

    }
}
