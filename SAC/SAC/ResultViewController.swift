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
    var results: [Shop]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMapView()
        configureResultTableView()
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
        mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: zoomScale)
    }
}

extension ResultViewController: UITableViewDelegate {
    
    func configureResultTableView() {
        let shop1 =  Shop (name: "Shop1", shopId: "1", contactNumber: "99559944922", latitude: 12.96099, longitude: 80.24099, address: "Perungudi - 635001")
        let shop2 =  Shop (name: "Shop2", shopId: "2", contactNumber: "9955991223", latitude: 12.96092, longitude: 80.24092, address: "Perungudi - 635001")
        results = []
        results?.append(shop1)
        results?.append(shop2)
        
        results?.forEach({ (shop) in
            let locationCoordinate = CLLocationCoordinate2DMake(shop.latitude, shop.longitude)
            addShopMarkerTag(title: shop.name, position: locationCoordinate, snippet: shop.contactNumber, toMap: mapView)
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedShop = results?[indexPath.row]
        if let shop = selectedShop {
            print(shop.name)
        }
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (results?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedShop = results?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell") as! ShopCell
        if let shop = selectedShop {
            cell.configureCell(shop: shop)
        }
        return cell
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

