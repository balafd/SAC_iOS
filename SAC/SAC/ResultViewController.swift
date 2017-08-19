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
    @IBOutlet weak var recentreButton: UIButton!
    
    let zoomScale: Float = 14.0
    var isMyLocationMarkerAdded: Bool = false
    var results: [Shop]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMapView()
        configureMapStyle()
        populateResults()
        recentreButton.isHidden = true
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
        mapView.delegate = self
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
    
    func configureMapStyle() {
        
        let mapStyleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json")
        do {
            let nightStyle = try GMSMapStyle.init(contentsOfFileURL: mapStyleURL!)
            mapView.mapStyle = nightStyle
        } catch {
            print(error)
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
    
    func populateResults() {
        self.results?.forEach({ (shop) in
            self.addShopMarkerTag(shop: shop, toMap: self.mapView)
        })
        self.resultTableView.reloadData()
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
        cell.delegate = self
        if let shop = selectedShop {
            cell.configureCell(shop: shop)
        }
        return cell
    }
}

extension ResultViewController : ShopCellProtocol {
    func didTapCall(shop: Shop) {
        
        let phone = "tel://\(shop.contactNumber)"
        if let url = URL(string: phone) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }
}

extension ResultViewController : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if mapView.selectedMarker != marker {
            CATransaction.begin()
            CATransaction .setAnimationDuration(2.0)
            let maxZoom: Float = 19.0
            let bearing: CLLocationDirection = 50
            let viewAngle: Double = 60
            let camera = GMSCameraPosition.init(target: marker.position, zoom: maxZoom, bearing: bearing, viewingAngle: viewAngle)
            mapView.animate(to: camera)
            recentreButton.isHidden = false
        } else {
            return false
        }
        return true
    }
    
    @IBAction  func recentreToMyLocation(_ sender: Any) {
        if let myLocation = mapView.myLocation {
            updateMyCurrentLocation(location: myLocation)
        }
        recentreButton.isHidden = true
    }
}

extension UIViewController  {
    
    func addShopMarkerTag(shop: Shop, toMap: GMSMapView) {
        let marker = GMSMarker()
        let position = CLLocationCoordinate2DMake(shop.latitude, shop.longitude)
        marker.position = position
        marker.title = shop.name
        marker.snippet = shop.contactNumber
        marker.map = toMap
    }
}

