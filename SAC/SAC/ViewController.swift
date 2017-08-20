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
    let locationManager = CLLocationManager()
    let webService = SACWebService.init()
    var results: [Shop]? = [Shop]()
    var tagSuggestions: [Tag]? = [Tag]()
    
    @IBOutlet weak var registerShop: UIButton!
    @IBOutlet weak var tagsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Shop Around The Corner"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupLocationManager(locationManager)
        configureProductSearchBar()
        configureTagsTableView()
        var shopID = UserDefaults.standard.integer(forKey: "shopID")
        shopID = 674
        UserDefaults.standard.set(shopID, forKey: "shopID")
        UserDefaults.standard.set(true, forKey: "hasRegistered")
    }
    
    func registerButtonEvents(){
        let hasRegiseterd = UserDefaults.standard.bool(forKey: "hasRegistered");
        if (hasRegiseterd){
            registerShop.setTitle("Go to Shop", for: .normal)
        } else {
            registerShop.setTitle("Register a Shop", for: .normal)
        }
    }
    
    @IBAction func shopAction(_ sender: Any) {
        let hasRegiseterd = UserDefaults.standard.bool(forKey: "hasRegistered");
        if (hasRegiseterd) {
            goToShop()
        } else {
            goToRegister()
        }
    }
    
    func goToShop(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewShop") as! ShopViewController
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }
    
    func goToRegister(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }
    
    func configureTagsTableView(){
        tagsTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        tagsTableView.keyboardDismissMode = .onDrag;
    }
    
    func configureProductSearchBar() {
        searchBar.placeholder = "eg: Tea"
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        registerButtonEvents()
    }
    
    func searchForShops(tagID: Int) {
        if let appDelegate = UIApplication.shared .delegate as? AppDelegate {
            if let location = appDelegate.myCurrentLocation {
                webService.fetchShops(tagID: tagID, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { (shops) in
                    
                    if let resultShops = shops {
                        print(resultShops)
                        self.handleShopResult(result: resultShops)
                    } else {
                        print("Error in Fetching")
                    }
                    self.hideProgressHUD()
                })
            }
        }
    }
    
    func handleShopResult(result: [Shop]) {
        self.results = result
        if result.count > 0 {
            self.performSegue(withIdentifier: "ResultsPage", sender: nil)
        } else {
            let alert = UIAlertController.init(title: "Alert!", message: "Nothing found", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { Void in
                
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func suggestTags()  {
        let webS = SACWebService.init()
        
        webS.searchSuggestions(searchText: searchBar.text!) { (tagResult) in
            if let tags = tagResult {
                print("tags :")
                print(tags)
                self.tagSuggestions = tags
                self.tagsTableView.reloadData()
            }
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
        if let appDelegate = UIApplication.shared .delegate as? AppDelegate {
            appDelegate.myCurrentLocation = manager.location!
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tagSuggestions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tag = tagSuggestions?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagSuggestionCell") as! UITableViewCell
        cell.selectionStyle = .none;
        cell.textLabel?.text = tag?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let tag = tagSuggestions?[indexPath.row] {
            searchBar.text = tag.name
            self.showProgressHUD()
            searchForShops(tagID: tag.id)
        }
    }
}

extension ViewController : UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let oldString = searchBar.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,
                                                          with: text)
            if newString.count >= 2 {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(ViewController.suggestTags), object: nil)
                self.perform(#selector(ViewController.suggestTags), with: nil, afterDelay: 0.4)
            }
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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

