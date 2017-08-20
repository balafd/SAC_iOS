//
//  ProductAddViewController.swift
//  SAC
//
//  Created by Girish Koundinya on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import SwiftForms

class ProductAddViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none

        let section1 = FormSectionDescriptor(headerTitle: "Add Product", footerTitle: "");
        var row = FormRowDescriptor(tag: "tagname", type: .email, title: "Tag")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "button", type: .button, title: "Add Product")
        section1.rows.append(row)
        
        form.sections = [section1]
        self.form = form

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let addProduct : UIBarButtonItem = UIBarButtonItem(title: "Scan Product", style: .plain, target: self, action: #selector(ProductAddViewController.showQR))
        self.navigationItem.rightBarButtonItem = addProduct
    }

    @objc func showQR(){
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
