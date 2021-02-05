//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by sainho on 27.01.21.
//  Copyright © 2021 Big Nerd Ranch. All rights reserved.
//


import UIKit
import MapKit


class MapViewController: UIViewController {
    var mapView: MKMapView!

    override func loadView() {
        // Create a map view
        mapView = MKMapView()

        // Set it as *the* view of this view controller
        self.view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
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
        
        LocationManager.sharedInstance.checkLocationAuthorization()
    }
    
    override func viewDidLoad() {
        
        print("MapViewController has loaded its view.")
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
}
