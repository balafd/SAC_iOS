//
//  RegisterViewController.swift
//  SAC
//
//  Created by Girish Koundinya on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import SwiftForms

class RegisterViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        createForm()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func createForm(){
        let form = FormDescriptor()
        form.title = "Example form"
        
        // Define first section
        let section1 = FormSectionDescriptor(headerTitle: "Create shop", footerTitle: "");
        
        var row = FormRowDescriptor(tag: "name", type: .email, title: "Name")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "phone", type: .phone, title: "Phone Number")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "address", type: .multilineText, title: "Address")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "owner", type: .text, title: "Owner")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "tags", type: .multilineText, title: "Tags")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "button", type: .button, title: "Submit")
        row.configuration.button.didSelectClosure = { _ in
            
            var name: String?
            var address: String?
            var owner: String?
            var phone: String?
            var tags: String?
            
            self.form.formValues().forEach({ (result) in
                let key = result.key
                let value = result.value
                
                if key == "name" {
                    name = value as? String
                } else if key == "address" {
                    address = value as? String
                } else if key == "owner" {
                    owner = value as? String
                } else if key == "phone" {
                    phone = value as? String
                } else if key == "tags" {
                    tags = value as? String
                }
            })
            
            self.showProgressHUD()
            if let appDelegate = UIApplication.shared .delegate as? AppDelegate {
                if let location = appDelegate.myCurrentLocation {
                    let shop = Shop.init(id: 1, name: name!, phone: phone!, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: address!, ownerName: owner!)
                    let webService = SACWebService.init()
                    webService.registerShop(shop: shop, description: "Shop Description", tags: tags!, completion: { (myShopID) in
                        if myShopID != nil {
                            UserDefaults.standard.set(true, forKey: "hasRegistered")
                            UserDefaults.standard.set(myShopID!, forKey: "shopID")
                            self.hideProgressHUD()
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                }
            }
        }
        section1.rows.append(row)
        form.sections = [section1]
        self.form = form
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
