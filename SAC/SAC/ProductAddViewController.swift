//
//  ProductAddViewController.swift
//  SAC
//
//  Created by Girish Koundinya on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import SwiftForms
import DYQRCodeDecoder

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
        qrReader()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProductAddViewController {
    
    func qrReader() {
        
        guard let reader =  DYQRCodeDecoderViewController.init(completion: { (succeeded, result) in
            self.form.sections[0].rows[0].value = "Pencils" as AnyObject
            self.tableView.reloadData()
        }) else {
            return
        }
        reader.rightBarButtonItem = nil
        reader.needsScanAnnimation = true
        
        let navi = UINavigationController.init(rootViewController: reader)
        present(navi, animated: true) {
        }
    }
}

