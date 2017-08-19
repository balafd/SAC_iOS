//
//  ViewController.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import GoogleMaps
import MBProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var myCurrentLocation : CLLocation?
    let locationManager = CLLocationManager()
    let webService = MockService.init()
    var results: [Shop]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Shop Around The Corner"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupLocationManager(locationManager)
        configureProductSearchBar()
    }
    func configureProductSearchBar() {
        searchBar.placeholder = "Enter product name, eg: Shampoo"   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func tappedSearchButton(_ sender: Any) {

        self.showProgressHUD()
        searchForShops()
    }
    
    func searchForShops() {
        if let location = myCurrentLocation {
            webService.fetchShops(tagID: "SearchText", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { (shops) in
                
                if let resultShops = shops {
                    print(resultShops)
                    self.results = resultShops
                    self.performSegue(withIdentifier: "ResultsPage", sender: nil)
                } else {
                    print("Error in Fetching")
                }
                self.hideProgressHUD()
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsPage" {
            if let resultViewController = segue.destination as? ResultViewController {
                resultViewController.results = results
            }
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

extension UIViewController {
    
    func showProgressHUD() {        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.contentColor = UIColor.green
        hud.bezelView.color = UIColor.black
        hud.bezelView.style = .blur
        hud.bezelView.alpha = 0.8
    }
    
    func hideProgressHUD() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}

