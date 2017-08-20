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
        
        let section1 = FormSectionDescriptor(headerTitle: "Add Product", footerTitle: "");
        var row = FormRowDescriptor(tag: "tagname", type: .email, title: "Tag")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "button", type: .button, title: "Add Product")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
