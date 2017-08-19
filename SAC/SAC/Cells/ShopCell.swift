//
//  ShopCell.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit

protocol ShopCellProtocol: class {
    func didTapCall(onShop: Shop)
}

class ShopCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    var shop: Shop?
    weak var delegate: ShopCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(shop: Shop) {
        self.shop = shop
        nameLabel.text = shop.name
        contactNumberLabel.text = shop.contactNumber
    }
    
    @IBAction func didTapCall(_ sender: Any) {
        
        if let tappedShop = self.shop {
            self.delegate?.didTapCall(onShop: tappedShop)
        }
    }
}
