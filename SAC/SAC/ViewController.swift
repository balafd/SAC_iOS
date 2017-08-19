//
//  ViewController.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var myCurrentLocation : CLLocation?
    let locationManager = CLLocationManager()
    let webService = MockService.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Shop Around The Corner"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupLocationManager(locationManager)
    }
    func configureProductSearchBar() {
        searchBar.placeholder = "Enter product name, eg: Shampoo"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        if let location = myCurrentLocation {
            webService.fetchShops(searchText: "SearchText", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { (shops) in
                
                if let resultShops = shops {
                    print(resultShops)
                } else {
                    print("Error in Fetching")
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func setupLocationManager(_ locationManager: CLLocationManager) {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        myCurrentLocation = manager.location!
    }
}

