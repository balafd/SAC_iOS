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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Shop Around The Corner"
    }

    func configureProductSearchBar() {
        searchBar.placeholder = "Enter product name, eg: Shampoo"
        
    }
    
    func animateSearchBar() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

