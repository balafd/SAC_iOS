//
//  ResultViewController.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import GoogleMaps

class ResultViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var resultTableView: UITableView!
    
    var isMyLocationMarkerAdded: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        configureMapView()
    }
    
    func configureMapView() {
        
        let camera = GMSCameraPosition.camera(withLatitude:-33.868, longitude: 151.2086, zoom: 14)
        mapView.camera = camera
        mapView.settings.compassButton = false
        mapView.settings.myLocationButton = false
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        // Ask for My Location data after the map has already been added to the UI.
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.mapView.isMyLocationEnabled = true
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let locationChange = change {
            if let myCurrentLocation = locationChange[NSKeyValueChangeKey.newKey] {
                let location = myCurrentLocation as! CLLocation
                updateMyCurrentLocation(location: location)
            }
        }
    }

    func updateMyCurrentLocation(location: CLLocation) {
        mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 14)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

