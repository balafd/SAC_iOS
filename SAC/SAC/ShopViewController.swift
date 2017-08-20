//
//  ShopViewController.swift
//  SAC
//
//  Created by Girish Koundinya on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController  {

    @IBOutlet weak var trends: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var myInventoryTrendingTags: [TrendingTag]? = [TrendingTag]()
    var suggestedTrendingTags: [TrendingTag]? = [TrendingTag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webService = MockService.init()
        let shopID = UserDefaults.standard.integer(forKey: "shopID")

        webService.fetchShopDetail(shopID: shopID) { (shop, inventoryTags, suggestedTrendingTags) in
            if let _ = shop {
                self.nameLabel.text = "Name : " + shop!.name
                self.ownerLabel.text = "Owner : " + shop!.ownerName
            }
            self.myInventoryTrendingTags =  inventoryTags
            self.suggestedTrendingTags =  suggestedTrendingTags
            self.trends.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //This goes to qr
        let addProduct : UIBarButtonItem = UIBarButtonItem(title: "Add Product", style: .plain, target: self, action: Selector(""))
        self.navigationItem.rightBarButtonItem = addProduct
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension ShopViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return (myInventoryTrendingTags?.count)!
        case 1:
            return (suggestedTrendingTags?.count)!
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendCell", for: indexPath) as? TrendViewCell  else {
            fatalError("The dequeued cell is not an instance of TrendCell.")
        }
        let source = indexPath.section == 0 ? myInventoryTrendingTags : suggestedTrendingTags
        let trendingTag = source![indexPath.row]
        cell.trendname.text = trendingTag.tag.name
        cell.count.text = "\(trendingTag.count)"
        return cell
    }
    
}
