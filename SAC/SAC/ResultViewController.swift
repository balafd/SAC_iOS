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
    let zoomScale: Float = 14.0
    
    var isMyLocationMarkerAdded: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMapView()
    }
    
    @IBAction func goBackToSearchView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ResultViewController {
    
    func configureMapView() {
        let randomLatitude = -33.868
        let randomtLongitude = 151.2086
        let camera = GMSCameraPosition.camera(withLatitude:randomLatitude, longitude: randomtLongitude, zoom: zoomScale)
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
}

extension ResultViewController {
    
    func configureResultTableView() {
        
    }
}

extension UIViewController  {
    
    func addShopMarkerTag(title: String, position: CLLocationCoordinate2D, snippet: String, toMap: GMSMapView) {
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        marker.snippet = snippet
        marker.map = toMap
    }
}

