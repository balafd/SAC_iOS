//
//  ShopViewController.swift
//  SAC
//
//  Created by Girish Koundinya on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webService = MockService.init()
        let shopID = UserDefaults.standard.integer(forKey: "shopID")

        webService.fetchShopDetail(shopID: shopID) { (shop, tags, otherDetails) in
            print(shop)
         
            if let myShop = shop {
                self.nameLabel.text = "Name : " + shop!.name
                self.ownerLabel.text = "Owner : " + shop!.ownerName
            }
            
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let addProduct : UIBarButtonItem = UIBarButtonItem(title: "Add Product", style: .plain, target: self, action: Selector(""))
        self.navigationItem.rightBarButtonItem = addProduct
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
